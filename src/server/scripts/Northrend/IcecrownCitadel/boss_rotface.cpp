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
    SAY_AGGRO                  = -1666016,
    SAY_PUTRI_SLIME            = -1666019,
    SAY_PUTRI_SLIME_2          = -1666020,
    SAY_DEATH                  = -1666024,
    SAY_DEATH_2                = -1666025,
    SAY_KILL                   = -1666022,
    SAY_KILL2                  = -1666021,
    SAY_BERSERK                = -1666023,
    SAY_SLIME_SPRAY            = -1666017,
    SAY_EXPLOSION              = -1666018,
};

enum Creatures
{
    CREATURE_OOZE_BIG             = 36899,
    CREATURE_LITTLE_OOZE          = 36897,
    CREATURE_PROFFESOR_PUTRICIDE  = 36678,
};
enum Summons
{
    CREATURE_PUDDLE_STALKER       = 37013,
    NPC_STICKY_OOZE          = 37006,
};

enum Spells
{
    SPELL_OOZE_FLOOD           = 69783,
    SPELL_OOZE_FLOOD_1         = 69785,
    SPELL_OOZE_FLOOD_2         = 69788,
    SPELL_ROOT                 = 42716,
    SPELL_SLIME_SPRAY          = 69508,
    SPELL_MUTATED_INFECTION    = 71224,
    SPELL_SUMMON_LITTLE_OOZE   = 69706,
    SPELL_SUMMON_BIG_OOZE      = 69540,
    SPELL_BERSERK              = 47008,
    SPELL_STICKY_OOZE          = 69775,
    SPELL_OOZE_STICKY          = 69776,
    SPELL_RADIATING_OOZE       = 71212,
    SPELL_UNSTABLE_OOZE        = 69558,
    SPELL_UNSTABLE_EXPLOSION   = 71209,
    SPELL_MERGE_OOZE           = 69889,
};

Creature* pBigooze;
Creature* pLittleooze;

//SPAWN LOCATIONS//
#define SPAWN_Z              360.385
//Upper right//
#define UR_X                 4468.185
#define UR_Y                 3094.572
#define UR2_X                4487.714
#define UR2_Y                3114.549
//Upper left//
#define UL_X                 4489.141
#define UL_Y                 3159.730
#define UL2_X                4467.542
#define UL2_Y                3178.410
//Lower left//
#define LL_X                 4424.428
#define LL_Y                 3178.934
#define LL2_X                4404.548
#define LL2_Y                3158.309
//Lower right//
#define LR_X                 4404.765
#define LR_Y                 3116.065
#define LR2_X                4424.647
#define LR2_Y                3096.181

#define EMOTE_BIG_OOZE "Big Ooze can barely maintain its form!"
#define EMOTE_SLIME_SPRAY "Rotface begins to cast Slime Spray!"

struct boss_rotfaceAI : public ScriptedAI
{
    boss_rotfaceAI(Creature *pCreature) : ScriptedAI(pCreature), summons(me)
    {
        m_pInstance = pCreature->GetInstanceData();
    }

    ScriptedInstance* m_pInstance;
    SummonList summons;

    uint32 m_uiFloodTimer;
    uint32 m_uiSlimeSprayTimer;
    uint32 m_uiMutatedInfectionTimer;
    uint32 m_uiBerserkTimer;
    uint32 m_uiLittleOozeTimer;
    uint32 m_uiResetTimer;

    void Reset()
    {
        m_uiFloodTimer = 10000;
        m_uiSlimeSprayTimer = 20000;
        m_uiMutatedInfectionTimer = 25000;
        m_uiBerserkTimer = 600000;
        m_uiLittleOozeTimer = 30000;

        if(m_pInstance)
            m_pInstance->SetData(DATA_ROTFACE_EVENT, NOT_STARTED);
    }

    void JustDied(Unit* pKiller)
    {
        DoScriptText(SAY_DEATH, me);
        DoScriptText(SAY_DEATH_2, me);

        if(m_pInstance)
            m_pInstance->SetData(DATA_ROTFACE_EVENT, DONE);
    }

    void EnterCombat(Unit* who)
    {
        DoScriptText(SAY_AGGRO, me);

        if(m_pInstance)
            m_pInstance->SetData(DATA_ROTFACE_EVENT, IN_PROGRESS);
    }

    void JustReachedHome()
    {
        if(m_pInstance)
            m_pInstance->SetData(DATA_ROTFACE_EVENT, FAIL);
    }

