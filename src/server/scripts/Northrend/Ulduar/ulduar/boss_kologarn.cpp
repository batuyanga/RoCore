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
SDName: Kologarn
SDAuthor: PrinceCreed
SD%Complete: 100
SD%Comments:
EndScriptData */

#include "ScriptPCH.h"
#include "ulduar.h"
#include "Vehicle.h"

#define SPELL_ARM_DEAD_DAMAGE   RAID_MODE(63629,63979)
#define SPELL_TWO_ARM_SMASH     RAID_MODE(63356,64003)
#define SPELL_ONE_ARM_SMASH     RAID_MODE(63573,64006)
#define SPELL_STONE_SHOUT       RAID_MODE(63716,64005)
#define SPELL_PETRIFY_BREATH    RAID_MODE(62030,63980)
#define SPELL_SHOCKWAVE         RAID_MODE(63783,63982)

#define SPELL_STONE_GRIP        RAID_MODE(64290,64292)
#define SPELL_STONE_GRIP_STUN   RAID_MODE(62056,63985)
#define SPELL_ARM_SWEEP         RAID_MODE(63766,63983)
#define SPELL_FOCUSED_EYEBEAM   RAID_MODE(63347,63977)
#define SPELL_EYEBEAM_VISUAL_1  63676
#define SPELL_EYEBEAM_VISUAL_2  63702
#define SPELL_EYEBEAM_IMMUNITY  64722
#define SPELL_ARM_RESPAWN       64753
#define SPELL_SHOCKWAVE_VISUAL  63788
#define ARM_DEAD_DAMAGE         RAID_MODE(543855,2300925)

enum Events
{
    EVENT_NONE = 0,
    EVENT_SMASH,
    EVENT_GRIP,
    EVENT_SWEEP,
    EVENT_SHOCKWAVE,
    EVENT_EYEBEAM,
    EVENT_STONESHOT,
    EVENT_RIGHT,
    EVENT_LEFT
};

enum Actions
{
    ACTION_RESPAWN_RIGHT                        = 0,
    ACTION_RESPAWN_LEFT                         = 1,
    ACTION_GRIP                                 = 2
};

enum Npcs
{
    NPC_EYEBEAM_1                               = 33632,
    NPC_EYEBEAM_2                               = 33802,
    NPC_RUBBLE                                  = 33768,
    NPC_LEFT_ARM                                = 32933,
    NPC_RIGHT_ARM                               = 32934
};

enum Yells
{
    SAY_AGGRO                                   = -1603230,
    SAY_SLAY_1                                  = -1603231,
    SAY_SLAY_2                                  = -1603232,
    SAY_LEFT_ARM_GONE                           = -1603233,
    SAY_RIGHT_ARM_GONE                          = -1603234,
    SAY_SHOCKWAVE                               = -1603235,
    SAY_GRAB_PLAYER                             = -1603236,
    SAY_DEATH                                   = -1603237,
    SAY_BERSERK                                 = -1603238,
};

#define EMOTE_RIGHT      "The Right Arm has regrown!"
#define EMOTE_LEFT       "The Left Arm has regrown!"
#define EMOTE_STONE      "Kologarn casts Stone Grip!"

// Achievements
#define ACHIEVEMENT_DISARMED                  RAID_MODE(2953, 2954) // TODO
#define ACHIEVEMENT_LOOKS_COULD_KILL          RAID_MODE(2955, 2956) // TODO
#define ACHIEVEMENT_RUBBLE_AND_ROLL           RAID_MODE(2959, 2960)
#define ACHIEVEMENT_WITH_OPEN_ARMS            RAID_MODE(2951, 2952)
#define MAX_DISARMED_TIME                     12000

uint32 GripTargetGUID;

// Positiones
const Position RubbleRight = {1781.814, -3.716, 448.808, 4.211};
const Position RubbleLeft  = {1781.814, -45.07, 448.808, 2.260};

