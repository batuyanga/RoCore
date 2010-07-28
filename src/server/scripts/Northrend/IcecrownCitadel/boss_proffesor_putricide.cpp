/*
* Copyright (C) 2009 - 2010 TrinityCore <http://www.trinitycore.org/>
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/
#include "ScriptPCH.h"
#include "icecrown_citadel.h"

enum Yells
{
    SAY_AGGRO        =    -1666025,
    SAY_AIRLOCK      =    -1666026,
    SAY_PHASE_HC     =    -1666027,
    SAY_TRANSFORM_1  =    -1666028,
    SAY_TRANSFORM_2  =    -1666029,
    SAY_KILL_1       =    -1666030,
    SAY_KILL_2       =    -1666031,
    SAY_BERSERK      =    -1666032,
    SAY_DEATH        =    -1666033,
};

enum ProfessorSpells
{
    SPELL_UNBOUND_PLAGUE          = 72856,
    SPELL_UNSTABLE_EXPERIMENT     = 70351, // Script effect not work on 10154. Spawn manually.
    SPELL_TEAR_GAS                = 71617,
    SPELL_TEAR_GAS_1              = 71615,
    SPELL_TEAR_GAS_2              = 71618,
    SPELL_CREATE_CONCOCTION       = 71621,
    SPELL_MALLEABLE_GOO_10_NORMAL = 72296,
    SPELL_MALLEABLE_GOO_25_NORMAL = 70852,
    SPELL_MALLEABLE_GOO_10_HEROIC = 70852,
    SPELL_MALLEABLE_GOO_25_HEROIC = 72874,
    SPELL_MALLEABLE_GOO           = 72298,
    SPELL_GUZZLE_POTIONS          = 71893,
    SPELL_MUTATED_STRENGTH        = 71603,
    SPELL_MUTATED_PLAGUE          = 72672,
    SPELL_OOZE_THROW              = 70342, // is triggered spell - SPELL_SUMMON_PUDDLE
    SPELL_ROOT                    = 42716,
//
    SPELL_GREEN_BOTTLE_0          = 71826,
    SPELL_ORANGE_BOTTLE_0         = 71827,
    SPELL_GREEN_BOTTLE_1          = 71702,
    SPELL_ORANGE_BOTTLE_1         = 71703,
//
    SPELL_THROW_BOTTLE_1          = 71273,
    SPELL_THROW_BOTTLE_2          = 71275,
    SPELL_THROW_BOTTLE_3          = 71276,
//NPC_GAS_CLOUD
    SPELL_GASEOUS_BLOAT           = 70672,
    SPELL_EXPUNGED_GAS            = 70701,
    SPELL_SOUL_FEAST              = 71203,
//NPC_VOLATILE_OOZE
    SPELL_OOZE_ADHESIVE           = 70447,
    SPELL_OOZE_ERUPTION           = 70492,
//
    SPELL_OOZE_TANK_PROTECTION    = 71770,
//
    SPELL_MUTATED_TRANSFORMATION  = 70311,
    SPELL_EAT_OOZE                = 72527,
    SPELL_REGURGITATED_OOZE       = 70539,
    SPELL_MUTATED_SLASH           = 70542,
    SPELL_MUTATED_AURA            = 70405,
//
    SPELL_CHOKING_GAS             = 71259,
    SPELL_CHOKING_GAS_AURA        = 71278,
    SPELL_CHOKING_GAS_EXPLODE     = 71279,
    SPELL_CHOKING_GAS_EXPLODE_TRIGGER     = 71280,
    SPELL_ORANGE_RADIATION        = 45857, //Additional visual
//
    SPELL_SLIME_PUDDLE            = 70343,
    SPELL_SLIME_PUDDLE_AURA       = 70346,

    SPELL_BERSERK                 = 47008,
//
    VIEW_1                        = 30881,
    VIEW_2                        = 30881,
    VIEW_3                        = 30993,
};

enum Summons
{
    SUMMON_OOZE_PUDDLE      =    37690,
    SUMMON_GASCLOUD         =    37562,
    SUMMON_VOLATILE_OOZE    =    37697,
    SUMMON_CHOKE            =    38159,
};

Creature* pAbomination;
Creature* pPuddle;

//SPAWN LOCATIONS//4381.573 3208.696 389.399
#define SPAWN_Z              389.399
//Upper right//
#define UR_X                 4381.573
#define UR_Y                 3208.696
#define UR2_X                4326.433
#define UR2_Y                3213.893

#define EMOTE_UNSTABLE_EXPERIMENT "Professor Putricide begins unstable experiment!"

struct boss_professor_putricideAI : public ScriptedAI
{
    boss_professor_putricideAI(Creature *pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = pCreature->GetInstanceData();
    }

    ScriptedInstance* m_pInstance;

    uint32 m_uiPhase;
    uint32 m_uiUnstableExperimentTimer;
    uint32 m_uiAddSpawnTimer;
    uint32 m_uiGooTimer;
    uint32 m_uiBombtimer;
    uint32 m_uiPuddleTimer;
    uint32 m_uiUnboundTimer;
    uint32 m_uiChangeTimer;

    bool m_bIsPhase1;
    bool m_bIsPhase2;

    void Reset()
    {
        me->RemoveAllAuras();
        m_uiPhase = 1;
        m_uiUnstableExperimentTimer = 10000;
        m_uiAddSpawnTimer = 60000;
        m_bIsPhase1 = false;
        m_bIsPhase2 = false;

        if (m_pInstance)
            m_pInstance->SetData(DATA_PROFESSOR_PUTRICIDE_EVENT, NOT_STARTED);
    }

    void EnterCombat(Unit* who)
    {
        DoScriptText(SAY_AGGRO, me);

        if (m_pInstance)
            m_pInstance->SetData(DATA_PROFESSOR_PUTRICIDE_EVENT, IN_PROGRESS);
    }

    void JustDied(Unit* pKiller)
    {
        DoScriptText(SAY_DEATH, me);

        if (m_pInstance)
            m_pInstance->SetData(DATA_PROFESSOR_PUTRICIDE_EVENT, DONE);
    }

    void KilledUnit(Unit *victim)
    {
        DoScriptText(RAND(SAY_KILL_1,SAY_KILL_2), me);
    }

    void JustReachedHome()
    {
        if(m_pInstance)
            m_pInstance->SetData(DATA_PROFESSOR_PUTRICIDE_EVENT, FAIL);
    }

    void JustSummoned(Creature* pSummoned)
    {
        Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,0);
        pSummoned->AI()->AttackStart(pTarget);
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!UpdateVictim())
            return;

        if (m_uiUnstableExperimentTimer < uiDiff)
        {
            DoCast(me, SPELL_UNSTABLE_EXPERIMENT);
            me->MonsterTextEmote(EMOTE_UNSTABLE_EXPERIMENT,NULL);
            m_uiUnstableExperimentTimer = 40000;
            m_uiAddSpawnTimer = 10000;
        } else m_uiUnstableExperimentTimer -= uiDiff;

        if (m_uiAddSpawnTimer < uiDiff)
        {
            switch (rand() % 2)
            {
            case 0:
                me->SummonCreature(SUMMON_GASCLOUD, UR_X, UR_Y, SPAWN_Z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 9999999);
                break;
            case 1:
                me->SummonCreature(SUMMON_VOLATILE_OOZE, UR2_X, UR2_Y, SPAWN_Z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 9999999);
                break;
            }
            m_uiAddSpawnTimer = 60000;
        } else m_uiAddSpawnTimer -= uiDiff;

        if (HealthBelowPct(80) && !m_bIsPhase1)
        {
                DoScriptText(SAY_TRANSFORM_1, me);
                if (me->GetDisplayId() != VIEW_2)
                    me->SetDisplayId(VIEW_2);
                DoCast(SPELL_TEAR_GAS);
                DoCast(SPELL_CREATE_CONCOCTION);
                m_uiPhase = 2;
                m_uiGooTimer = 35000;
                m_uiBombtimer = 28000;
                m_uiUnstableExperimentTimer = 40000;
                m_uiAddSpawnTimer = 55000;
                m_bIsPhase1 = true;
        }

        if (m_uiPhase == 2)
        {
            if (m_uiUnstableExperimentTimer < uiDiff)
            {
                        DoCast(me, SPELL_UNSTABLE_EXPERIMENT);
                        me->MonsterTextEmote(EMOTE_UNSTABLE_EXPERIMENT,NULL);
                        m_uiUnstableExperimentTimer = 40000;
                        m_uiAddSpawnTimer = 10000;
            }
    } else m_uiUnstableExperimentTimer -= uiDiff;

            if (m_uiAddSpawnTimer < uiDiff)
                switch(urand(0, 1))
                {
                case 0:
                    me->SummonCreature(SUMMON_GASCLOUD, UR_X, UR_Y, SPAWN_Z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 9999999);
                    break;
                case 1:
                    me->SummonCreature(SUMMON_VOLATILE_OOZE, UR_X, UR_Y, SPAWN_Z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 9999999);
                    break;
                    m_uiAddSpawnTimer = 60000;
                } else m_uiAddSpawnTimer -= uiDiff;
            if (m_uiBombtimer < uiDiff)
            {
                Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0);
                                DoCast(pTarget, SPELL_THROW_BOTTLE_3);
                switch (rand() % 2)
                {
                case 0:
                    me->SummonCreature(SUMMON_CHOKE, me->GetPositionX()+10, me->GetPositionY()+10, me->GetPositionZ(), 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 23000);
                    me->SummonCreature(SUMMON_CHOKE, me->GetPositionX()-15, me->GetPositionY()+10, me->GetPositionZ(), 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 23000);
                    me->SummonCreature(SUMMON_CHOKE, me->GetPositionX()+20, me->GetPositionY()-20, me->GetPositionZ(), 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 23000);
                    m_uiBombtimer = 26000;
                    break;
                case 1:
                    me->SummonCreature(SUMMON_CHOKE, me->GetPositionX()-10, me->GetPositionY()-10, me->GetPositionZ(), 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 23000);
                    me->SummonCreature(SUMMON_CHOKE, me->GetPositionX()+15, me->GetPositionY()-10, me->GetPositionZ(), 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 23000);
                    me->SummonCreature(SUMMON_CHOKE, me->GetPositionX()-20, me->GetPositionY()+20, me->GetPositionZ(), 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 23000);
                    m_uiBombtimer = 26000;
                    break;
                }
            } else m_uiBombtimer -= uiDiff;

            if (m_uiGooTimer < uiDiff)
            {
                DoScriptText(SAY_AIRLOCK, me);
                    Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 1);
                    DoCast(pTarget, SPELL_MALLEABLE_GOO);
                    m_uiGooTimer = 37000;
            } else m_uiGooTimer -= uiDiff;

    if (HealthBelowPct(35) && !m_bIsPhase2)
        {
                DoScriptText(SAY_TRANSFORM_2, me);
                DoCast(SPELL_TEAR_GAS);
                DoCast(SPELL_GUZZLE_POTIONS);
                m_uiPhase = 3;
                m_bIsPhase2 = true;
                m_uiPuddleTimer = 8000;
                m_uiUnboundTimer = 51000;
                m_uiChangeTimer = 10000;
    }

        if (m_uiPhase == 3)
        {
            if (m_uiPuddleTimer < uiDiff)
            {
                Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0);
                DoCast(pTarget, SPELL_SLIME_PUDDLE);
                me->SummonCreature(SUMMON_OOZE_PUDDLE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 120000);
                m_uiPuddleTimer = 4000;
            } else m_uiPuddleTimer -= uiDiff;

            if (m_uiChangeTimer < uiDiff)
            {
                    me->SetDisplayId(VIEW_3);
            } else m_uiChangeTimer -= uiDiff;

            if (m_uiUnboundTimer <= uiDiff)
            {
                DoCast(me, SPELL_SLIME_PUDDLE);
                if (getDifficulty() == RAID_DIFFICULTY_10MAN_HEROIC || getDifficulty() == RAID_DIFFICULTY_25MAN_HEROIC)
                {
                    Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0);
                    DoCast(pTarget, SPELL_UNBOUND_PLAGUE);
                }
                DoScriptText(SAY_PHASE_HC, me);
                m_uiUnboundTimer = 48000;
            } else m_uiUnboundTimer -= uiDiff;
                }

        DoMeleeAttackIfReady();
    }
};

struct npc_volatile_oozeAI : public ScriptedAI
{
    npc_volatile_oozeAI(Creature *pCreature) : ScriptedAI(pCreature)
    {
        me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_OOZE_ADHESIVE, true);
    }

    uint64 TargetGUID;

    uint32 OozeAdhesivTimer;
    uint32 OozeExplosionTimer;
    uint32 MovechaseTimer;

    void EnterCombat(Unit *who)
    {
        DoZoneInCombat();
    }

    void Reset()
    {
        TargetGUID = 0;
        OozeAdhesivTimer = 7000;
        OozeExplosionTimer = 5000;
        MovechaseTimer = 2000;
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (!me->HasAura(SPELL_OOZE_ADHESIVE))
        {
            if (OozeAdhesivTimer < diff)
            {
                uint32 count = RAID_MODE(1,1,1,3);
                for (uint8 i = 1; i <= count; i++)
                {
                    Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0);
                    DoCast(pTarget, SPELL_OOZE_ADHESIVE);
                    OozeAdhesivTimer = 5000;
                    MovechaseTimer = 10000;
                }
            } else OozeAdhesivTimer -= diff;
        }

        if (MovechaseTimer < diff)
        {
            Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0);
            me->AddThreat(pTarget, 500000.0f);
            me->GetMotionMaster()->MoveChase(pTarget);
            MovechaseTimer = 30000;
        }
        else MovechaseTimer -= diff;


        if (OozeExplosionTimer < diff)
        {
            if (me->IsWithinDistInMap(me, 3.00f))
            {
                Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0);
                if (!pTarget->HasAura(SPELL_OOZE_ADHESIVE))
                      DoCast(SPELL_OOZE_ERUPTION);
                OozeAdhesivTimer = 1000;
                me->ForcedDespawn();
              }
        } else OozeExplosionTimer -= diff;
    }
};
struct npc_gas_cloudAI : public ScriptedAI
{
    npc_gas_cloudAI(Creature *pCreature) : ScriptedAI(pCreature)
    {
        me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_OOZE_ADHESIVE, true);
    }

    uint64 TargetGUID;

    uint32 OozeAdhesivTimer;
    uint32 OozeExplosion;
    uint32 Move2chaseTimer;
    uint32 GasTimer;
    uint32 BloatTimer;

    void EnterCombat(Unit *who)
    {
        DoZoneInCombat();
    }

    void Reset()
    {
        TargetGUID = 0;
        GasTimer = 7000;
        BloatTimer = 1000;
        Move2chaseTimer = 2000;
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;


            if (BloatTimer < diff)
            {
                uint32 count = RAID_MODE(1,1,1,3);
                for (uint8 i = 1; i <= count; i++)
                {
                    Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0);
                    DoCast(pTarget, SPELL_GASEOUS_BLOAT);
                    BloatTimer = 5000;
                }
            } else BloatTimer -= diff;


        if (Move2chaseTimer < diff)
        {
            Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0);
            me->AddThreat(pTarget, 500000.0f);
            me->GetMotionMaster()->MoveChase(pTarget);
            Move2chaseTimer = 30000;
        }
        else Move2chaseTimer -= diff;


        if (GasTimer < diff)
        {
            if (me->IsWithinDistInMap(me, 3.00f))
            {
                Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0);
                !pTarget->HasAura(SPELL_GASEOUS_BLOAT);
                DoCast(SPELL_EXPUNGED_GAS);
                GasTimer = 1000;
                me->ForcedDespawn();
            }
        } else GasTimer -= diff;
    }
};
struct npc_choke_bombAI : public ScriptedAI
{
    npc_choke_bombAI(Creature *pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = pCreature->GetInstanceData();
    }
    ScriptedInstance* m_pInstance;
    uint32 m_uiChokeTimer;
    uint32 m_uiExplodeDespawn;
    void Reset()
    {
        DoCast(SPELL_CHOKING_GAS);
        me->SetReactState(REACT_PASSIVE);
        m_uiChokeTimer = 1000;
        m_uiExplodeDespawn = 20000;
        if (!me->HasAura(SPELL_ROOT))
             DoCast(me, SPELL_ROOT);
    }
    void UpdateAI(const uint32 uiDiff)
    {
        if(m_uiChokeTimer <= uiDiff)
        {
            DoCast(SPELL_CHOKING_GAS);
            m_uiChokeTimer = 25000;
        } else m_uiChokeTimer -= uiDiff;

        if(m_uiExplodeDespawn <= uiDiff)
        {
            DoCast(SPELL_CHOKING_GAS_EXPLODE);
            me->ForcedDespawn();
        } m_uiExplodeDespawn -= uiDiff;
    }
};
struct npc_puddle_oozeAI : public ScriptedAI
{
    npc_puddle_oozeAI(Creature *pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = pCreature->GetInstanceData();
        pPuddle = me;
    }
    ScriptedInstance* m_pInstance;
    uint32 m_uiPuddleOozeTimer;
    void Reset()
    {
        me->SetReactState(REACT_PASSIVE);
        me->SetSpeed(MOVE_WALK, 0.1f, true);
        DoCast(SPELL_SLIME_PUDDLE);
        m_uiPuddleOozeTimer = 8000;
        if (!me->HasAura(SPELL_ROOT))
        DoCast(me, SPELL_ROOT); 
    }
    void UpdateAI(const uint32 uiDiff)
    {
        if(m_uiPuddleOozeTimer <= uiDiff)
        {
             me->ForcedDespawn();
        } else m_uiPuddleOozeTimer -= uiDiff;

    }
};
struct npc_abominationAI : public ScriptedAI
{
    npc_abominationAI(Creature *pCreature) : ScriptedAI(pCreature), vehicle(me->GetVehicleKit())
    {
        m_pInstance = pCreature->GetInstanceData();
        pAbomination = me;
        assert(vehicle);
//        me->SetPower(POWER_OOZE, 0);
//        me->SetPower(me->getPowerType(POWER_OOZE), 0);
    }
    ScriptedInstance* m_pInstance;

    uint32 m_uiGrabTimer;
    bool InVehicle;
    Vehicle *vehicle;

    void Reset()
    {
        m_uiGrabTimer = 2000;
        InVehicle = false;
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!UpdateVictim())
            return;

        if (m_uiGrabTimer < uiDiff)
        {
            if(!InVehicle)
            {
                Unit *pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0);
                pTarget->EnterVehicle(vehicle);
                InVehicle = true;
            }
        } else m_uiGrabTimer -= uiDiff;
    }

};
struct npc_malleable_gooAI : public ScriptedAI
{
    npc_malleable_gooAI(Creature *pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = pCreature->GetInstanceData();
    }
    ScriptedInstance* m_pInstance;
    uint32 m_uiMalleableTimer;
    uint32 m_uiDespawnTimer;
    void Reset()
    {
        float x, y, z;
        me->GetNearPoint(me, x, y, z, 1, 80, M_PI*2*rand_norm());
        me->GetMotionMaster()->MovePoint(0, x, y, z);
        DoCast(RAID_MODE(SPELL_MALLEABLE_GOO_10_NORMAL,SPELL_MALLEABLE_GOO_25_NORMAL,SPELL_MALLEABLE_GOO_10_HEROIC,SPELL_MALLEABLE_GOO_25_HEROIC));
        me->SetReactState(REACT_PASSIVE);
        me->SetSpeed(MOVE_WALK, 0.3f, true);
        me->SetSpeed(MOVE_RUN, 0.3f, true);
        m_uiDespawnTimer = 19000;
        m_uiMalleableTimer = 2000;
    }
    void UpdateAI(const uint32 uiDiff)
    {
        if(m_uiMalleableTimer <= uiDiff)
        {
            DoCast(me, RAID_MODE(SPELL_MALLEABLE_GOO_10_NORMAL,SPELL_MALLEABLE_GOO_25_NORMAL,SPELL_MALLEABLE_GOO_10_HEROIC,SPELL_MALLEABLE_GOO_25_HEROIC));
            m_uiMalleableTimer = 3000;
        } else m_uiMalleableTimer -= uiDiff;

        if(m_uiDespawnTimer <= uiDiff)
        {
            me->ForcedDespawn();
        } m_uiDespawnTimer -= uiDiff;
    }
};
CreatureAI* GetAI_npc_gas_cloud(Creature* pCreature)
{
    return new npc_gas_cloudAI(pCreature);
}
CreatureAI* GetAI_npc_abomination(Creature* pCreature)
{
    return new npc_abominationAI(pCreature);
}
CreatureAI* GetAI_npc_malleable_goo(Creature* pCreature)
{
    return new npc_malleable_gooAI(pCreature);
}
CreatureAI* GetAI_npc_puddle_ooze(Creature* pCreature)
{
    return new npc_puddle_oozeAI(pCreature);
}
CreatureAI* GetAI_npc_choke_bomb(Creature* pCreature)
{
    return new npc_choke_bombAI(pCreature);
}
CreatureAI* GetAI_npc_volatile_ooze(Creature* pCreature)
{
    return new npc_volatile_oozeAI(pCreature);
}

CreatureAI* GetAI_boss_professor_putricide(Creature* pCreature)
{
    return new boss_professor_putricideAI(pCreature);
}

void AddSC_boss_professor_putricide()
{
    Script *NewScript;

    NewScript = new Script;
    NewScript->Name = "boss_professor_putricide";
    NewScript->GetAI = &GetAI_boss_professor_putricide;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "npc_volatile_ooze";
    NewScript->GetAI = &GetAI_npc_volatile_ooze;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "npc_choke_bomb";
    NewScript->GetAI = &GetAI_npc_choke_bomb;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "npc_puddle_ooze";
    NewScript->GetAI = &GetAI_npc_puddle_ooze;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "npc_malleable_goo";
    NewScript->GetAI = &GetAI_npc_malleable_goo;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "npc_abomination";
    NewScript->GetAI = &GetAI_npc_abomination;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "npc_gas_cloud";
    NewScript->GetAI = &GetAI_npc_gas_cloud;
    NewScript->RegisterSelf();
};