    void KilledUnit(Unit *pVictim)
    {
        switch(urand(0, 1))
        {
        case 0:
            DoScriptText(SAY_KILL, me);
            break;
        case 1:
            DoScriptText(SAY_KILL2, me);
            break;
        }
    }

    void JustSummoned(Creature* creature)
    {
        summons.Summon(creature);
    }
    void SummonedCreatureDespawn(Creature* creature)
    {
        summons.Despawn(creature);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        OozesMeetCheck();

        if (m_uiSlimeSprayTimer <= diff)
        {
            Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0);
            DoScriptText(SAY_SLIME_SPRAY, me);
            me->MonsterTextEmote(EMOTE_SLIME_SPRAY,NULL);
            DoCast(SPELL_SLIME_SPRAY);
            m_uiSlimeSprayTimer = 26000;
        } else m_uiSlimeSprayTimer -= diff;

        if (m_uiResetTimer <= diff)
        {
            if (me->GetDistance2d(me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY()) > 40)
                EnterEvadeMode();
            m_uiResetTimer = 5000;
        } else m_uiResetTimer -= diff;

        if (m_uiFloodTimer <= diff)
        {
            switch (rand() % 4)
            {
            case 0:
                DoScriptText(SAY_PUTRI_SLIME, me);
                me->SummonCreature(CREATURE_PUDDLE_STALKER, LR_X, LR_Y, SPAWN_Z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 24000);
                me->SummonCreature(CREATURE_PUDDLE_STALKER, LR2_X, LR2_Y, SPAWN_Z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 24000);
                break;
            case 1:
                me->SummonCreature(CREATURE_PUDDLE_STALKER, UR_X, UR_Y, SPAWN_Z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 24000);
                me->SummonCreature(CREATURE_PUDDLE_STALKER, UR2_X, UR2_Y, SPAWN_Z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 24000);
                DoScriptText(SAY_PUTRI_SLIME, me);
                break;
            case 2:
                me->SummonCreature(CREATURE_PUDDLE_STALKER, LL_X, LL_Y, SPAWN_Z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 24000);
                me->SummonCreature(CREATURE_PUDDLE_STALKER, LL2_X, LL2_Y, SPAWN_Z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 24000);
                DoScriptText(SAY_PUTRI_SLIME_2, me);
                break;
            case 3:
                me->SummonCreature(CREATURE_PUDDLE_STALKER, UL_X, UL_Y, SPAWN_Z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 24000);
                me->SummonCreature(CREATURE_PUDDLE_STALKER, UL2_X, UL2_Y, SPAWN_Z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 24000);
                DoScriptText(SAY_PUTRI_SLIME_2, me);
                break;
            }
            m_uiFloodTimer = 25000;
        } else m_uiFloodTimer -= diff;

