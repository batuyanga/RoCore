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

#include "ScriptPCH.h"
#include "trial_of_the_crusader.h"

#define ROOM_CENTER_X   559.26f
#define ROOM_CENTER_Y   90.27f
#define ROOM_CENTER_Z   395.12f

#define CR_DARK_ORB 34628
#define CR_LIGHT_ORB 34630

#define CR_DARK_ESSENCE 34567
#define CR_LIGHT_ESSENCE 34568

#define SP_DARK_ESSENCE 65684
#define SP_LIGHT_ESSENCE 65686

const Position DarkPos1 = { 538.991f, 161.157f, 394.407f, 3.155010};
const Position DarkPos2 = { 588.270f, 116.376f, 394.407f, 3.155010};
const Position LightPos1 = { 538.095f, 115.621f, 394.407f, 3.155010};
const Position LightPos2 = { 589.019f, 161.349f, 394.407f, 3.155010};

enum Yells
{
        SAY_AGGRO               =       -1600252,        // 16272 In the name of our dark master. For the Lich King. You. Will. Die.
        SAY_COLOR               =       -1600253,        // 16274 CHAOS!
        SAY_DEATH               =       -1600254,        // 16275 The Scourge cannot be stopped...
        SAY_SLAY_1              =       -1600255,        // 16276 UNWORTHY!
        SAY_SLAY_2              =       -1600256,        // 16277 You have been measured, and found wanting!
        SAY_BLACK               =       -1600257,        // 16278 Let the dark consume you!
        SAY_WHITE               =       -1600258,        // 16279 Let the light consume you!
        //SAY_BERSERK           =       -1600259,        // 16273 Berserk
};

enum ConcentratedSpells
{
        N_10_SPELL_UNLEASHED_DARK = 65808,
        N_25_SPELL_UNLEASHED_DARK = 67172,
        H_10_SPELL_UNLEASHED_DARK = 67173,
        H_25_SPELL_UNLEASHED_DARK = 67174,

        N_10_SPELL_UNLEASHED_LIGHT = 65795,
        N_25_SPELL_UNLEASHED_LIGHT = 67238,
        H_10_SPELL_UNLEASHED_LIGHT = 67239,
        H_25_SPELL_UNLEASHED_LIGHT = 67240,
};

#define SP_POWER_OF_THE_TWINS 65916
#define SP_ENRAGE 64238

enum ValkyrSpells
{
         //Darkbane Spells
         N_10_SPELL_SURGE_OF_DARKNESS = 65768,
         N_25_SPELL_SURGE_OF_DARKNESS = 67262,
         H_10_SPELL_SURGE_OF_DARKNESS = 67263,
         H_25_SPELL_SURGE_OF_DARKNESS = 67264,

         N_10_SPELL_SHIELD_OF_DARKNESS = 65874, //175k damage
         N_25_SPELL_SHIELD_OF_DARKNESS = 67256, //700k damage
         H_10_SPELL_SHIELD_OF_DARKNESS = 67257, //300K damage
         H_25_SPELL_SHIELD_OF_DARKNESS = 67258, //1,2 Millionen damage

         N_10_SPELL_DARK_VORTEX = 66058,
         N_25_SPELL_DARK_VORTEX = 67182,
         H_10_SPELL_DARK_VORTEX = 67183,
         H_25_SPELL_DARK_VORTEX = 67184,

         N_10_SPELL_TWIN_SPIKE_N = 66069,
         N_25_SPELL_TWIN_SPIKE_N = 67309,
         H_10_SPELL_TWIN_SPIKE_N = 67310,
         H_25_SPELL_TWIN_SPIKE_N = 67311,

         N_10_SPELL_TWINS_PACT_N = 65875,
         N_25_SPELL_TWINS_PACT_N = 67303,
         H_10_SPELL_TWINS_PACT_N = 67304,
         H_25_SPELL_TWINS_PACT_N = 67305,

        //Lightbane Spells
         N_10_SPELL_SURGE_OF_LIGHT = 65766,
         N_25_SPELL_SURGE_OF_LIGHT = 67270,
         H_10_SPELL_SURGE_OF_LIGHT = 67271,
         H_25_SPELL_SURGE_OF_LIGHT = 67272,

         N_10_SPELL_TWIN_SPIKE                  =       66075,
         N_25_SPELL_TWIN_SPIKE                  =       67312,
         H_10_SPELL_TWIN_SPIKE                  =       67313,
         H_25_SPELL_TWIN_SPIKE                  =       67314,

