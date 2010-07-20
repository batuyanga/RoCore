/* Copyright (C) 2006 - 2010 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/* ScriptData
SDName: boss_anubarak_trial
SD%Complete: 70%
SDComment: by /dev/rsa
SDCategory:
EndScriptData */


#include "ScriptPCH.h"
#include "trial_of_the_crusader.h"

enum Yells
{
        SAY_AGGRO               =       -1713555,               //This place will serve as your tomb!
        SAY_SUBMERGE            =       -1713556,               //Auum na-l ak-k-k-k, isshhh. Rise, minions. Devour...
        SAY_LEECHING_SWARM      =       -1713557,               //The swarm shall overtake you!
        SAY_KILL_1              =       -1713558,               //F-lakkh shir!
        SAY_KILL_2              =       -1713559,               //Another soul to sate the host.
        SAY_DEATH               =       -1713560,               //I have failed you, master...
        SAY_OUTRO               =       -1713561,               //Highlord Tirion Fordring yells: Champions, you're alive! Not only have you defeated every challenge of the Trial of the Crusader, but thwarted Arthas directly! Your skill and cunning will prove to be a powerful weapon against the Scourge. Well done! Allow one of my mages to transport you back to the surface!
};

enum AnubarakSpells
{
        SPELL_FREEZING_SLASH                    =       66012,
        SPELL_PENETRATING_COLD_25_NORMAL        =       68510,
        SPELL_PENETRATING_COLD_10_NORMAL        =       66013,
        SPELL_SUBMERGE                          =       53421,
        SPELL_SUBMERGE_DENIED                     =         67322,
        SPELL_PURSUED                           =       67574,
        SPELL_IMPALE_10                         =       65919,
        SPELL_IMPALE_25                         =       67860,
        SPELL_SUMMON_SCARAB                     =       66340,
        SPELL_LEECHING_SWARM                    =       67630,
        SPELL_IMPALE_TRIGGER                    =       65921, //visual chase
        SPELL_IMPALE_RANGE                      =       65922,
        SPELL_BERSERK                           =       26662,
        SPELL_PERMAFROST                         =         66193,
        SPELL_IMPALE_FAIL                        =        66181, //impale fail
        SPELL_IMPALE_WIN                        =        69184, //impale win

};

enum NerubianSpells
{
        SPELL_NERUBIAN_GROUND_VISUAL    =       66324,
        SPELL_SPIDER_FRENZY             =         66129,
        SPELL_EXPOSE_WEAKNESS             =         67847,
};

enum ScarabSpells
{
        SPELL_ACID_MANDIBLE             =         67861,
        SPELL_DETERMINATION             =         66092,
};

enum Summons
{
        CREATURE_NERUBIAN_BURROWERS             =       34607,
        CREATURE_SWARM_SCARABS                  =       34605,
        CREATURE_FROST_SPHERES                  =       34606,
        CREATURE_IMPALE                         =       29184,
        CREATURE_NERUBIAN_BARROW_TRIGGER        =       34862,
};

float NerubianSpawnPoints[5][3] =
{
        {735.403015, 75.357597, 142.201996},
        {692.919981, 184.809006, 142.203003},
        {740.544983, 189.113007, 142.197006},
        {688.206970, 102.847000, 142.201996},
        {707.945984, 70.579903, 142.201996}
};

float SphereSpawnPoints[6][3] =
{
        {760.970, 110.127, 161.942},
        {755.998, 153.446, 161.942},
        {731.802, 167.743, 161.942},
        {705.302, 153.959, 161.942},
        {708.801, 118.917, 161.942},
        {726.513, 106.641, 161.942}
};

const Position ImpalePosition = { 734.404, 139.937, 142.227, 3.155010 };

#define SP_LEECHING_SWARM 67630
#define SP_LEECHING_SWARM_DMG 66240
#define SP_LEECHING_SWARM_HEAL 66125

Creature* pAnubarak;
Creature* pImpale;