        if (m_uiMutatedInfectionTimer <= diff)
        {
            Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 1);
            if(pTarget && !pTarget->HasAura(SPELL_MUTATED_INFECTION))
            {
                DoCast(pTarget, SPELL_MUTATED_INFECTION);
            }
            m_uiMutatedInfectionTimer = 30000;
        } else m_uiMutatedInfectionTimer -= diff;

        if (m_uiBerserkTimer <= diff)
        {
            DoScriptText(SAY_BERSERK, me);
            DoCast(me, SPELL_BERSERK);
            m_uiBerserkTimer = 600000;
        } else m_uiBerserkTimer -= diff;

        DoMeleeAttackIfReady();
    }


    void OozesMeetCheck()
    {
        if (summons.empty() || summons.size()==1)
            return;

        for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
        {
            Creature* ooze = ObjectAccessor::GetCreatureOrPetOrVehicle((*me), (*itr));
            if (!ooze || !ooze->isAlive())
                continue;
            if (ooze->GetEntry() != CREATURE_LITTLE_OOZE && ooze->GetEntry() != CREATURE_OOZE_BIG)
                continue;

            bool little = (ooze->GetEntry() == CREATURE_LITTLE_OOZE);

            for(SummonList::const_iterator itr2 = summons.begin(); itr2 != summons.end(); ++itr2)
            {
                Creature* ooze2 = ObjectAccessor::GetCreatureOrPetOrVehicle((*me), (*itr2));
                if (!ooze2 || !ooze2->isAlive())
                    continue;
                if (ooze2->GetEntry() != CREATURE_LITTLE_OOZE && ooze2->GetEntry() != CREATURE_OOZE_BIG)
                    continue;
                if (ooze2 == ooze)
                    continue;

                if (ooze->GetDistance2d(ooze2) > 5.0f)
                    continue;

                bool little2 = (ooze2->GetEntry() == CREATURE_LITTLE_OOZE);

                //if first ooze is big ooze
                if (!little)
                {
                    //and if second ooze is little
                    if (little2)
                    {
                        ooze2->ForcedDespawn();
                        ooze->CastSpell(ooze, SPELL_UNSTABLE_OOZE, false);

                        if (ooze->GetAura(SPELL_UNSTABLE_OOZE) && ooze->GetAura(SPELL_UNSTABLE_OOZE)->GetStackAmount() >= 5)
                            ooze->CastSpell(ooze2->getVictim(), SPELL_UNSTABLE_EXPLOSION, true);

                        continue;
                    }
                    else //big ooze meet another big ooze, check wich one have more buff stack and despawn second one
                    {
                        uint8 stack1, stack2 = 0;
                        if (Aura* aura = ooze->GetAura(SPELL_UNSTABLE_OOZE))
                            stack1 = aura->GetStackAmount();
                        if (Aura* aura = ooze2->GetAura(SPELL_UNSTABLE_OOZE))
                            stack2 = aura->GetStackAmount();

                        if (stack1 < stack2)
                        {
                            ooze->ForcedDespawn();
                            ooze2->CastSpell(ooze, SPELL_UNSTABLE_OOZE, false);

                            if (ooze2->GetAura(SPELL_UNSTABLE_OOZE) && ooze2->GetAura(SPELL_UNSTABLE_OOZE)->GetStackAmount() >= 5)
                                ooze2->CastSpell(ooze2->getVictim(), SPELL_UNSTABLE_EXPLOSION, true);

                            break;
                        }
                        else
                        {
                            ooze2->ForcedDespawn();
                            ooze->CastSpell(ooze, SPELL_UNSTABLE_OOZE, false);

                            if (ooze->GetAura(SPELL_UNSTABLE_OOZE) && ooze->GetAura(SPELL_UNSTABLE_OOZE)->GetStackAmount() >= 5)
                                ooze->CastSpell(ooze2->getVictim(), SPELL_UNSTABLE_EXPLOSION, true);

                            continue;
                        }
                    }
                }
                else  //if first ooze is little
                {
                    if (little2) //and second ooze is little, despawn both and summon big ooze
                    {
                        DoSummon(CREATURE_OOZE_BIG, (*ooze));
                        ooze->ForcedDespawn();
                        ooze2->ForcedDespawn();
                        break;
                    }
                    else
                    {
                        ooze->ForcedDespawn();
                        ooze2->CastSpell(ooze, SPELL_UNSTABLE_OOZE, false);

                        if (ooze2->GetAura(SPELL_UNSTABLE_OOZE) && ooze2->GetAura(SPELL_UNSTABLE_OOZE)->GetStackAmount() >= 5)
                            ooze2->CastSpell(ooze2->getVictim(), SPELL_UNSTABLE_EXPLOSION, true);

                        break;
                    }
                }
            }
        }
    }
};

struct npc_ooze_bigAI : public ScriptedAI
{
    npc_ooze_bigAI(Creature *pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = pCreature->GetInstanceData();
                pBigooze = me;
    }

    ScriptedInstance* m_pInstance;

    uint32 m_uiStickyOozeTimer;
    uint32 m_uiUnstableOozeTimer;
    uint32 m_uiUnstableExplosionTimer;

    void Reset()
    {
        m_uiStickyOozeTimer = 10000;
        m_uiUnstableOozeTimer = 5000;
        DoCast(SPELL_RADIATING_OOZE);
        me->AddUnitMovementFlag(MOVEMENTFLAG_WALK_MODE);
        me->SetSpeed(MOVE_WALK, 0.5f);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (!m_pInstance || m_pInstance->GetData(DATA_ROTFACE_EVENT) != IN_PROGRESS)
            me->ForcedDespawn();

        if (m_uiStickyOozeTimer <= diff)
        {
            me->SummonCreature(NPC_STICKY_OOZE, me->GetPositionX(), me->GetPositionY()+15, me->GetPositionZ(), me->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN, 8000);
            DoCast(SPELL_STICKY_OOZE);
            m_uiStickyOozeTimer = 10000;
        } else m_uiStickyOozeTimer -= diff;

        if (Aura *UnstableAura = me->GetAura(SPELL_UNSTABLE_OOZE))
        {
            if (UnstableAura->GetStackAmount() == 5)
            {
                DoCast(SPELL_UNSTABLE_EXPLOSION);
                me->MonsterTextEmote(EMOTE_BIG_OOZE,NULL);
                me->ForcedDespawn();
            }
        }

        DoMeleeAttackIfReady();
    }
};

