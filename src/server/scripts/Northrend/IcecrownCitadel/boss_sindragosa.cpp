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

const Position FlyPosition = { 4474.239746f, 2484.243896f, 231.0f, 3.155010f};
const Position LandPosition = { 4407.439453f, 2484.90541f, 203.374374f, 3.166791f};
const Position SpawnPosition = {4408.052734f, 2484.825439f, 203.374207f, 3.166791f};

enum Yells
{
    SAY_AGGRO = -1666071,
    SAY_UNCHAINED_MAGIC = -1666072,
    SAY_BLISTERING_COLD = -1666073,
    SAY_BREATH = -1666074,
    SAY_AIR_PHASE = -1666075,
    SAY_PHASE_3 = -1666076,
    SAY_KILL_1 = -1666077,
    SAY_KILL_2 = -1666078,
    SAY_BERSERK = -1666079,
    SAY_DEATH = -1666080,
};

enum Spells
{
    SPELL_FROST_AURA_10_NORMAL = 70084,
    SPELL_FROST_AURA_25_NORMAL = 71050,
    SPELL_CLEAVE = 19983,
    SPELL_TAIL_SMASH = 71077,
    SPELL_FROST_BREATH_10_NORMAL = 73061,
    SPELL_FROST_BREATH_25_NORMAL = 71056,
    SPELL_PERMEATING_CHILL = 70109,
    SPELL_UNCHAINED_MAGIC = 69762,
    SPELL_ICY_GRIP_TRIGGER = 70117,
    SPELL_ICY_TRIP_PULL = 70117,
    SPELL_BLISTERING_COLD_10_NORMAL = 70123,
    SPELL_BLISTERING_COLD_25_NORMAL = 71047,
    SPELL_FROST_BOMB_TRIGGER = 69846,
    SPELL_FROST_BEACON = 70126,
    SPELL_ICE_TOMB = 70157,
    SPELL_ICE_TOMB_TRIGGER = 69675,
    SPELL_FROST_BOMB = 71053,
    SPELL_MYSTIC_BUFFET = 70128,
    SPELL_BERSERK = 47008,
    SPELL_FROSTBOMBVISUAL = 70022,
    SPELL_ASPHYXIATION = 71665,
    SPELL_RIMEFANG_FROST_AURA = 71387,
    SPELL_RIMEFANG_FROST_BREATH = 71386,
    SPELL_RIMEFANG_ICY_BLAST = 71376,
    SPELL_SPINESTALKER_ROAR = 36922,
    SPELL_SPINESTALKER_CLEAVE = 40505,
    SPELL_SPINESTALKER_TAIL_SWEEP_10 = 71369,
    SPELL_SPINESTALKER_TAIL_SWEEP_25 = 71370,
    SPELL_ROOT = 42716,
};

enum Mobs
{
    NPC_ICE_TOMB = 36980,
    NPC_FROST_BOMB = 37186,
};

enum Creatures
{
    NPC_RIMEFANG = 37533,
    NPC_SPINESTALKER = 37534,
    NPC_SINDRAGOSA = 36853,
};

enum Phase
{
    PHASE_LAND = 1,
    PHASE_FLY = 2,
    PHASE_ENRAGE = 3,
};

Creature* pRimefang;
Creature* pSpinestalker;
Creature* pSindragosa;

std::vector<Creature*> icetombs;
std::vector<Player*> targets;