struct Boss_Raid_AnubarakAI : public ScriptedAI
{
    Boss_Raid_AnubarakAI(Creature *pCreature) : ScriptedAI(pCreature)
    {
        pInstance = pCreature->GetInstanceData();
        pAnubarak = me;
    }
        ScriptedInstance* pInstance;

        uint32 m_uiPhase;
        uint32 m_uiSwarmTickTimer;
        uint32 m_uiNerubianTriggerTimer;
        uint32 m_uiNerubianSummonTimer;
        uint32 m_uiPhaseTimer;
        uint32 m_uiFreezingSlashTimer;
        uint32 m_uiBerserkTimer;
        uint32 m_uiColdTimer;
        uint32 m_uiScarabSummonTimer;

        int32 SwarmDamage;
        int32 SwarmDamageTotal;

        bool m_bIsTriggerSpawned;

    void SphereSummon()
        {
            for (uint8 i = 0; i < 6; ++i)
                me->SummonCreature(CREATURE_FROST_SPHERES, SphereSpawnPoints[i][0], SphereSpawnPoints[i][1], SphereSpawnPoints[i][2],0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
        }

    void Reset()
    {
                m_uiPhase =     1;
                m_uiSwarmTickTimer = 2000;
                m_uiNerubianTriggerTimer = 3000;
                m_uiNerubianSummonTimer = 30000;
                m_uiPhaseTimer = 90000;
                m_uiFreezingSlashTimer = 10000;
                m_uiBerserkTimer = 600000;
                m_uiColdTimer = 15000;
                m_uiScarabSummonTimer = 20000;

                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
                me->RemoveAura(SPELL_SUBMERGE);

                m_bIsTriggerSpawned = false;

                SphereSummon();
    }

    void EnterCombat(Unit* who)
    {
                DoScriptText(SAY_AGGRO, me);
                DoZoneInCombat(me);
    }

        void NerubianSummon()
        {
                for (uint8 i = 0; i < RAID_MODE(2,4,2,4); ++i)
                {
                        if (Creature *Nerubian = me->SummonCreature(CREATURE_NERUBIAN_BURROWERS, NerubianSpawnPoints[i][0], NerubianSpawnPoints [i][1], NerubianSpawnPoints[i][2],0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000))
                        {
                                Nerubian->AddThreat(me->getVictim(), 0.0f);
                                DoZoneInCombat(Nerubian);
                        }
                }
        }

        void ScarabSummon()
        {
                for (uint8 i = 0; i < RAID_MODE(2,4,2,4); ++i)
                {
                        if (Creature *Scarab = me->SummonCreature(CREATURE_SWARM_SCARABS, NerubianSpawnPoints[i][0], NerubianSpawnPoints [i][1], NerubianSpawnPoints[i][2],0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000))
                        {
                                Scarab->AddThreat(me->getVictim(), 0.0f);
                                DoZoneInCombat(Scarab);
                        }
                }
        }

        void MarkPlayer()
        {
            Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,0);
            DoCast(SPELL_PURSUED);
            me->SummonCreature(CREATURE_IMPALE, ImpalePosition, TEMPSUMMON_CORPSE_DESPAWN);
        }

        void SwarmTick()
        {
                SwarmDamageTotal = 0;
                std::list<HostileReference*>& m_threatlist = me->getThreatManager().getThreatList();
                std::list<HostileReference*>::const_iterator i = m_threatlist.begin();
                        for (i = m_threatlist.begin(); i != m_threatlist.end(); ++i)
                        {
                                Unit* plr = Unit::GetUnit((*me), (*i)->getUnitGuid());
                                if (plr && plr->isAlive())
                                if(plr && plr->GetTypeId()==TYPEID_PLAYER && plr->isAlive())
                                {
                                        SwarmDamage = plr->GetHealth() / RAID_MODE(10,20,30,30);
                                        if(SwarmDamage < 250) SwarmDamage = 250;
                                        SwarmDamageTotal += SwarmDamage;
                                        me->CastCustomSpell(plr, SP_LEECHING_SWARM_DMG, &SwarmDamage, NULL, NULL, true);
                                }
                        }
                me->CastCustomSpell(me, SP_LEECHING_SWARM_HEAL, &SwarmDamageTotal, NULL, NULL, true);
        }