struct boss_kologarnAI : public BossAI
{
    boss_kologarnAI(Creature *pCreature) : BossAI(pCreature, BOSS_KOLOGARN), vehicle(me->GetVehicleKit()),
        left(false), right(false)
    {
        assert(vehicle);
        pInstance = pCreature->GetInstanceData();
        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED);
        me->SetStandState(UNIT_STAND_STATE_SUBMERGED);
        me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
        me->ApplySpellImmune(0, IMMUNITY_ID, 49560, true); // Death Grip jump effect
        emerged = false;
    }

    ScriptedInstance* pInstance;

    Vehicle *vehicle;
    bool left, right;
    bool Gripped;
    bool emerged;
    
    Creature* EyeBeam[2];
    Creature* RightArm;
    Creature* LeftArm;
    
    uint32 RubbleCount;

    void AttackStart(Unit *who)
    {
        me->Attack(who, true);
    }
    
    void MoveInLineOfSight(Unit *who)
    {
        // Birth animation
        if (!emerged && me->IsWithinDistInMap(who, 35.0f) && who->GetTypeId() == TYPEID_PLAYER)
        {
            me->SetStandState(UNIT_STAND_STATE_STAND);
            me->HandleEmoteCommand(EMOTE_ONESHOT_EMERGE);
            emerged = true;
        }
        ScriptedAI::MoveInLineOfSight(who);
    }

    void JustDied(Unit *victim)
    {
        // Rubble and Roll
        if (RubbleCount >= 5)
            pInstance->DoCompleteAchievement(ACHIEVEMENT_RUBBLE_AND_ROLL);
        // With Open Arms
        if (RubbleCount == 0)
            pInstance->DoCompleteAchievement(ACHIEVEMENT_WITH_OPEN_ARMS);
                
        DoScriptText(SAY_DEATH, me);
        _JustDied();
        // Hack to disable corpse fall
        me->GetMotionMaster()->MoveTargetedHome();
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
    }

    void PassengerBoarded(Unit *who, int8 seatId, bool apply)
    {
        if(who->GetTypeId() == TYPEID_UNIT)
        {
            if(who->GetEntry() == NPC_LEFT_ARM)
                left = apply;
            else if(who->GetEntry() == NPC_RIGHT_ARM)
                right = apply;
            who->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED);
            CAST_CRE(who)->SetReactState(REACT_AGGRESSIVE);
        }
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(SAY_AGGRO, me);
        _EnterCombat();
        RubbleCount = 0;
        GripTargetGUID = NULL;
        Gripped = false;
        
        if (Creature *LeftArm = CAST_CRE(me->GetVehicleKit()->GetPassenger(0)))
            LeftArm->AI()->DoZoneInCombat();
        if (Creature *RightArm = CAST_CRE(me->GetVehicleKit()->GetPassenger(1)))
            RightArm->AI()->DoZoneInCombat();
        
        events.ScheduleEvent(EVENT_SMASH, 5000);
        events.ScheduleEvent(EVENT_SWEEP, 10000);
        events.ScheduleEvent(EVENT_EYEBEAM, 10000);
        events.ScheduleEvent(EVENT_SHOCKWAVE, 12000);
        events.ScheduleEvent(EVENT_GRIP, 40000);
    }
    
    void KilledUnit(Unit* Victim)
    {
        if (!(rand()%5))
            DoScriptText(RAND(SAY_SLAY_1, SAY_SLAY_2), me);
    }
    
    void Reset()
    {
        if (RightArm = me->GetCreature(*me, pInstance->GetData64(DATA_RIGHT_ARM)))
        {
            RightArm->Respawn(true);
            RightArm->EnterVehicle(vehicle, 1);
        }
        if (LeftArm = me->GetCreature(*me, pInstance->GetData64(DATA_LEFT_ARM)))
        {
            LeftArm->Respawn(true);
            LeftArm->EnterVehicle(vehicle, 0);
        }
        _Reset();
    }
    
    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->hasUnitState(UNIT_STAT_CASTING))
            return;
                        
        if (events.GetTimer() > 15000 && !me->IsWithinMeleeRange(me->getVictim()))
            DoCastAOE(SPELL_PETRIFY_BREATH, true);
        
        if (!left && !right)
            DoCast(me, SPELL_STONE_SHOUT, true);

        switch(events.GetEvent())
        {
            case EVENT_NONE: break;
            case EVENT_SMASH:
                if (left && right)
                    if (me->IsWithinMeleeRange(me->getVictim()))
                        DoCastVictim(SPELL_TWO_ARM_SMASH, true);
                else if(left || right)
                    if (me->IsWithinMeleeRange(me->getVictim()))
                        DoCastVictim(SPELL_ONE_ARM_SMASH, true);
                events.RescheduleEvent(EVENT_SMASH, 15000);
                break;
            case EVENT_SWEEP:
                if (left)
                    DoCastAOE(SPELL_ARM_SWEEP, true);
                events.RescheduleEvent(EVENT_SWEEP, 15000);
                break;
            case EVENT_GRIP:
                if (right)
                {
                    if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 1, 100, true))
                    {
                        me->MonsterTextEmote(EMOTE_STONE, 0, true);
                        DoScriptText(SAY_GRAB_PLAYER, me);
                        GripTargetGUID = pTarget->GetGUID();
                        
                        if (pInstance)
                            if (Creature* RightArm = me->GetCreature(*me, pInstance->GetData64(DATA_RIGHT_ARM)))
                                if (RightArm->AI())
                                    RightArm->AI()->DoAction(ACTION_GRIP);
                    }
                }
                events.RescheduleEvent(EVENT_GRIP, 40000);
                break;
            case EVENT_SHOCKWAVE:
                if (left)
                {
                    DoScriptText(SAY_SHOCKWAVE, me);
                    DoCastAOE(SPELL_SHOCKWAVE, true);
                    DoCastAOE(SPELL_SHOCKWAVE_VISUAL, true);
                }
                events.RescheduleEvent(EVENT_SHOCKWAVE, urand(15000, 25000));
                break;
            case EVENT_EYEBEAM:
                if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 1, 100, true))
                {
                    if (EyeBeam[0] = me->SummonCreature(NPC_EYEBEAM_1, pTarget->GetPositionX(), pTarget->GetPositionY() + 3, pTarget->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 10000))
                    {
                        EyeBeam[0]->CastSpell(me, SPELL_EYEBEAM_VISUAL_1, true);
                        EyeBeam[0]->AI()->AttackStart(pTarget);
                    }
                    if (EyeBeam[1] = me->SummonCreature(NPC_EYEBEAM_2, pTarget->GetPositionX(), pTarget->GetPositionY() - 3, pTarget->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 10000))
                    {
                        EyeBeam[1]->CastSpell(me, SPELL_EYEBEAM_VISUAL_2, true);
                        EyeBeam[1]->AI()->AttackStart(pTarget);
                    }
                }
                events.RescheduleEvent(EVENT_EYEBEAM, 20000);
                break;
            case EVENT_RIGHT:
                if (RightArm = me->GetCreature(*me, pInstance->GetData64(DATA_RIGHT_ARM)))
                {
                    RightArm->Respawn(true);
                    RightArm->EnterVehicle(vehicle, 1);
                    DoCast(me, SPELL_ARM_RESPAWN, true);
                    me->MonsterTextEmote(EMOTE_RIGHT, 0, true);
                }
                events.CancelEvent(EVENT_RIGHT);
                break;
            case EVENT_LEFT:
                if (LeftArm = me->GetCreature(*me, pInstance->GetData64(DATA_LEFT_ARM)))
                {
                    LeftArm->Respawn(true);
                    LeftArm->EnterVehicle(vehicle, 0);
                    DoCast(me, SPELL_ARM_RESPAWN, true);
                    me->MonsterTextEmote(EMOTE_LEFT, 0, true);
                }
                events.CancelEvent(EVENT_LEFT);
                break;                
        }

        DoMeleeAttackIfReady();
    }
    
    void DoAction(const int32 action)
    {
        switch (action)
        {
            case ACTION_RESPAWN_RIGHT:
                DoScriptText(SAY_RIGHT_ARM_GONE, me);
                me->DealDamage(me, ARM_DEAD_DAMAGE); // decreases Kologarn's health by 15%
                ++RubbleCount;
                events.ScheduleEvent(EVENT_RIGHT, 30000);
                break;
            case ACTION_RESPAWN_LEFT:
                DoScriptText(SAY_LEFT_ARM_GONE, me);
                me->DealDamage(me, ARM_DEAD_DAMAGE); // decreases Kologarn's health by 15%
                ++RubbleCount;
                events.ScheduleEvent(EVENT_LEFT, 30000);
                break;
        }
    }
};

