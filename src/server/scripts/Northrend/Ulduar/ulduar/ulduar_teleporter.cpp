/*
 * Copyright (C) 2008-2010 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

#include "ScriptPCH.h"
#include "ulduar.h"

enum Locations
{
    BASE_CAMP                                   = 200,
    GROUNDS                                     = 201,
    FORGE                                       = 202,
    SCRAPYARD                                   = 203,
    ANTECHAMBER                                 = 204,
    WALKWAY                                     = 205,
    CONSERVATORY                                = 206,
    SPARK_IMAGINATION                           = 207,
    DESCENT_MADNESS                             = 208
};

bool GoHello_ulduar_teleporter( Player *pPlayer, GameObject *pGO )
{
    InstanceData *data = pPlayer->GetInstanceData();
    ScriptedInstance *pInstance = (ScriptedInstance *) pGO->GetInstanceData();
    if(!pInstance | !data) return true;

    pPlayer->ADD_GOSSIP_ITEM(0, "Expedition Base Camp", GOSSIP_SENDER_MAIN, BASE_CAMP);
//    pPlayer->ADD_GOSSIP_ITEM(0, "Formation Grounds", GOSSIP_SENDER_MAIN, GROUNDS);
    if (data->GetBossState(BOSS_LEVIATHAN) == DONE)
    {
        pPlayer->ADD_GOSSIP_ITEM(0, "Colossal Forge", GOSSIP_SENDER_MAIN, FORGE);
        if (data->GetBossState(BOSS_XT002) == DONE)
        {
            pPlayer->ADD_GOSSIP_ITEM(0, "Scrapyard", GOSSIP_SENDER_MAIN, SCRAPYARD);
            pPlayer->ADD_GOSSIP_ITEM(0, "Antechamber of Ulduar", GOSSIP_SENDER_MAIN, ANTECHAMBER);
            if (data->GetBossState(BOSS_KOLOGARN) == DONE)
            {
                pPlayer->ADD_GOSSIP_ITEM(0, "Shattered Walkway", GOSSIP_SENDER_MAIN, WALKWAY);
                if (data->GetBossState(BOSS_AURIAYA) == DONE)
                {
                    pPlayer->ADD_GOSSIP_ITEM(0, "Conservatory of Life", GOSSIP_SENDER_MAIN, CONSERVATORY);
//                    pPlayer->ADD_GOSSIP_ITEM(0, "Spark of Imagination", GOSSIP_SENDER_MAIN, SPARK_IMAGINATION);
                    if (data->GetBossState(BOSS_VEZAX) == DONE)
                        pPlayer->ADD_GOSSIP_ITEM(0, "Descent into Madness", GOSSIP_SENDER_MAIN, DESCENT_MADNESS);
                }
            }
        }
    }
    pPlayer->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, pGO->GetGUID());

    return true;
}

bool GOSelect_ulduar_teleporter( Player *pPlayer, GameObject *pGO, uint32 sender, uint32 action )
{
    if(sender != GOSSIP_SENDER_MAIN) return true;
    if(!pPlayer->getAttackers().empty()) return true;

    switch(action)
    {
    case BASE_CAMP:
        pPlayer->TeleportTo(603, -706.122, -92.6024, 429.876, 0);
        pPlayer->CLOSE_GOSSIP_MENU(); break;
    case GROUNDS:
        pPlayer->TeleportTo(603, 131.248, -35.3802, 409.804, 0);
        pPlayer->CLOSE_GOSSIP_MENU(); break;
    case FORGE:
        pPlayer->TeleportTo(603, 553.233, -12.3247, 409.679, 0);
        pPlayer->CLOSE_GOSSIP_MENU(); break;
    case SCRAPYARD:
        pPlayer->TeleportTo(603, 926.292, -11.4635, 418.595, 0);
        pPlayer->CLOSE_GOSSIP_MENU(); break;
    case ANTECHAMBER:
        pPlayer->TeleportTo(603, 1498.09, -24.246, 420.967, 0);
        pPlayer->CLOSE_GOSSIP_MENU(); break;
    case WALKWAY:
        pPlayer->TeleportTo(603, 1859.45, -24.1, 448.9, 0);
        pPlayer->CLOSE_GOSSIP_MENU(); break;
    case CONSERVATORY:
        pPlayer->TeleportTo(603, 2086.27, -24.3134, 421.239, 0);
        pPlayer->CLOSE_GOSSIP_MENU(); break;
    case SPARK_IMAGINATION:
        pPlayer->TeleportTo(603, 2518.16, 2569.03, 412.299, 0);
        pPlayer->CLOSE_GOSSIP_MENU(); break;
    case DESCENT_MADNESS:
        pPlayer->TeleportTo(603, 1854.82, -11.5608, 334.175, 0);
        pPlayer->CLOSE_GOSSIP_MENU(); break;
    }

    return true;
}

void AddSC_ulduar_teleporter()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "ulduar_teleporter";
    newscript->pGOHello = &GoHello_ulduar_teleporter;
    newscript->pGOSelect = &GOSelect_ulduar_teleporter;
    newscript->RegisterSelf();
}