        void KilledUnit(Unit *victim)
        {
                switch(rand()%2)
                {
                    case 0: DoScriptText(SAY_KILL_1, me); break;
                    case 1: DoScriptText(SAY_KILL_2, me); break;
                }
        }

        void UpdateAI(const uint32 uiDiff)
        {
                uint32 MarkTimer;

                MarkTimer = 9999999;

                if (!UpdateVictim())
                    return;

                if (m_uiBerserkTimer <= uiDiff)
                    {
                        DoCast(me, SPELL_BERSERK);
                        m_uiBerserkTimer = 9999999;
                    } else m_uiBerserkTimer -= uiDiff;


                if (m_uiNerubianTriggerTimer <= uiDiff)
                {
                        for (uint8 i = 0; i < 5; ++i)
                        {
                                me->SummonCreature(CREATURE_NERUBIAN_BARROW_TRIGGER, NerubianSpawnPoints[i][0], NerubianSpawnPoints[i][1], NerubianSpawnPoints[i][2],0,TEMPSUMMON_CORPSE_DESPAWN, 10000);
                                m_uiNerubianTriggerTimer = 999999999;
                        }
                }
                else m_uiNerubianTriggerTimer -= uiDiff;

                if (m_uiPhase == 1)
                {
                        if (m_uiNerubianSummonTimer <= uiDiff)
                        {
                            NerubianSummon();
                            m_uiNerubianSummonTimer = 70000;
                        }
                        else m_uiNerubianSummonTimer -= uiDiff;

                        if (m_uiPhaseTimer <= uiDiff)
                        {
                            m_uiPhase = 2;
                            DoScriptText(SAY_SUBMERGE, me);
                            DoCast(SPELL_SUBMERGE);
                            m_uiPhaseTimer = 90000;
                        } else m_uiPhaseTimer -= uiDiff;
                }

                if (m_uiPhase == 2)
                {
                    MarkTimer = 5000;

                    if (m_uiPhaseTimer <= uiDiff)
                        {
                            m_uiPhase = 1;
                            me->RemoveAura(SPELL_SUBMERGE);
                            m_uiPhaseTimer = 90000;
                        } else m_uiPhaseTimer -= uiDiff;

                    if (m_uiScarabSummonTimer <= uiDiff)
                    {
                        ScarabSummon();
                        m_uiScarabSummonTimer = 20000;
                    } else m_uiScarabSummonTimer -= uiDiff;

                    if (MarkTimer <= uiDiff || !pImpale->isAlive())
                    {
                        MarkPlayer();
                        MarkTimer = 9999999;
                    } else MarkTimer -= uiDiff;

                }

                if (m_uiPhase == 1 || m_uiPhase == 3)
                {
                    if (m_uiFreezingSlashTimer <= uiDiff)
                    {
                        Unit* pTarget = SelectUnit(SELECT_TARGET_TOPAGGRO, 0);
                        DoCast(pTarget, SPELL_FREEZING_SLASH);
                        m_uiFreezingSlashTimer = 10000;
                    } else m_uiFreezingSlashTimer -= uiDiff;

                    if (m_uiColdTimer <= uiDiff)
                    {
                        DoCast(RAID_MODE(SPELL_PENETRATING_COLD_10_NORMAL,SPELL_PENETRATING_COLD_25_NORMAL,SPELL_PENETRATING_COLD_10_NORMAL,SPELL_PENETRATING_COLD_25_NORMAL));
                        m_uiColdTimer = 15000;
                    } else m_uiColdTimer -= uiDiff;

                }

                if (m_uiPhase == 3)
                {
                        if (m_uiSwarmTickTimer <= uiDiff)
                        {
                                SwarmTick();
                                m_uiSwarmTickTimer = 2*IN_MILLISECONDS;
                        }
                        else m_uiSwarmTickTimer -= uiDiff;

                        if (getDifficulty() == RAID_DIFFICULTY_10MAN_HEROIC || getDifficulty() == RAID_DIFFICULTY_25MAN_HEROIC)
                        if (m_uiNerubianSummonTimer <= uiDiff)
                        {
                                NerubianSummon();
                                m_uiNerubianSummonTimer = 70000;
                        }
                        else m_uiNerubianSummonTimer -= uiDiff;
                }

                if(m_uiPhase == 1)
        {
                        if ((me->GetHealth()*100) / me->GetMaxHealth() < 30)
                        {
                                m_uiPhase = 3;
                                DoCastAOE(SPELL_LEECHING_SWARM);
                                DoScriptText(SAY_LEECHING_SWARM, me);
                        }
                }

                if (m_uiPhase != 2)
                    DoMeleeAttackIfReady();
        }