struct npc_ice_tombAI : public Scripted_NoMovementAI
{
    npc_ice_tombAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature)
    {
        IceTombGUID = 0;
    }

    uint64 IceTombGUID;

    void SetPrisoner(Unit* uPrisoner)
    {
        IceTombGUID = uPrisoner->GetGUID();
    }

    void Reset()
    {
        IceTombGUID = 0;
    }

    void JustDied(Unit *killer)
    {
        if (killer->GetGUID() != me->GetGUID())

            if (IceTombGUID)
            {
                Unit* Tomb = Unit::GetUnit((*me), IceTombGUID);
                if (Tomb)
                    {
                        Tomb->RemoveAurasDueToSpell(SPELL_ICE_TOMB);
                        Tomb->RemoveAurasDueToSpell(SPELL_ASPHYXIATION);
                    }
            }
        icetombs.clear();
    }

    void KilledUnit(Unit *pVictim)
    {
        if (pVictim->GetGUID() != me->GetGUID())

            if (IceTombGUID)
            {
                Unit* Tomb = Unit::GetUnit((*me), IceTombGUID);
                if (Tomb)
                    {
                        Tomb->RemoveAurasDueToSpell(SPELL_ICE_TOMB);
                        Tomb->RemoveAurasDueToSpell(SPELL_ASPHYXIATION);
                    }
            }
    }

    void UpdateAI(const uint32 diff)
    {
        Unit* temp = Unit::GetUnit((*me),IceTombGUID);
        if ((temp && temp->isAlive() && !temp->HasAura(SPELL_ICE_TOMB)) || !temp)
            me->DealDamage(me, me->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
    }
};

struct boss_sindragosaAI : public ScriptedAI
{
    boss_sindragosaAI(Creature* pCreature) : ScriptedAI (pCreature)
    {
        m_pInstance = pCreature->GetInstanceData();
        pSindragosa = me;
    }

    ScriptedInstance* m_pInstance;

    uint8 Phase;

    uint32 m_uiBreathTimer;
    uint32 m_uiCleaveTimer;
    uint32 m_uiTailSmashTimer;
    uint32 m_uiBlisteringColdTimer;
    uint32 m_uiBerserkTimer;
    uint32 m_uiMarkTimer;
    uint32 m_uiIceBoltTriggerTimer;
    uint32 m_uiPhaseTimer;
    uint32 m_uiUnchainedMagicTimer;
    uint32 m_uiMysticBuffetTimer;
    uint32 m_uiIceBombTimer;
    uint32 m_uiAsphyxiationTimer;

    void Reset()
    {
        Phase = PHASE_LAND;

        m_uiBreathTimer = 15000;
        m_uiCleaveTimer = 10000;
        m_uiTailSmashTimer = 10000;
        m_uiBlisteringColdTimer = 30000;
        //m_uiMarkTimer = 20000;
        m_uiPhaseTimer = 60000;
        m_uiBerserkTimer = 600000;
        m_uiUnchainedMagicTimer = 10000;
        m_uiMysticBuffetTimer = 10000;
        m_uiAsphyxiationTimer = 20000;
        //m_uiIceBombTimer = 30000;

        me->SetSpeed(MOVE_WALK, 1.5f, true);
        me->SetSpeed(MOVE_RUN, 1.5f, true);
        me->SetSpeed(MOVE_FLIGHT, 2.5f, true);

        me->SetFlying(false);
        me->SetReactState(REACT_AGGRESSIVE);

        if (m_pInstance)
            m_pInstance->SetData(DATA_SINDRAGOSA_EVENT, NOT_STARTED);

    }

    void EnterCombat(Unit* who)
    {
        if (!me->HasAura(RAID_MODE(SPELL_FROST_AURA_10_NORMAL,SPELL_FROST_AURA_25_NORMAL)))
            DoCast(me, RAID_MODE(SPELL_FROST_AURA_10_NORMAL,SPELL_FROST_AURA_25_NORMAL));
        if (!me->HasAura(SPELL_PERMEATING_CHILL))
            DoCast(SPELL_PERMEATING_CHILL);
        DoScriptText(SAY_AGGRO, me);

        if (m_pInstance)
            m_pInstance->SetData(DATA_SINDRAGOSA_EVENT, IN_PROGRESS);
    }

    void JustDied(Unit* pKiller)
    {
        DoScriptText(SAY_DEATH, me);
        if (m_pInstance)
            m_pInstance->SetData(DATA_SINDRAGOSA_EVENT, DONE);
    }

    void JustReachedHome()
    {
        if(m_pInstance)
            m_pInstance->SetData(DATA_SINDRAGOSA_EVENT, FAIL);
        pRimefang->Respawn();
        pSpinestalker->Respawn();
                me->ForcedDespawn();
    }

     void KilledUnit(Unit *victim)
    {
        switch (urand(0,1))
        {
        case 0:
            DoScriptText(SAY_KILL_1,me);
        break;

        case 1:
            DoScriptText(SAY_KILL_2,me);
        break;
        }
    }

