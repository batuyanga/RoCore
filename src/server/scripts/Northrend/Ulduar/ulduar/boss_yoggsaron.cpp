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
SDName: Yogg-Saron
SDAuthor: PrinceCreed
SD%Complete: 25
SDComments: Keeper's scripts completed
EndScriptData */

#include "ScriptPCH.h"
#include "ulduar.h"

enum Sara_Yells
{
    SAY_SARA_PREFIGHT_1                         = -1603310,
    SAY_SARA_PREFIGHT_2                         = -1603311,
    SAY_SARA_AGGRO_1                            = -1603312,
    SAY_SARA_AGGRO_2                            = -1603313,
    SAY_SARA_AGGRO_3                            = -1603314,
    SAY_SARA_SLAY_1                             = -1603315,
    SAY_SARA_SLAY_2                             = -1603316,
    WHISP_SARA_INSANITY                         = -1603317,
    SAY_SARA_PHASE2_1                           = -1603318,
    SAY_SARA_PHASE2_2                           = -1603319,
};

enum YoggSaron_Yells
{
    SAY_PHASE2_1                                = -1603330,
    SAY_PHASE2_2                                = -1603331,
    SAY_PHASE2_3                                = -1603332,
    SAY_PHASE2_4                                = -1603333,
    SAY_PHASE2_5                                = -1603334,
    SAY_PHASE3                                  = -1603335,
    SAY_VISION                                  = -1603336,
    SAY_SLAY_1                                  = -1603337,
    SAY_SLAY_2                                  = -1603338,
    WHISP_INSANITY_1                            = -1603339,
    WHISP_INSANITY_2                            = -1603340,
    SAY_DEATH                                   = -1603341,
};

enum Phases
{
    PHASE_NULL = 0,
    PHASE_1,
    PHASE_2,
    PHASE_3
};

Phases phase;

// Images of Keepers
enum Npcs
{
    NPC_IMAGE_OF_FREYA                          = 33241,
    NPC_IMAGE_OF_THORIM                         = 33242,
    NPC_IMAGE_OF_MIMIRON                        = 33244,
    NPC_IMAGE_OF_HODIR                          = 33213,
    
    NPC_SANITY_WELL                             = 33991,
};

#define GOSSIP_KEEPER_HELP                      "I need your help."

enum Keepers_Yells
{
    SAY_MIMIRON_HELP                            = -1603259,
    SAY_FREYA_HELP                              = -1603189,
    SAY_THORIM_HELP                             = -1603287,
    SAY_HODIR_HELP                              = -1603217,
};

enum Keepers_Spells
{
    SPELL_KEEPER_ACTIVE                         = 62647,
    
    // Freya
    SPELL_RESILIENCE_OF_NATURE                  = 62670,
    SPELL_SANITY_WELL_SPAWN                     = 64170,
    SPELL_SANITY_WELL_VISUAL                    = 63288,
    SPELL_SANITY_WELL                           = 64169,

    // Thorim
    SPELL_FURY_OF_THE_STORMS                    = 62702,
    SPELL_TITANIC_STORM                         = 64171,
    SPELL_TITANIC_STORM_DEBUFF                  = 64162,

    // Mimiron
    SPELL_SPEED_OF_INVENTION                    = 62671,
    SPELL_DESTABILIZATION                       = 65210,
    SPELL_DESTABILIZATION_DEBUFF                = 65206,

    // Hodir
    SPELL_FORTITUDE_OF_FROST                    = 62650,
    SPELL_PROTECTIVE_GAZE                       = 64174
};

const Position SanityWellPos[10] =
{
{2008.38,35.41,331.251,0},
{1990.63,50.35,332.041,0},
{1973.40,41.09,330.989,0},
{1973.12,-90.27,330.14,0},
{1994.26,-96.62,330.62,0},
{2005.41,-82.88,329.50,0},
{2042.09,-41.70,329.12,0},
{1918.06,16.50,330.970,0},
{1899.59,-4.87,332.137,0},
{1897.75,-48.24,332.35,0}
};


/*------------------------------------------------------*
 *                  Images of Keepers                   *
 *------------------------------------------------------*/

struct keeper_imageAI : public ScriptedAI
{
    keeper_imageAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance* pInstance;
};