    void JustDied(Unit* killer)
    {
        DoScriptText(SAY_DEATH, me);
    }
};

CreatureAI* GetAI_Raid_Anubarak(Creature* pCreature)
{
    return new Boss_Raid_AnubarakAI (pCreature);
}

struct mob_swarm_scarabAI : public ScriptedAI
{
    mob_swarm_scarabAI(Creature *pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = pCreature->GetInstanceData();
    }

    ScriptedInstance* m_pInstance;

    uint32 AcidTimer;
    uint32 DeterminationTimer;

    void Reset()
    {
        AcidTimer = 6000;
        DeterminationTimer = 10000;
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (AcidTimer <= uiDiff)
        {
            DoCast(SPELL_ACID_MANDIBLE);
            AcidTimer = 6000;
        } else AcidTimer -= uiDiff;

        if (DeterminationTimer <= uiDiff)
        {
            DoCast(SPELL_DETERMINATION);
            DeterminationTimer = 6000;
        } else DeterminationTimer -= uiDiff;
    }

};

CreatureAI* GetAI_mob_swarm_scarab(Creature* pCreature)
{
    return new mob_swarm_scarabAI (pCreature);
}

struct mob_NerubianTriggerAI : public Scripted_NoMovementAI
{
    mob_NerubianTriggerAI(Creature *pCreature) : Scripted_NoMovementAI(pCreature)
    {
        m_pInstance = pCreature->GetInstanceData();
    }

    ScriptedInstance* m_pInstance;

    void Reset()
        {
                DoCast(me, SPELL_NERUBIAN_GROUND_VISUAL);
        }

    void UpdateAI(const uint32 uiDiff)
    {
    }
};

CreatureAI* GetAI_mob_NerubianTrigger(Creature* pCreature)
{
    return new mob_NerubianTriggerAI (pCreature);
}

struct nerubian_burrowerAI : public ScriptedAI
{
    nerubian_burrowerAI(Creature *pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = pCreature->GetInstanceData();
    }

    ScriptedInstance* m_pInstance;

    uint32 ExposeTimer;
    uint32 ResurfaceTimer;

    void Reset()
    {
        ExposeTimer = 9000;
        ResurfaceTimer = 9999999;
        me->RemoveAura(SPELL_SUBMERGE);
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (ExposeTimer <= uiDiff)
        {
            Unit* pTarget = SelectUnit(SELECT_TARGET_TOPAGGRO, 0);
            DoCast(pTarget,SPELL_EXPOSE_WEAKNESS);
            ExposeTimer = 9000;
        } else ExposeTimer -= uiDiff;

        if ((me->GetHealth()*100) / me->GetMaxHealth() < 15)
            if (!me->HasAura(SPELL_PERMAFROST))
                {
                    DoCast(SPELL_SUBMERGE);
                } else DoCast(SPELL_SUBMERGE_DENIED);

        if (me->HasAura(SPELL_SUBMERGE))
                ResurfaceTimer = 2000;

        if (ResurfaceTimer <= uiDiff)
        {
            ResurfaceTimer = 9999999;
            Reset();
        } else ResurfaceTimer -= uiDiff;

    }

};

CreatureAI* GetAI_nerubian_burrower(Creature* pCreature)
{
    return new nerubian_burrowerAI (pCreature);
}

struct frost_sphereAI : public ScriptedAI
{
    frost_sphereAI(Creature *pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = pCreature->GetInstanceData();
    }

