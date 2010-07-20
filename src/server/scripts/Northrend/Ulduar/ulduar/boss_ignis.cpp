/*
 * Copyright (C) 2008-2010 TrinityCore <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/* ScriptData
SDName: Ignis the Furnace Master
SDAuthor: PrinceCreed
SD%Complete: 100
EndScriptData */

#include "ScriptPCH.h"
#include "ulduar.h"

enum Yells
{
    SAY_AGGRO                                   = -1603220,
    SAY_SLAY_1                                  = -1603221,
    SAY_SLAY_2                                  = -1603222,
    SAY_DEATH                                   = -1603223,
    SAY_SUMMON                                  = -1603224,
    SAY_SLAG_POT                                = -1603225,
    SAY_SCORCH_1                                = -1603226,
    SAY_SCORCH_2                                = -1603227,
    SAY_BERSERK                                 = -1603228,
};

enum Spells
{
    SPELL_FLAME_JETS_10                         = 62680,
    SPELL_FLAME_JETS_25                         = 63472,
    SPELL_SCORCH_10                             = 62546,
    SPELL_SCORCH_25                             = 63474,
    SPELL_SLAG_POT_10                           = 62717,
    SPELL_SLAG_POT_25                           = 63477,
    SPELL_SLAG_IMBUED_10                        = 62836,
    SPELL_SLAG_IMBUED_25                        = 63536,
    SPELL_ACTIVATE_CONSTRUCT                    = 62488,
    SPELL_STRENGHT                              = 64473,
    SPELL_GRAB                                  = 62707,
    SPELL_BERSERK                               = 47008
};

enum Events
{
    EVENT_NONE,
    EVENT_JET,
    EVENT_SCORCH,
    EVENT_SLAG_POT,
    EVENT_GRAB_POT,
    EVENT_CHANGE_POT,
    EVENT_END_POT,
    EVENT_CONSTRUCT,
    EVENT_BERSERK
};

#define EMOTE_JETS    "Ignis the Furnace Master begins to cast Flame Jets!"

enum Mobs
{
    MOB_IRON_CONSTRUCT                          = 33121,
    GROUND_SCORCH                               = 33221
};

#define ACTION_REMOVE_BUFF                        20

enum ConstructSpells
{
    SPELL_HEAT                                  = 65667,
    SPELL_MOLTEN                                = 62373,
    SPELL_BRITTLE                               = 62382,
    SPELL_SHATTER                               = 62383,
    SPELL_GROUND_10                             = 62548,
    SPELL_GROUND_25                             = 63476
};

// Achievements
#define ACHIEVEMENT_STOKIN_THE_FURNACE        RAID_MODE(2930, 2929)
#define ACHIEVEMENT_SHATTERED                 RAID_MODE(2925, 2926)
#define MAX_ENCOUNTER_TIME                    4 * 60 * 1000

// Water coords
#define WATER_1_X                                646.77
#define WATER_2_X                                526.77
#define WATER_Y                                  277.79
#define WATER_Z                                  359.88

const Position Pos[20] =
{
{630.366,216.772,360.891,3.001970},
{630.594,231.846,360.891,3.124140},
{630.435,337.246,360.886,3.211410},
{630.493,313.349,360.886,3.054330},
{630.444,321.406,360.886,3.124140},
{630.366,247.307,360.888,3.211410},
{630.698,305.311,360.886,3.001970},
{630.500,224.559,360.891,3.054330},
{630.668,239.840,360.890,3.159050},
{630.384,329.585,360.886,3.159050},
{543.220,313.451,360.886,0.104720},
{543.356,329.408,360.886,6.248280},
{543.076,247.458,360.888,6.213370},
{543.117,232.082,360.891,0.069813},
{543.161,305.956,360.886,0.157080},
{543.277,321.482,360.886,0.052360},
{543.316,337.468,360.886,6.195920},
{543.280,239.674,360.890,6.265730},
{543.265,217.147,360.891,0.174533},
{543.256,224.831,360.891,0.122173}
};

struct boss_ignis_AI : public BossAI
{
    boss_ignis_AI(Creature *pCreature) : BossAI(pCreature, BOSS_IGNIS), vehicle(me->GetVehicleKit())
    {
        assert(vehicle);
        pInstance = pCreature->GetInstanceData();
        me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
        me->ApplySpellImmune(0, IMMUNITY_ID, 49560, true); // Death Grip jump effect
    }

    Vehicle *vehicle;
    ScriptedInstance *pInstance;
    
    uint32 SlagPotGUID;
    uint32 EncounterTime;
    uint32 ConstructTimer;
    bool Shattered;