         N_10_SPELL_SHIELD_OF_LIGHTS    =       65858,
         N_25_SPELL_SHIELD_OF_LIGHTS    =       67259,
         H_10_SPELL_SHIELD_OF_LIGHTS    =       67260,
         H_25_SPELL_SHIELD_OF_LIGHTS    =       67261,

         N_10_SPELL_LIGHT_VORTEX                =       66046,
         N_25_SPELL_LIGHT_VORTEX                =       67206,
         H_10_SPELL_LIGHT_VORTEX                =       67207,
         H_25_SPELL_LIGHT_VORTEX                =       67208,

         N_10_SPELL_TWINS_PACT_L                =       65876,
         N_25_SPELL_TWINS_PACT_L                =       67306,
         H_10_SPELL_TWINS_PACT_L                =       67307,
         H_25_SPELL_TWINS_PACT_L                =       67308,

         SP_SHIELD_OF_LIGHTS = 67259,
         H_SP_SHIELD_OF_LIGHTS = 65858,
         SP_LIGHT_VORTEX = 66046,
         SP_TWINS_PACT_L = 65876,
};

#define ROOM_RADIUS 55.0f

Creature* pEydis;
Creature* pFjola;

/**********************************************************
Fjola Lightbane
**********************************************************/

struct boss_fjolaAI : public ScriptedAI
{
    boss_fjolaAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = (ScriptedInstance *) pCreature->GetInstanceData();
                me->AddUnitMovementFlag(MOVEMENTFLAG_LEVITATING);
    }

    ScriptedInstance* m_pInstance;
    uint64 mDarkbaneGUID;
    uint32 OrbTimer;
    uint32 SpikeTimer;
    uint32 EnrageTimer;
    uint32 SpecialAbilityTimer;

    float summX, summY, summZ;

    void Reset()
    {
        OrbTimer = 5000;
        EnrageTimer = 420000; //7 minutes
        SpecialAbilityTimer = 60000;
        SpikeTimer = 15000;
        mDarkbaneGUID = 0;
                if (me->isAlive()) me->SummonCreature(CR_LIGHT_ESSENCE, LightPos1, TEMPSUMMON_MANUAL_DESPAWN, 5000);
                if (me->isAlive()) me->SummonCreature(CR_LIGHT_ESSENCE, LightPos2, TEMPSUMMON_MANUAL_DESPAWN, 5000);
    }

    void EnterCombat(Unit* pWho)
    {
        if(m_pInstance)
        {
            mDarkbaneGUID = m_pInstance->GetData64(DATA_EYDIS);
            if(Creature *eydis = m_pInstance->instance->GetCreature(mDarkbaneGUID))
                eydis->SetInCombatWithZone();
        }

        DoCast(me, RAID_MODE(N_10_SPELL_SURGE_OF_LIGHT, N_25_SPELL_SURGE_OF_LIGHT, H_10_SPELL_SURGE_OF_LIGHT, H_25_SPELL_SURGE_OF_LIGHT));

                DoScriptText(SAY_AGGRO, me);
    }

        void KilledUnit(Unit *victim)
    {
        if (victim == me)
            return;

        DoScriptText(RAND(SAY_SLAY_1,SAY_SLAY_2), me);
    }

    void JustDied(Unit *killer)
    {
        if(m_pInstance)
        {
            if(Creature *eydis = m_pInstance->instance->GetCreature(mDarkbaneGUID))
                if(eydis->isAlive())
                    eydis->DealDamage(eydis, eydis->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            m_pInstance->SetData(PHASE_6, DONE);
        }
                DoScriptText(SAY_DEATH, me);
    }

    void JustReachedHome()
    {
        if(m_pInstance)
            m_pInstance->SetData(PHASE_6, NOT_STARTED);
    }

    void DamageTaken(Unit *who, uint32 &dmg)
    {
        if(who->GetGUID() == me->GetGUID())
            return;

        if(who->GetTypeId() == TYPEID_PLAYER)
        {
            if(who->HasAura(SP_LIGHT_ESSENCE))
                dmg /= 2;
            else if(who->HasAura(SP_DARK_ESSENCE))
                dmg += dmg/2;
        }

        if(m_pInstance)
        {
            if(Creature *eydis = m_pInstance->instance->GetCreature(mDarkbaneGUID))
                if(eydis->isAlive())
                    eydis->SetHealth(eydis->GetHealth() > dmg ? eydis->GetHealth()-dmg : 1);
        }
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!UpdateVictim())
            return;

        if(me->getVictim()->GetGUID() == mDarkbaneGUID)
            EnterEvadeMode();

        if(OrbTimer < uiDiff)
        {
            float angle = rand_norm() * 2 * 3.1416;
            summX = ROOM_CENTER_X + ROOM_RADIUS * sinf(angle);
            summY = ROOM_CENTER_Y + ROOM_RADIUS * cosf(angle);
            summZ = 395.0f;
            me->SummonCreature(CR_LIGHT_ORB, summX, summY, summZ, 0.0f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 30000);
            OrbTimer = 2500;
        }
        else
            OrbTimer -= uiDiff;

        if(SpecialAbilityTimer < uiDiff)
        {
            if(urand(0,1))
            {
                //Vortex
                DoCast(me, RAID_MODE(N_10_SPELL_LIGHT_VORTEX, N_25_SPELL_LIGHT_VORTEX, H_10_SPELL_LIGHT_VORTEX, H_25_SPELL_LIGHT_VORTEX));
                DoScriptText(SAY_WHITE, me);
            }
            else
            {
                //Twins Pact
                DoCast(me, RAID_MODE(N_10_SPELL_SHIELD_OF_LIGHTS, N_25_SPELL_SHIELD_OF_LIGHTS, H_10_SPELL_SHIELD_OF_LIGHTS, H_25_SPELL_SHIELD_OF_LIGHTS));
                DoCast(me, RAID_MODE(N_10_SPELL_TWINS_PACT_L, N_25_SPELL_TWINS_PACT_L, H_25_SPELL_TWINS_PACT_L, H_25_SPELL_TWINS_PACT_L));
                DoScriptText(SAY_COLOR, me);
                if(Creature *eydis = m_pInstance->instance->GetCreature(mDarkbaneGUID))
                {
                    eydis->CastSpell(eydis, SP_POWER_OF_THE_TWINS, true);
                }
            }
            SpecialAbilityTimer = 120000;
        }
        else
            SpecialAbilityTimer -= uiDiff;

        if(SpikeTimer < uiDiff)
        {
            DoCast(me->getVictim(), RAID_MODE(N_10_SPELL_TWIN_SPIKE, N_25_SPELL_TWIN_SPIKE, H_10_SPELL_TWIN_SPIKE, H_25_SPELL_TWIN_SPIKE));
            SpikeTimer = 20000;
        }
        else
            SpikeTimer -= uiDiff;

        if(EnrageTimer < uiDiff)
        {
            DoCast(me, SP_ENRAGE);
            EnrageTimer = 50000;
        }
        else
            EnrageTimer -= uiDiff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_fjola(Creature* pCreature)
{
    return new boss_fjolaAI(pCreature);
}

/*######
## boss_eydis
######*/

struct boss_eydisAI : public ScriptedAI
{
    boss_eydisAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = (ScriptedInstance *) pCreature->GetInstanceData();
                me->AddUnitMovementFlag(MOVEMENTFLAG_LEVITATING);
    }

    ScriptedInstance *m_pInstance;

    uint64 mLightbaneGUID;
    uint32 OrbTimer;
    uint32 SpikeTimer;
    uint32 EnrageTimer;
    uint32 SpecialAbilityTimer;

    float summX, summY, summZ;

    void Reset()
    {
        OrbTimer = 5000;
        EnrageTimer = 420000; //7 minutes
        SpecialAbilityTimer = 30000;
        SpikeTimer = 15000;
        mLightbaneGUID = 0;
                if (me->isAlive()) me->SummonCreature(CR_DARK_ESSENCE, DarkPos1, TEMPSUMMON_MANUAL_DESPAWN, 5000);
                if (me->isAlive()) me->SummonCreature(CR_DARK_ESSENCE, DarkPos2, TEMPSUMMON_MANUAL_DESPAWN, 5000);
    }

    void EnterCombat(Unit* pWho)
    {
        DoScriptText(SAY_AGGRO, me);

        if(m_pInstance)
        {
            mLightbaneGUID = m_pInstance->GetData64(DATA_FJOLA);
            if(Creature *fjola = m_pInstance->instance->GetCreature(mLightbaneGUID))
                fjola->SetInCombatWithZone();
        }

        DoCast(me, RAID_MODE(N_10_SPELL_SURGE_OF_DARKNESS, N_25_SPELL_SURGE_OF_DARKNESS, H_10_SPELL_SURGE_OF_DARKNESS, H_25_SPELL_SURGE_OF_DARKNESS));
    }

        void KilledUnit(Unit *victim)
    {
        if (victim == me)
            return;

        DoScriptText(RAND(SAY_SLAY_1,SAY_SLAY_2), me);
    }

    void JustDied(Unit *killer)
    {
        if(m_pInstance)
        {
            if(Creature *fjola = m_pInstance->instance->GetCreature(mLightbaneGUID))
                if(fjola->isAlive())
                    fjola->DealDamage(fjola, fjola->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            m_pInstance->SetData(PHASE_6, DONE);
        }
                DoScriptText(SAY_DEATH, me);
    }

    void JustReachedHome()
    {
        if(m_pInstance)
            m_pInstance->SetData(PHASE_6, NOT_STARTED);
    }

    void DamageTaken(Unit *who, uint32 &dmg)
    {
        if(who->GetGUID() == me->GetGUID()) return;

        if(who->GetTypeId() == TYPEID_PLAYER)
        {
            if(who->HasAura(SP_DARK_ESSENCE))
                dmg /= 2;
            else if(who->HasAura(SP_LIGHT_ESSENCE))
                dmg += dmg/2;
        }

        if(m_pInstance)
        {
            if(Creature *fjola = m_pInstance->instance->GetCreature(mLightbaneGUID))
                if(fjola->isAlive())
                    fjola->SetHealth(fjola->GetHealth() > dmg ? fjola->GetHealth()-dmg : 1);
        }
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!UpdateVictim())
            return;

        if(me->getVictim()->GetGUID() == mLightbaneGUID) EnterEvadeMode();

        if(OrbTimer < uiDiff)
        {
            float angle = rand_norm() * 2 * 3.1416;
            summX = ROOM_CENTER_X + ROOM_RADIUS * sinf(angle);
            summY = ROOM_CENTER_Y + ROOM_RADIUS * cosf(angle);
            summZ = 395.0f;
            me->SummonCreature(CR_DARK_ORB, summX, summY, summZ, 0.0f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 30000);
            OrbTimer = 2500;
        }
        else
            OrbTimer -= uiDiff;

        if(SpecialAbilityTimer < uiDiff)
        {
            if(urand(0,1))
            {
                //Vortex
                DoCast(me, RAID_MODE(N_10_SPELL_DARK_VORTEX, N_25_SPELL_DARK_VORTEX, H_10_SPELL_DARK_VORTEX, H_25_SPELL_DARK_VORTEX));
                DoScriptText(SAY_BLACK, me);
            }
            else
            {
                //Twins Pact
                DoCast(me, RAID_MODE(N_10_SPELL_SHIELD_OF_DARKNESS, N_25_SPELL_SHIELD_OF_DARKNESS, H_10_SPELL_SHIELD_OF_DARKNESS, H_25_SPELL_SHIELD_OF_DARKNESS));
                DoCast(me, RAID_MODE(N_10_SPELL_TWINS_PACT_N, N_25_SPELL_TWINS_PACT_N, H_10_SPELL_TWINS_PACT_N, H_25_SPELL_TWINS_PACT_N));
                DoScriptText(SAY_COLOR, me);
                if(Creature *fjola = m_pInstance->instance->GetCreature(mLightbaneGUID))
                {
                    fjola->CastSpell(fjola, SP_POWER_OF_THE_TWINS, true);
                                        //fjola->CastSpell(fjola, RAID_MODE(N_10_SPELL_TWINS_PACT_N, N_25_SPELL_TWINS_PACT_N, H_10_SPELL_TWINS_PACT_N, H_25_SPELL_TWINS_PACT_N), true);
                }
            }
            SpecialAbilityTimer = 120000;
        }
        else
            SpecialAbilityTimer -= uiDiff;

        if(SpikeTimer < uiDiff)
        {
            DoCast(me->getVictim(), RAID_MODE(N_10_SPELL_TWIN_SPIKE_N, N_25_SPELL_TWIN_SPIKE_N, H_10_SPELL_TWIN_SPIKE_N, H_25_SPELL_TWIN_SPIKE_N));
            SpikeTimer = 20000;
        }
        else
            SpikeTimer -= uiDiff;

        if(EnrageTimer < uiDiff)
        {
            DoCast(me, SP_ENRAGE);
            EnrageTimer = 50000;
        }
        else
            EnrageTimer -= uiDiff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_eydis(Creature* pCreature)
{
    return new boss_eydisAI(pCreature);
}

// Concentrated Light/Darkness
struct mob_valkyr_orbAI : public ScriptedAI
{
    mob_valkyr_orbAI(Creature *pCreature) : ScriptedAI(pCreature)
    {
        switch(pCreature->GetEntry())
        {
            case CR_DARK_ORB: spell = RAID_MODE(N_10_SPELL_UNLEASHED_DARK , N_25_SPELL_UNLEASHED_DARK, H_10_SPELL_UNLEASHED_DARK, H_25_SPELL_UNLEASHED_DARK); break;
            case CR_LIGHT_ORB: spell =RAID_MODE(N_10_SPELL_UNLEASHED_LIGHT, N_25_SPELL_UNLEASHED_LIGHT, H_10_SPELL_UNLEASHED_LIGHT, H_25_SPELL_UNLEASHED_LIGHT); break;
        }
        SetCombatMovement(false);
        ChooseDirection();
    }

    uint32 spell;
    bool m_bIsRegularMode;
    float dstX, dstY, dstZ;

    void Reset()
    {
    }

    void AttackStart(Unit *pWho)
    {
        if(!pWho)
            return;

        //if(me->Attack(pWho, false))
        if(me->GetDistance2d(pWho) <= 3.0f)
        {
            me->SetLevel(83);
            me->SetInCombatWithZone();
            me->CastSpell(pWho, spell, true);
            me->DealDamage(me, me->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
        }
    }

    void ChooseDirection()
    {
        float angle = rand_norm() * 2.0f * 3.1416f;
        dstX = ROOM_CENTER_X + ROOM_RADIUS * sinf(angle);
        dstY = ROOM_CENTER_Y + ROOM_RADIUS * cosf(angle);
        dstZ = 394.5f;

        me->GetMotionMaster()->MovePoint(0, dstX, dstY, dstZ);
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if(abs(me->GetPositionX() - dstX) < 2.0f && abs(me->GetPositionY() - dstY) < 2.0f)
        {
            me->GetMotionMaster()->MovementExpired();
            ChooseDirection();
        }
    }
};

struct cr_dark_essenceAI : public ScriptedAI
{
    cr_dark_essenceAI(Creature* pCreature) : ScriptedAI (pCreature)
    {
        m_pInstance = pCreature->GetInstanceData();
    }

    ScriptedInstance* m_pInstance;

    void UpdateAI(const uint32 uiDiff)
    {
        /*if (!pFjola->isAlive())
            me->ForcedDespawn();
        Map* pMap = me->GetMap();
        Map::PlayerList const &PlayerList = pMap->GetPlayers();
        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            if (Player* i_pl = i->getSource())
                if (i_pl->isAlive() && i_pl->HasAura(SP_LIGHT_ESSENCE))
                    i_pl->RemoveAurasDueToSpell(SP_LIGHT_ESSENCE);*/
    }

};

struct cr_light_essenceAI : public ScriptedAI
{
    cr_light_essenceAI(Creature* pCreature) : ScriptedAI (pCreature)
    {
        m_pInstance = pCreature->GetInstanceData();
    }

    ScriptedInstance* m_pInstance;

    void UpdateAI(const uint32 uiDiff)
    {
        /*if (!pEydis->isAlive())
            me->ForcedDespawn();
        Map* pMap = me->GetMap();
        Map::PlayerList const &PlayerList = pMap->GetPlayers();
        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            if (Player* i_pl = i->getSource())
                if (i_pl->isAlive() && i_pl->HasAura(SP_LIGHT_ESSENCE))
                    i_pl->RemoveAurasDueToSpell(SP_LIGHT_ESSENCE);*/
    }

};

CreatureAI* GetAI_mob_valkyr_orb(Creature *pCreature)
{
    return new mob_valkyr_orbAI(pCreature);
}

CreatureAI* GetAI_cr_dark_essence(Creature *pCreature)
{
    return new cr_dark_essenceAI(pCreature);
}

CreatureAI* GetAI_cr_light_essence(Creature *pCreature)
{
    return new cr_light_essenceAI(pCreature);
}

void AddSC_twin_valkyr()
{
    Script* newscript;

    newscript = new Script;
    newscript->Name = "boss_fjola";
    newscript->GetAI = &GetAI_boss_fjola;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "boss_eydis";
    newscript->GetAI = &GetAI_boss_eydis;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_valkyr_orb";
    newscript->GetAI = &GetAI_mob_valkyr_orb;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "cr_dark_essence";
    newscript->GetAI = &GetAI_cr_dark_essence;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "cr_light_essence";
    newscript->GetAI = &GetAI_cr_light_essence;
    newscript->RegisterSelf();
}