    ScriptedInstance* m_pInstance;

    uint32 PermafrostTimer;

    void Reset()
    {
        me->SetFlying(true);
        me->SetSpeed(MOVE_FLIGHT, 0.5f, true);
        me->GetMotionMaster()->MoveRandom();
        PermafrostTimer = 9999999;
    }

    void JustDied(Unit* killer)
    {
        DoCast(me, SPELL_PERMAFROST);
    }

    void UpdateAI(const uint32 uiDiff)
    {
        /*if (PermafrostTimer <= uiDiff)
        {

            PermafrostTimer = 9999999;
        } else PermafrostTimer -= uiDiff;*/

        /*if (!pAnubarak->isAlive())
            {
                me->RemoveAura(SPELL_PERMAFROST);
                me->ForcedDespawn();
            }*/
    }

};

CreatureAI* GetAI_frost_sphere(Creature* pCreature)
{
    return new frost_sphereAI (pCreature);
}

struct creature_impaleAI : public ScriptedAI
{
    creature_impaleAI(Creature *pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = pCreature->GetInstanceData();
        pImpale = me;
    }

    ScriptedInstance* m_pInstance;

    bool pursuing;
    Unit* Target;

    void Reset()
    {
        me->SetSpeed(MOVE_RUN, 0.8f, true);
        me->SetSpeed(MOVE_WALK, 0.8f, true);
        if (!me->HasAura(SPELL_IMPALE_TRIGGER))
            DoCast(SPELL_IMPALE_TRIGGER);
        pursuing = false;
    }

    void JustDied(Unit* killer)
    {
        me->RemoveAura(SPELL_IMPALE_TRIGGER);
    }

    void SearchAndPursue()
    {
        Map* pMap = me->GetMap();
        Map::PlayerList const &PlayerList = pMap->GetPlayers();
        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            if (Player* i_pl = i->getSource())
                if (i_pl->isAlive() && i_pl->HasAura(SPELL_PURSUED))
                    {
                        me->GetMotionMaster()->MoveChase(i_pl);
                        Target = i_pl;
                    }
        pursuing = true;
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!pursuing)
            SearchAndPursue();
        if (me->IsWithinDistInMap(Target, 7))
            {
                if (Target->HasAura(SPELL_PERMAFROST))
                    {
                        DoCast(Target, SPELL_IMPALE_FAIL);
                    } else {
                                DoCast(Target, SPELL_IMPALE_WIN);
                                DoCast(RAID_MODE(SPELL_IMPALE_10,SPELL_IMPALE_25,SPELL_IMPALE_10,SPELL_IMPALE_25));
                           }
                me->RemoveAurasDueToSpell(SPELL_PURSUED);
                me->RemoveAura(SPELL_IMPALE_TRIGGER);
                me->ForcedDespawn();
            }
    }

};

CreatureAI* GetAI_creature_impale(Creature* pCreature)
{
    return new creature_impaleAI (pCreature);
}

void AddSC_Raid_Anubarak()
{
    Script *newscript;

        newscript = new Script;
    newscript->Name = "Boss_Raid_Anubarak";
    newscript->GetAI = &GetAI_Raid_Anubarak;
    newscript->RegisterSelf();

        newscript = new Script;
    newscript->Name = "Mob_NerubianTrigger";
    newscript->GetAI = &GetAI_mob_NerubianTrigger;
    newscript->RegisterSelf();

        newscript = new Script;
    newscript->Name = "mob_swarm_scarab";
    newscript->GetAI = &GetAI_mob_swarm_scarab;
    newscript->RegisterSelf();

        newscript = new Script;
    newscript->Name = "nerubian_burrower";
    newscript->GetAI = &GetAI_nerubian_burrower;
    newscript->RegisterSelf();

        newscript = new Script;
    newscript->Name = "frost_sphere";
    newscript->GetAI = &GetAI_frost_sphere;
    newscript->RegisterSelf();

        newscript = new Script;
    newscript->Name = "creature_impale";
    newscript->GetAI = &GetAI_creature_impale;
    newscript->RegisterSelf();
};