CreatureAI* GetAI_boss_kologarn(Creature* pCreature)
{
    return new boss_kologarnAI (pCreature);
}

struct mob_focused_eyebeamAI : public ScriptedAI
{
    mob_focused_eyebeamAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        me->SetReactState(REACT_PASSIVE);
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED);
        DoCast(me, SPELL_EYEBEAM_IMMUNITY);
        DoCast(me, SPELL_FOCUSED_EYEBEAM);
        checkTimer = 1500;
    }

    uint32 checkTimer;

    void UpdateAI(const uint32 diff)
    {
        if(checkTimer <= diff)
        {
            if (me->getVictim() && me->getVictim()->isAlive())
                me->GetMotionMaster()->MovePoint(0, me->getVictim()->GetPositionX(), me->getVictim()->GetPositionY(), me->getVictim()->GetPositionZ());

            checkTimer = 500;
        }
        else checkTimer -= diff;
    }
};

CreatureAI* GetAI_mob_focused_eyebeam(Creature* pCreature)
{
    return new mob_focused_eyebeamAI(pCreature);
}

// Right Arm
struct mob_right_armAI : public ScriptedAI
{
    mob_right_armAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = me->GetInstanceData();
        me->ApplySpellImmune(0, IMMUNITY_ID, 64708, true);
    }

    ScriptedInstance* m_pInstance;
    
    bool Gripped;
    uint32 ArmDamage;
    int32 SqueezeTimer;

    void Reset()
    {
        Gripped = false;
        ArmDamage = 0;
        SqueezeTimer = 0;
    }
    
    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (Gripped)
        {
            if (SqueezeTimer <= diff)
            {
                if (me->GetVehicleKit()->GetPassenger(0) && me->GetVehicleKit()->GetPassenger(0)->isAlive())
                    me->Kill(me->GetVehicleKit()->GetPassenger(0), true);
                Gripped = false;
            }
            else SqueezeTimer -= diff;
        }
    }
    
    void KilledUnit(Unit* Victim)
    {
        if (Victim)
        {
            Victim->ExitVehicle();
            Victim->GetMotionMaster()->MoveJump(1767.80, -18.38, 448.808, 10, 10);
        }
    }
    
    void JustDied(Unit *victim)
    {
        for (uint8 i = 0; i < 5; ++i)
            me->SummonCreature(NPC_RUBBLE, RubbleRight, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 3000);
            
        if (m_pInstance)
            if (Creature* pKologarn = me->GetCreature(*me, m_pInstance->GetData64(DATA_KOLOGARN)))
                if (pKologarn->AI())
                    pKologarn->AI()->DoAction(ACTION_RESPAWN_RIGHT);
                    
        // Hack to disable corpse fall
        me->GetMotionMaster()->MoveTargetedHome();
    }
    
    void JustSummoned(Creature *summon)
    {
        summon->AI()->DoAction(0);
        summon->AI()->DoZoneInCombat();
    }
    
    void DoAction(const int32 action)
    {
        switch (action)
        {
            case ACTION_GRIP:
                if (Unit* GripTarget = Unit::GetUnit(*me, GripTargetGUID))
                {
                    if (GripTarget && GripTarget->isAlive())
                    {
                        GripTarget->EnterVehicle(me, 0);
                        me->AddAura(SPELL_STONE_GRIP, GripTarget);
                        me->AddAura(SPELL_STONE_GRIP_STUN, GripTarget);
                        ArmDamage = 0;
                        SqueezeTimer = 16000;
                        GripTargetGUID = NULL;
                        Gripped = true;
                    }
                }
                break;
        }
    }
    
    void DamageTaken(Unit* pKiller, uint32 &damage)
    {
        if (Gripped)
        {
            ArmDamage += damage;
            int dmg = RAID_MODE(100000, 480000);
            
            if (ArmDamage > dmg || damage >= me->GetHealth())
            {
                Unit* pGripTarget = me->GetVehicleKit()->GetPassenger(0);
                if (pGripTarget && pGripTarget->isAlive())
                {
                    pGripTarget->RemoveAurasDueToSpell(SPELL_STONE_GRIP);
                    pGripTarget->RemoveAurasDueToSpell(SPELL_STONE_GRIP_STUN);
                    pGripTarget->ExitVehicle();
                    pGripTarget->GetMotionMaster()->MoveJump(1767.80, -18.38, 448.808, 10, 10);
                }
                pGripTarget = 0;
                Gripped = false;
            }
        }
    }
};