    void Reset()
    {
        _Reset();
        
        if (vehicle)
            vehicle->RemoveAllPassengers();
    }

    void EnterCombat(Unit *who)
    {
        _EnterCombat();
        DoScriptText(SAY_AGGRO, me);
        events.ScheduleEvent(EVENT_JET, 30000);
        events.ScheduleEvent(EVENT_SCORCH, 25000);
        events.ScheduleEvent(EVENT_SLAG_POT, 35000);
        events.ScheduleEvent(EVENT_CONSTRUCT, 15000);
        events.ScheduleEvent(EVENT_END_POT, 40000);
        events.ScheduleEvent(EVENT_BERSERK, 480000);
        SlagPotGUID = 0;
        EncounterTime = 0;
        ConstructTimer = 0;
        Shattered = false;
    }

    void JustDied(Unit *victim)
    {
        _JustDied();
        DoScriptText(SAY_DEATH, me);

        // Achievements
        if (pInstance)
        {
            // Shattered
            if (Shattered)
                pInstance->DoCompleteAchievement(ACHIEVEMENT_SHATTERED);
            // Stokin' the Furnace
            if (EncounterTime <= MAX_ENCOUNTER_TIME)
                pInstance->DoCompleteAchievement(ACHIEVEMENT_STOKIN_THE_FURNACE);
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if(me->GetPositionY() < 150 || me->GetPositionX() < 450 || me->getVictim()->GetTypeId() == !TYPEID_PLAYER)
        {
            me->RemoveAllAuras();
            me->DeleteThreatList();
            me->CombatStop(false);
            me->GetMotionMaster()->MoveTargetedHome();
        }

        events.Update(diff);
        EncounterTime += diff;
        ConstructTimer += diff;

        if (me->hasUnitState(UNIT_STAT_CASTING))
            return;

        while(uint32 eventId = events.ExecuteEvent())
        {
            switch(eventId)
            {
                case EVENT_JET:
                    me->MonsterTextEmote(EMOTE_JETS, 0, true);
                    DoCastAOE(RAID_MODE(SPELL_FLAME_JETS_10, SPELL_FLAME_JETS_25));
                    events.ScheduleEvent(EVENT_JET, urand(35000,40000));
                    break;
                case EVENT_SLAG_POT:
                    if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 1, 100, true))
                    {
                        DoScriptText(SAY_SLAG_POT, me);
                        SlagPotGUID = pTarget->GetGUID();
                        DoCast(pTarget, SPELL_GRAB);
                        events.DelayEvents(3000);
                        events.ScheduleEvent(EVENT_GRAB_POT, 500);
                    }
                    events.ScheduleEvent(EVENT_SLAG_POT, RAID_MODE(30000, 15000));
                    break;
                case EVENT_GRAB_POT:
                    if (Unit* SlagPotTarget = Unit::GetUnit(*me, SlagPotGUID))
                    {
                        SlagPotTarget->EnterVehicle(me, 0);
                        events.CancelEvent(EVENT_GRAB_POT);
                        events.ScheduleEvent(EVENT_CHANGE_POT, 1000);
                    }
                    break;
                case EVENT_CHANGE_POT:
                    if (Unit* SlagPotTarget = Unit::GetUnit(*me, SlagPotGUID))
                    {
                        SlagPotTarget->AddAura(RAID_MODE(SPELL_SLAG_POT_10, SPELL_SLAG_POT_25), SlagPotTarget);
                        SlagPotTarget->EnterVehicle(me, 1);
                        events.CancelEvent(EVENT_CHANGE_POT);
                        events.ScheduleEvent(EVENT_END_POT, 10000);
                    }
                    break;
                case EVENT_END_POT:
                    if (Unit* SlagPotTarget = Unit::GetUnit(*me, SlagPotGUID))
                    {
                        SlagPotTarget->ExitVehicle();
                        SlagPotTarget->CastSpell(SlagPotTarget, RAID_MODE(SPELL_SLAG_IMBUED_10, SPELL_SLAG_IMBUED_25), true);
                        events.CancelEvent(EVENT_END_POT);
                    }
                    break;
                case EVENT_SCORCH:
                    DoScriptText(RAND(SAY_SCORCH_1, SAY_SCORCH_2), me);
                    if (Unit *pTarget = me->getVictim())
                        me->SummonCreature(GROUND_SCORCH, pTarget->GetPositionX(), pTarget->GetPositionY(), pTarget->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 45000);
                    DoCast(RAID_MODE(SPELL_SCORCH_10, SPELL_SCORCH_25));
                    events.ScheduleEvent(EVENT_SCORCH, 25000);
                    break;
                case EVENT_CONSTRUCT:
                    DoScriptText(SAY_SUMMON, me);
                    DoSummon(MOB_IRON_CONSTRUCT, Pos[rand()%20], 30000, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT);
                    DoCast(SPELL_STRENGHT);
                    DoCast(me, SPELL_ACTIVATE_CONSTRUCT);
                    events.ScheduleEvent(EVENT_CONSTRUCT, RAID_MODE(40000, 30000));
                    break;
                case EVENT_BERSERK:
                    DoCast(me, SPELL_BERSERK, true);
                    DoScriptText(SAY_BERSERK, me);
                    break;
            }
        }