    void MarkPlayer()
    {
        uint32 count = RAID_MODE(2,5,2,5);
        if (Phase == PHASE_ENRAGE) count = RAID_MODE(1,2,1,2);
        for ( uint8 i = 1; i<=count; i++ )
            {
            Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,0);
            if (pTarget && !pTarget->HasAura(SPELL_FROST_BEACON))
                {
                    DoCast(pTarget, SPELL_FROST_BEACON, true);
                }
            }
    }

    void CastIceBlockTrigger()
    {
        Map* pMap = me->GetMap();
        Map::PlayerList const &PlayerList = pMap->GetPlayers();
        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            if (Player* i_pl = i->getSource())
                if (i_pl->isAlive() && i_pl->HasAura(SPELL_FROST_BEACON))
                    {
                        DoCast(i_pl, SPELL_ICE_TOMB_TRIGGER);
                        Creature* Tomb = me->SummonCreature(NPC_ICE_TOMB, i_pl->GetPositionX(), i_pl->GetPositionY(), i_pl->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 999999);
                        icetombs.push_back(Tomb);
                        CAST_AI(npc_ice_tombAI, Tomb->AI())->SetPrisoner(i_pl);
                        Tomb->CastSpell(i_pl, SPELL_ICE_TOMB, true);
                        //Tomb->CastSpell(i_pl, SPELL_ASPHYXIATION, true);
                    }

        /*Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,0);

        if (pTarget && pTarget->HasAura(SPELL_FROST_BEACON))
        {
            DoCast(pTarget, SPELL_ICE_TOMB_TRIGGER);
        }*/
    }

    void FrostBombTrigger()
    {
        Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,0);
        if (pTarget && !pTarget->HasAura(SPELL_ASPHYXIATION))
            DoCast(pTarget, SPELL_FROST_BOMB_TRIGGER);
    }

    void UnchainedMagic()
    {
        Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,0);
        if (pTarget && !pTarget->HasAura(SPELL_UNCHAINED_MAGIC) && !me->IsWithinDistInMap(pTarget, 5) && pTarget->getPowerType() == POWER_MANA)
        {
            DoCast(pTarget, SPELL_UNCHAINED_MAGIC);
            DoScriptText(SAY_UNCHAINED_MAGIC, me);
        }
    }

    void BlisteringCold()
    {
        Map* pMap = me->GetMap();
        Map::PlayerList const &PlayerList = pMap->GetPlayers();
        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            if (Player* i_pl = i->getSource())
                if (i_pl->isAlive())
                    i_pl->TeleportTo(me->GetMapId(), me->GetPositionX(),me->GetPositionY(),me->GetPositionZ(), 0, TELE_TO_NOT_LEAVE_COMBAT);
        DoScriptText(SAY_BLISTERING_COLD, me);
        DoCast(me, SPELL_ICY_GRIP_TRIGGER);
        DoCast(me, RAID_MODE(SPELL_BLISTERING_COLD_10_NORMAL,SPELL_BLISTERING_COLD_25_NORMAL));
    }

    void MysticBuffet()
    {
        Map* pMap = me->GetMap();
        Map::PlayerList const &PlayerList = pMap->GetPlayers();
        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            if (Player* i_pl = i->getSource())
                if (i_pl->isAlive())
                    DoCast(i_pl, SPELL_MYSTIC_BUFFET);
    }

    void WorkAroundForLoSmkII()
    {
        Map* pMap = me->GetMap();
        Map::PlayerList const &PlayerList = pMap->GetPlayers();
        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
        if (Player* pTarget = i->getSource())
        {
            for (std::vector<Creature*>::const_iterator itr = icetombs.begin(); itr != icetombs.end(); ++itr)
            {
                if (Creature* pGo = (*itr))
                    if (pGo->IsInBetween(me, pTarget, 2.0f)
                        && me->GetExactDist2d(pTarget->GetPositionX(), pTarget->GetPositionY()) - me->GetExactDist2d(pGo->GetPositionX(), pGo->GetPositionY()) < 5.0f)
                    {
                        pTarget->ApplySpellImmune(0, IMMUNITY_ID, SPELL_MYSTIC_BUFFET, true);
                        targets.push_back(pTarget);
                        break;
                    }
            }
        }

        MysticBuffet();

        for (std::vector<Player*>::const_iterator itr = targets.begin(); itr != targets.end(); ++itr)
            (*itr)->ApplySpellImmune(0, IMMUNITY_ID, SPELL_MYSTIC_BUFFET, false);
    }

    void TakeOff()
    {
        me->InterruptSpell(CURRENT_GENERIC_SPELL);
        me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
        me->GetMotionMaster()->MovePoint(0, FlyPosition);
        me->SetReactState(REACT_PASSIVE);
        me->AttackStop();
        me->SetFlying(true);
        DoScriptText(SAY_AIR_PHASE, me);

        m_uiPhaseTimer = 60000;
    }

    void LandDown()
    {
        me->GetMotionMaster()->MovePoint(0, SpawnPosition);
        me->SetFlying(false);
        me->SetReactState(REACT_AGGRESSIVE);
        //me->GetMotionMaster()->MoveChase(me->getVictim());

        m_uiPhaseTimer = 60000;
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!UpdateVictim())
            return;

        if (m_uiBerserkTimer < uiDiff)
        {
            DoCast(me, SPELL_BERSERK);
            DoScriptText(SAY_BERSERK, me);
            m_uiBerserkTimer = 9999999;
        } else m_uiBerserkTimer -= uiDiff;

        if(Phase == PHASE_LAND || Phase == PHASE_ENRAGE)
        {
            if (m_uiBreathTimer <= uiDiff)
            {
                DoScriptText(SAY_BREATH, me);
                DoCast(me, RAID_MODE(SPELL_FROST_BREATH_10_NORMAL,SPELL_FROST_BREATH_25_NORMAL));
                m_uiBreathTimer = 15000;
            } else m_uiBreathTimer -= uiDiff;

            if (m_uiCleaveTimer <= uiDiff)
            {
                DoCast(me, SPELL_CLEAVE);
                m_uiCleaveTimer = 10000;
            } else m_uiCleaveTimer -= uiDiff;

            if (m_uiTailSmashTimer <= uiDiff)
            {
                DoCast(me, SPELL_TAIL_SMASH);
                m_uiTailSmashTimer = 8000;
            } else m_uiTailSmashTimer -= uiDiff;

            if (m_uiBlisteringColdTimer <= uiDiff)
            {
                BlisteringCold();
                m_uiBlisteringColdTimer = 30000;
            } else m_uiBlisteringColdTimer -= uiDiff;

            if (m_uiUnchainedMagicTimer <= uiDiff)
            {
                UnchainedMagic();
                m_uiUnchainedMagicTimer = 10000;
            } else m_uiUnchainedMagicTimer -= uiDiff;
        }

        if(Phase == PHASE_LAND)
        {
            if ((m_uiPhaseTimer <= uiDiff) || ((me->GetHealth()*100) / me->GetMaxHealth() < 85))
            {
                Phase = PHASE_FLY;
                m_uiPhaseTimer = 60000;
                TakeOff();
                m_uiMarkTimer = 15000;
            } else m_uiPhaseTimer -= uiDiff;
        }

        if(Phase == PHASE_FLY)
        {
            if (m_uiPhaseTimer <= uiDiff)
            {
                Phase = PHASE_LAND;
                m_uiPhaseTimer = 60000;
                LandDown();
            } else m_uiPhaseTimer -= uiDiff;

            if (m_uiMarkTimer < uiDiff)
            {
                MarkPlayer();
                m_uiMarkTimer = 9999999;
                m_uiIceBoltTriggerTimer = 5000;
            } else m_uiMarkTimer -= uiDiff;

            if (m_uiIceBoltTriggerTimer < uiDiff)
            {
                CastIceBlockTrigger();
                m_uiIceBoltTriggerTimer = 9999999;
                m_uiIceBombTimer = 10000;
            } else m_uiIceBoltTriggerTimer -= uiDiff;

            if (m_uiIceBombTimer <= uiDiff)
            {
                FrostBombTrigger();
                m_uiIceBombTimer = 10000;
            } else m_uiIceBombTimer -= uiDiff;
        }

        if(Phase == PHASE_ENRAGE)
        {
            if (m_uiMysticBuffetTimer <= uiDiff)
            {
                WorkAroundForLoSmkII();
                m_uiMysticBuffetTimer = 10000;
            } else m_uiMysticBuffetTimer -= uiDiff;

            if (m_uiMarkTimer < uiDiff)
            {
                MarkPlayer();
                m_uiMarkTimer = 9999999;
                m_uiIceBoltTriggerTimer = 5000;
            } else m_uiMarkTimer -= uiDiff;

            if (m_uiIceBoltTriggerTimer < uiDiff)
            {
                CastIceBlockTrigger();
                m_uiIceBoltTriggerTimer = 35000;
                m_uiMarkTimer = 30000;
            } else m_uiIceBoltTriggerTimer -= uiDiff;
        }

        if(Phase == PHASE_LAND || Phase == PHASE_FLY)
        {
            if((me->GetHealth()*100) / me->GetMaxHealth() < 35)
            {
                if (Phase == PHASE_FLY) LandDown();
                Phase = PHASE_ENRAGE;
                m_uiMarkTimer = 15000;
                //DoCast(me, SPELL_MYSTIC_BUFFET);
                WorkAroundForLoSmkII();
                DoScriptText(SAY_PHASE_3, me);
            }
        }

        DoMeleeAttackIfReady();
    }
};