CreatureAI* GetAI_mob_right_arm(Creature* pCreature)
{
    return new mob_right_armAI(pCreature);
}

// Left Arm
struct mob_left_armAI : public ScriptedAI
{
    mob_left_armAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = me->GetInstanceData();
    }

    ScriptedInstance* m_pInstance;

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;
    }
    
    void JustDied(Unit *victim)
    {
        for (uint8 i = 0; i < 5; ++i)
            me->SummonCreature(NPC_RUBBLE, RubbleLeft, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 3000);
            
        if (m_pInstance)
            if (Creature* pKologarn = me->GetCreature(*me, m_pInstance->GetData64(DATA_KOLOGARN)))
                if (pKologarn->AI())
                    pKologarn->AI()->DoAction(ACTION_RESPAWN_LEFT);
                    
        // Hack to disable corpse fall
        me->GetMotionMaster()->MoveTargetedHome();
    }
    
    void JustSummoned(Creature *summon)
    {
        summon->AI()->DoAction(0);
        summon->AI()->DoZoneInCombat();
    }
};

CreatureAI* GetAI_mob_left_arm(Creature* pCreature)
{
    return new mob_left_armAI(pCreature);
}

void AddSC_boss_kologarn()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "boss_kologarn";
    newscript->GetAI = &GetAI_boss_kologarn;
    newscript->RegisterSelf();
    
    newscript = new Script;
    newscript->Name = "mob_focused_eyebeam";
    newscript->GetAI = &GetAI_mob_focused_eyebeam;
    newscript->RegisterSelf();
    
    newscript = new Script;
    newscript->Name = "mob_right_arm";
    newscript->GetAI = &GetAI_mob_right_arm;
    newscript->RegisterSelf();
    
    newscript = new Script;
    newscript->Name = "mob_left_arm";
    newscript->GetAI = &GetAI_mob_left_arm;
    newscript->RegisterSelf();
    
}
