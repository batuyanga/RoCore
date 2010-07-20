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
SD%Complete: 10
SDComments:
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

// Keepers
#define GOSSIP_THORIM_IMAGE         "Help me, Thorim!"
#define GOSSIP_FREYA_IMAGE          "Help me, Freya!"
#define GOSSIP_MIMIRON_IMAGE        "Help me, Mimiron!"
#define GOSSIP_HODIR_IMAGE          "Help me, Hodir!"

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
    SPELL_FURY_OF_THE_STORMS                    = 62702,
    SPELL_RESILIENCE_OF_NATURE                  = 62670,
    SPELL_SPEED_OF_INVENTION                    = 62671,
    SPELL_FORTITUDE_OF_FROST                    = 62650,
};

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
        switch (pCreature->GetEntry())
        {
            case 33241:
                if (!pCreature->HasAura(SPELL_KEEPER_ACTIVE))
                {
                    pPlayer->PrepareQuestMenu(pCreature->GetGUID());
                    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,GOSSIP_FREYA_IMAGE,GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF);
                    pPlayer->SEND_GOSSIP_MENU(13910, pCreature->GetGUID());
                }
                break;
            case 33242:
                if (!pCreature->HasAura(SPELL_KEEPER_ACTIVE))
                {
                    pPlayer->PrepareQuestMenu(pCreature->GetGUID());
                    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,GOSSIP_THORIM_IMAGE,GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF);
                    pPlayer->SEND_GOSSIP_MENU(13910, pCreature->GetGUID());
                }
                break;
            case 33244:
                if (!pCreature->HasAura(SPELL_KEEPER_ACTIVE))
                {
                    pPlayer->PrepareQuestMenu(pCreature->GetGUID());
                    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,GOSSIP_MIMIRON_IMAGE,GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF);
                    pPlayer->SEND_GOSSIP_MENU(13910, pCreature->GetGUID());
                }
                break;
            case 33213:
                if (!pCreature->HasAura(SPELL_KEEPER_ACTIVE))
                {
                    pPlayer->PrepareQuestMenu(pCreature->GetGUID());
                    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,GOSSIP_HODIR_IMAGE,GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF);
                    pPlayer->SEND_GOSSIP_MENU(13910, pCreature->GetGUID());
                }
                break;
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
        case 33241:
            DoScriptText(SAY_FREYA_HELP, pCreature);
            pCreature->CastSpell(pCreature, SPELL_KEEPER_ACTIVE, true);
            break;
        case 33242:
            DoScriptText(SAY_THORIM_HELP, pCreature);
            pCreature->CastSpell(pCreature, SPELL_KEEPER_ACTIVE, true);
            break;
        case 33244:
            DoScriptText(SAY_MIMIRON_HELP, pCreature);
            pCreature->CastSpell(pCreature, SPELL_KEEPER_ACTIVE, true);
            break;
        case 33213:
            DoScriptText(SAY_HODIR_HELP, pCreature);
            pCreature->CastSpell(pCreature, SPELL_KEEPER_ACTIVE, true);
            break;
    }
    
    return true;
}

CreatureAI* GetAI_keeper_image(Creature* pCreature)
{
    return new keeper_imageAI (pCreature);
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
}