struct npc_frost_bombAI : public ScriptedAI
{
    npc_frost_bombAI(Creature* pCreature) : ScriptedAI (pCreature)
    {
        m_pInstance = pCreature->GetInstanceData();
    }

    ScriptedInstance* m_pInstance;

    uint32 m_uiBlastTimer;

    void Reset()
    {
        me->SetReactState(REACT_PASSIVE);
        if (!me->HasAura(SPELL_ROOT))
            DoCast(me, SPELL_ROOT);
        m_uiBlastTimer = 3000;
        if (!me->HasAura(SPELL_FROSTBOMBVISUAL))
            DoCast(me, SPELL_FROSTBOMBVISUAL);
    }

    void JustDied(Unit *killer)
    {
        me->RemoveAura(SPELL_FROSTBOMBVISUAL);
    }

    void WorkAroundForLoS()
    {
        Map* pMap = me->GetMap();
        Map::PlayerList const &PlayerList = pMap->GetPlayers();
        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
        if (Player* pTarget = i->getSource())
        {
            if (pTarget->HasAura(SPELL_ASPHYXIATION))
            {
                pTarget->ApplySpellImmune(0, IMMUNITY_ID, SPELL_FROST_BOMB, true);
                targets.push_back(pTarget);
                continue;
            }

            for (std::vector<Creature*>::const_iterator itr = icetombs.begin(); itr != icetombs.end(); ++itr)
            {
                if (Creature* pGo = (*itr))
                    if (pGo->IsInBetween(me, pTarget, 2.0f)
                        && me->GetExactDist2d(pTarget->GetPositionX(), pTarget->GetPositionY()) - me->GetExactDist2d(pGo->GetPositionX(), pGo->GetPositionY()) < 5.0f)
                    {
                        pTarget->ApplySpellImmune(0, IMMUNITY_ID, SPELL_FROST_BOMB, true);
                        targets.push_back(pTarget);
                        break;
                    }
            }
        }

        DoCast(SPELL_FROST_BOMB);

        for (std::vector<Player*>::const_iterator itr = targets.begin(); itr != targets.end(); ++itr)
            (*itr)->ApplySpellImmune(0, IMMUNITY_ID, SPELL_FROST_BOMB, false);
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (m_uiBlastTimer <= uiDiff)
        {
            WorkAroundForLoS();
            me->ForcedDespawn();
        } else m_uiBlastTimer -= uiDiff;
    }

};