struct npc_ooze_littleAI : public ScriptedAI
{
    npc_ooze_littleAI(Creature *pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = pCreature->GetInstanceData();
    }

    ScriptedInstance* m_pInstance;

    uint32 m_uiStickyOozeTimer;
        uint32 m_uiBigOozeTimer;

    void Reset()
    {
        m_uiStickyOozeTimer = 6000;
        DoCast(SPELL_RADIATING_OOZE);
        me->AddUnitMovementFlag(MOVEMENTFLAG_WALK_MODE);
        me->SetSpeed(MOVE_WALK, 0.5f);
    }

    void EnterCombat(Unit* who)
    {
    }

    void KilledUnit(Unit *victim)
    {
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (!m_pInstance || m_pInstance->GetData(DATA_ROTFACE_EVENT) != IN_PROGRESS)
            me->ForcedDespawn();

        if (m_uiStickyOozeTimer <= diff)
        {
            DoCast(SPELL_STICKY_OOZE);
            m_uiStickyOozeTimer = 17000;
        } else m_uiStickyOozeTimer -= diff;

        DoMeleeAttackIfReady();
    }
};
struct npc_sticky_oozeAI : public ScriptedAI
{
    npc_sticky_oozeAI(Creature *pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = pCreature->GetInstanceData();
    }
    ScriptedInstance* m_pInstance;
    uint32 m_uiStickyOozeTimer;
    void Reset()
    {
        me->SetReactState(REACT_PASSIVE);
        me->SetSpeed(MOVE_WALK, 1.0f, true);
        m_uiStickyOozeTimer = 1000;
    }
    void UpdateAI(const uint32 uiDiff)
    {
        if(m_uiStickyOozeTimer <= uiDiff)
        {
            DoCast(me, SPELL_OOZE_STICKY);
            m_uiStickyOozeTimer = 17000;
        } else m_uiStickyOozeTimer -= uiDiff;

    }
};
struct npc_flood_oozeAI : public ScriptedAI
{
    npc_flood_oozeAI(Creature *pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = pCreature->GetInstanceData();
    }
    ScriptedInstance* m_pInstance;
    uint32 m_uiFloodOozeTimer;
    uint32 m_uiFloodOoze2Timer;
    void Reset()
    {
    me->SetReactState(REACT_PASSIVE);
        m_uiFloodOozeTimer = 1500;
    m_uiFloodOoze2Timer = 23000;
        if (!me->HasAura(SPELL_ROOT))
        DoCast(me, SPELL_ROOT);
    }
    void UpdateAI(const uint32 uiDiff)
    {
        if(m_uiFloodOozeTimer <= uiDiff)
        {
        DoCast(SPELL_OOZE_FLOOD);
            m_uiFloodOozeTimer = 26000;
        } else m_uiFloodOozeTimer -= uiDiff;

        if(m_uiFloodOoze2Timer <= uiDiff)
        {
        me->ForcedDespawn();
        } else m_uiFloodOoze2Timer -= uiDiff;

    }
};

CreatureAI* GetAI_boss_rotface(Creature* pCreature)
{
    return new boss_rotfaceAI(pCreature);
}

CreatureAI* GetAI_npc_ooze_big(Creature* pCreature)
{
    return new npc_ooze_bigAI(pCreature);
}

CreatureAI* GetAI_npc_ooze_little(Creature* pCreature)
{
    return new npc_ooze_littleAI(pCreature);
}
CreatureAI* GetAI_npc_sticky_ooze(Creature* pCreature)
{
    return new npc_sticky_oozeAI(pCreature);
}

CreatureAI* GetAI_npc_flood_ooze(Creature* pCreature)
{
    return new npc_flood_oozeAI(pCreature);
}
void AddSC_boss_rotface()
{
    Script* NewScript;

    NewScript = new Script;
    NewScript->Name = "boss_rotface";
    NewScript->GetAI = &GetAI_boss_rotface;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "npc_ooze_big";
    NewScript->GetAI = &GetAI_npc_ooze_big;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "npc_ooze_little";
    NewScript->GetAI = &GetAI_npc_ooze_little;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "npc_sticky_ooze";
    NewScript->GetAI = &GetAI_npc_sticky_ooze;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "npc_flood_ooze";
    NewScript->GetAI = &GetAI_npc_flood_ooze;
    NewScript->RegisterSelf();
}