bool GossipHello_keeper_image(Player* pPlayer, Creature* pCreature)
{
    InstanceData *data = pPlayer->GetInstanceData();
    ScriptedInstance *pInstance = (ScriptedInstance *) pCreature->GetInstanceData();
    
    if (pInstance && pPlayer)
    {
        if (!pCreature->HasAura(SPELL_KEEPER_ACTIVE))
       {
            pPlayer->PrepareQuestMenu(pCreature->GetGUID());
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_KEEPER_HELP, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
            pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
        }
    }
    return true;
}

bool GossipSelect_keeper_image(Player* pPlayer, Creature* pCreature, uint32 uiSender, uint32 uiAction)
{
    InstanceData *data = pPlayer->GetInstanceData();
    ScriptedInstance* pInstance = pCreature->GetInstanceData();
    
    if (pPlayer)
        pPlayer->CLOSE_GOSSIP_MENU();
        
    switch (pCreature->GetEntry())
    {
        case NPC_IMAGE_OF_FREYA:
            DoScriptText(SAY_FREYA_HELP, pCreature);
            pCreature->CastSpell(pCreature, SPELL_KEEPER_ACTIVE, true);
            if (Creature *pFreya = pCreature->GetCreature(*pCreature, pInstance->GetData64(DATA_YS_FREYA)))
               pFreya->SetVisibility(VISIBILITY_ON);
            break;
        case NPC_IMAGE_OF_THORIM:
            DoScriptText(SAY_THORIM_HELP, pCreature);
            pCreature->CastSpell(pCreature, SPELL_KEEPER_ACTIVE, true);
            if (Creature *pThorim = pCreature->GetCreature(*pCreature, pInstance->GetData64(DATA_YS_THORIM)))
                pThorim->SetVisibility(VISIBILITY_ON);
            break;
        case NPC_IMAGE_OF_MIMIRON:
            DoScriptText(SAY_MIMIRON_HELP, pCreature);
            pCreature->CastSpell(pCreature, SPELL_KEEPER_ACTIVE, true);
            if (Creature *pMimiron = pCreature->GetCreature(*pCreature, pInstance->GetData64(DATA_YS_MIMIRON)))
                pMimiron->SetVisibility(VISIBILITY_ON);
            break;
        case NPC_IMAGE_OF_HODIR:
            DoScriptText(SAY_HODIR_HELP, pCreature);
            pCreature->CastSpell(pCreature, SPELL_KEEPER_ACTIVE, true);
            if (Creature *pHodir = pCreature->GetCreature(*pCreature, pInstance->GetData64(DATA_YS_HODIR)))
                pHodir->SetVisibility(VISIBILITY_ON);
            break;
    }
    return true;
}

CreatureAI* GetAI_keeper_image(Creature* pCreature)
{
    return new keeper_imageAI (pCreature);
}


struct npc_ys_freyaAI : public ScriptedAI
{
    npc_ys_freyaAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        pInstance = pCreature->GetInstanceData();
        me->SetReactState(REACT_PASSIVE);
        me->SetVisibility(VISIBILITY_OFF);
    }

    ScriptedInstance* pInstance;
    int32 WellTimer;

    void Reset()
    {
        WellTimer = urand(5000, 10000);
    }
    
    void EnterCombat()
    {
        DoCast(me, SPELL_RESILIENCE_OF_NATURE);
    }
    
    void UpdateAI(const uint32 uiDiff)
    {
        if (!UpdateVictim())
            return;
            
        if (WellTimer <= uiDiff)
        {
            DoCast(SPELL_SANITY_WELL_SPAWN);
            me->SummonCreature(NPC_SANITY_WELL, SanityWellPos[rand()%10], TEMPSUMMON_TIMED_DESPAWN, 60000);
            WellTimer = 15000;
        }
        else WellTimer -= uiDiff;
    }
};

CreatureAI* GetAI_npc_ys_freya(Creature* pCreature)
{
    return new npc_ys_freyaAI(pCreature);
}

struct npc_sanity_wellAI : public Scripted_NoMovementAI
{
    npc_sanity_wellAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature)
    {
        pInstance = pCreature->GetInstanceData();
        DoCast(me, SPELL_SANITY_WELL_VISUAL);
        DoCast(me, SPELL_SANITY_WELL);
    }

    ScriptedInstance* pInstance;
};