struct npc_rimefangAI : public ScriptedAI
{
    npc_rimefangAI(Creature* pCreature) : ScriptedAI (pCreature)
    {
        m_pInstance = pCreature->GetInstanceData();
        pRimefang = me;
    }

    ScriptedInstance* m_pInstance;

    uint32 m_uiRimefangFrostBreath;
    uint32 m_uiRimefangIcyBlast;

    void Reset()
    {
        m_uiRimefangFrostBreath = 10000;
        m_uiRimefangIcyBlast = 15000;
    }

    void EnterCombat(Unit* who)
    {
        if (!me->HasAura(SPELL_RIMEFANG_FROST_AURA))
            DoCast(SPELL_RIMEFANG_FROST_AURA);
    }

    void JustDied(Unit *killer)
    {
        if (!pSpinestalker->isAlive())
            me->SummonCreature(NPC_SINDRAGOSA, SpawnPosition, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 600000);
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (m_uiRimefangFrostBreath <= uiDiff)
        {
            DoCast(SPELL_RIMEFANG_FROST_BREATH);
            m_uiRimefangFrostBreath = 10000;
        } else m_uiRimefangFrostBreath -= uiDiff;

        if (m_uiRimefangIcyBlast <= uiDiff)
        {
            DoCast(SPELL_RIMEFANG_ICY_BLAST);
            m_uiRimefangIcyBlast = 15000;
        } else m_uiRimefangIcyBlast -= uiDiff;

        DoMeleeAttackIfReady();
    }
};