        DoMeleeAttackIfReady();
    }

    void KilledUnit(Unit* Victim)
    {
        if (!(rand()%5))
            DoScriptText(RAND(SAY_SLAY_1, SAY_SLAY_2), me);
    }

    void JustSummoned(Creature *summon)
    {
        if (summon->GetEntry() == MOB_IRON_CONSTRUCT)
        {
            summon->setFaction(16);
            summon->SetReactState(REACT_AGGRESSIVE);
            summon->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED | UNIT_FLAG_STUNNED | UNIT_FLAG_DISABLE_MOVE);
        }
        summon->AI()->AttackStart(me->getVictim());
        summon->AI()->DoZoneInCombat();
        summons.Summon(summon);
    }

    void DoAction(const int32 action)
    {
        switch(action)
        {
            case ACTION_REMOVE_BUFF:
                me->RemoveAuraFromStack(SPELL_STRENGHT);
                // Shattered Achievement
                if (ConstructTimer >= 5000)
                    ConstructTimer = 0;
                else Shattered = true;
                break;
        }
    }
};

CreatureAI* GetAI_boss_ignis(Creature* pCreature)
{
    return new boss_ignis_AI (pCreature);
}

struct mob_iron_constructAI : public ScriptedAI
{
    mob_iron_constructAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = c->GetInstanceData();
        me->SetReactState(REACT_PASSIVE);
    }

    ScriptedInstance* pInstance;

    bool Brittled;

    void Reset()
    {
        Brittled = false;
    }

    void DamageTaken(Unit *attacker, uint32 &damage)
    {
        if (me->HasAura(SPELL_BRITTLE) && damage >= 5000)
        {
            DoCast(SPELL_SHATTER);
            if (Creature *pIgnis = me->GetCreature(*me, pInstance->GetData64(DATA_IGNIS)))
                if (pIgnis->AI())
                    pIgnis->AI()->DoAction(ACTION_REMOVE_BUFF);
                    
            me->ForcedDespawn(1000);
        }
    }

    void UpdateAI(const uint32 uiDiff)
    {
        Map *cMap = me->GetMap();

        if (me->HasAura(SPELL_MOLTEN) && me->HasAura(SPELL_HEAT))
            me->RemoveAura(SPELL_HEAT);

        if (Aura * aur = me->GetAura((SPELL_HEAT), GetGUID()))
        {
            if (aur->GetStackAmount() >= 10)
            {
                me->RemoveAura(SPELL_HEAT);
                DoCast(SPELL_MOLTEN);
                Brittled = false;
            }
        }

        // Water pools
        if(cMap->GetId() == 603 && !Brittled && me->HasAura(SPELL_MOLTEN))
            if (me->GetDistance(WATER_1_X, WATER_Y, WATER_Z) <= 18 || me->GetDistance(WATER_2_X, WATER_Y, WATER_Z) <= 18)
            {
                DoCast(SPELL_BRITTLE);
                me->RemoveAura(SPELL_MOLTEN);
                Brittled = true;
            }

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_iron_construct(Creature* pCreature)
{
    return new mob_iron_constructAI (pCreature);
}

struct mob_scorch_groundAI : public ScriptedAI
{
    mob_scorch_groundAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED);
    }

    void Reset()
    {
        DoCast(me, RAID_MODE(SPELL_GROUND_10, SPELL_GROUND_25));
    }
};

CreatureAI* GetAI_mob_scorch_ground(Creature* pCreature)
{
    return new mob_scorch_groundAI(pCreature);
}

void AddSC_boss_ignis()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "boss_ignis";
    newscript->GetAI = &GetAI_boss_ignis;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_iron_construct";
    newscript->GetAI = &GetAI_mob_iron_construct;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_scorch_ground";
    newscript->GetAI = &GetAI_mob_scorch_ground;
    newscript->RegisterSelf();

}