CreatureAI* GetAI_npc_sanity_well(Creature* pCreature)
{
    return new npc_sanity_wellAI(pCreature);
}

struct npc_ys_thorimAI : public ScriptedAI
{
    npc_ys_thorimAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        pInstance = pCreature->GetInstanceData();
        me->SetReactState(REACT_PASSIVE);
        me->SetVisibility(VISIBILITY_OFF);
    }

    ScriptedInstance* pInstance;

    void Reset(){}
    
    void EnterCombat()
    {
        DoCast(me, SPELL_FURY_OF_THE_STORMS);
    }
    
    void UpdateAI(const uint32 uiDiff)
    {
        if (!UpdateVictim() || me->hasUnitState(UNIT_STAT_CASTING))
            return;
            
        if (!me->HasAura(SPELL_TITANIC_STORM) && phase == PHASE_3)
            DoCast(me, SPELL_TITANIC_STORM);
    }
};

CreatureAI* GetAI_npc_ys_thorim(Creature* pCreature)
{
    return new npc_ys_thorimAI(pCreature);
}

struct npc_ys_mimironAI : public ScriptedAI
{
    npc_ys_mimironAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        pInstance = pCreature->GetInstanceData();
        me->SetReactState(REACT_PASSIVE);
        me->SetVisibility(VISIBILITY_OFF);
    }

    ScriptedInstance* pInstance;
    int32 DestabilizeTimer;

    void Reset()
    {
        DestabilizeTimer = 15000;
    }
    
    void EnterCombat()
    {
        DoCast(me, SPELL_SPEED_OF_INVENTION);
    }
    
    void UpdateAI(const uint32 uiDiff)
    {
        if (!UpdateVictim())
            return;
            
        if (DestabilizeTimer <= uiDiff)
        {
            if (phase == PHASE_2)
                DoCast(SPELL_DESTABILIZATION);
            DestabilizeTimer = 15000;
        }
        else DestabilizeTimer -= uiDiff;            
    }
};

CreatureAI* GetAI_npc_ys_mimiron(Creature* pCreature)
{
    return new npc_ys_mimironAI(pCreature);
}

struct npc_ys_hodirAI : public ScriptedAI
{
    npc_ys_hodirAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        pInstance = pCreature->GetInstanceData();
        me->SetReactState(REACT_PASSIVE);
        me->SetVisibility(VISIBILITY_OFF);
    }

    ScriptedInstance* pInstance;

    void Reset(){}
    
    void EnterCombat()
    {
        DoCast(me, SPELL_FORTITUDE_OF_FROST);
    }
    
    void UpdateAI(const uint32 uiDiff)
    {
        if (!UpdateVictim())
            return;
    }
};

CreatureAI* GetAI_npc_ys_hodir(Creature* pCreature)
{
    return new npc_ys_hodirAI(pCreature);
}

void AddSC_boss_yogg_saron()
{
    Script *newscript;
    
    newscript = new Script;
    newscript->Name="npc_keeper_image";
    newscript->pGossipHello =  &GossipHello_keeper_image;
    newscript->pGossipSelect = &GossipSelect_keeper_image;
    newscript->GetAI = &GetAI_keeper_image;
    newscript->RegisterSelf();
    
    newscript = new Script;
    newscript->Name = "npc_ys_freya";
    newscript->GetAI = &GetAI_npc_ys_freya;
    newscript->RegisterSelf();
    
    newscript = new Script;
    newscript->Name = "npc_ys_thorim";
    newscript->GetAI = &GetAI_npc_ys_thorim;
    newscript->RegisterSelf();
    
    newscript = new Script;
    newscript->Name = "npc_ys_mimiron";
    newscript->GetAI = &GetAI_npc_ys_mimiron;
    newscript->RegisterSelf();
    
    newscript = new Script;
    newscript->Name = "npc_ys_hodir";
    newscript->GetAI = &GetAI_npc_ys_hodir;
    newscript->RegisterSelf();
    
    newscript = new Script;
    newscript->Name = "npc_sanity_well";
    newscript->GetAI = &GetAI_npc_sanity_well;
    newscript->RegisterSelf();
}