struct npc_spinestalkerAI : public ScriptedAI
{
    npc_spinestalkerAI(Creature* pCreature) : ScriptedAI (pCreature)
    {
        m_pInstance = pCreature->GetInstanceData();
        pSpinestalker = me;
    }

    ScriptedInstance* m_pInstance;

    uint32 m_uiSpinestalkerRoar;
    uint32 m_uiSpinestalkerCleave;
    uint32 m_uiSpinestalkerTailSweep;

    void Reset()
    {
        m_uiSpinestalkerRoar = 10000;
        m_uiSpinestalkerCleave = 5000;
        m_uiSpinestalkerTailSweep = 2000;
    }

    void JustDied(Unit *killer)
    {
        if (!pRimefang->isAlive())
            me->SummonCreature(NPC_SINDRAGOSA, SpawnPosition, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 600000);
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (m_uiSpinestalkerRoar <= uiDiff)
        {
            DoCast(me, SPELL_SPINESTALKER_ROAR);
            m_uiSpinestalkerRoar = 10000;
        } else m_uiSpinestalkerRoar -= uiDiff;

        if (m_uiSpinestalkerCleave <= uiDiff)
        {
            DoCast(SPELL_SPINESTALKER_CLEAVE);
            m_uiSpinestalkerCleave = 5000;
        } else m_uiSpinestalkerCleave -= uiDiff;

        if (m_uiSpinestalkerTailSweep <= uiDiff)
        {
            DoCast(RAID_MODE(SPELL_SPINESTALKER_TAIL_SWEEP_10,SPELL_SPINESTALKER_TAIL_SWEEP_25,SPELL_SPINESTALKER_TAIL_SWEEP_10,SPELL_SPINESTALKER_TAIL_SWEEP_25));
            m_uiSpinestalkerTailSweep = 2000;
        } else m_uiSpinestalkerTailSweep -= uiDiff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_sindragosa(Creature* pCreature)
{
    return new boss_sindragosaAI(pCreature);
}

CreatureAI* GetAI_npc_rimefang(Creature* pCreature)
{
    return new npc_rimefangAI(pCreature);
}

CreatureAI* GetAI_npc_spinestalker(Creature* pCreature)
{
    return new npc_spinestalkerAI(pCreature);
}

CreatureAI* GetAI_npc_ice_tomb(Creature* pCreature)
{
    return new npc_ice_tombAI(pCreature);
}

CreatureAI* GetAI_npc_frost_bomb(Creature* pCreature)
{
    return new npc_frost_bombAI(pCreature);
}

void AddSC_boss_sindragosa()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "boss_sindragosa";
    newscript->GetAI = &GetAI_boss_sindragosa;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_spinestalker";
    newscript->GetAI = &GetAI_npc_spinestalker;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_rimefang";
    newscript->GetAI = &GetAI_npc_rimefang;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_ice_tomb";
    newscript->GetAI = &GetAI_npc_ice_tomb;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_frost_bomb";
    newscript->GetAI = &GetAI_npc_frost_bomb;
    newscript->RegisterSelf();
}