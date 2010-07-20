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

#include "ScriptPCH.h"
#include "oculus.h"

#define MAX_ENCOUNTER 5

/* The Occulus encounters:
0 - Drakos the Interrogator
1 - Varos Cloudstrider
2 - Mage-Lord Urom
3 - Ley-Guardian Eregos */

struct Locations {
	float x,y,z,o;
};

static Locations BossMoveLoc[]=
{
    {951.233337, 1034.698608, 359.967377, 1.119904}, // Verdisa
	{943.559143, 1045.573730, 359.967377, 0.365921}, // Belgar
    {944.670776, 1058.858032, 359.967377, 5.639870}  // Eternos
};

struct instance_oculus : public ScriptedInstance
{
    instance_oculus(Map* pMap) : ScriptedInstance(pMap) {Initialize();};

    uint64 uiDrakos;
    uint64 uiVaros;
    uint64 uiUrom;
    uint64 uiEregos;
	uint64 uiBera;
	uint64 uiVerdisa;
	uint64 uiEternos;


    uint8 m_auiEncounter[MAX_ENCOUNTER];
    std::string str_data;

	void Initialize()
    {		
        memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));
		uiDrakos = 0;
		uiVaros = 0;
		uiUrom = 0;
		uiEregos = 0;
		uiBera = 0;
		uiVerdisa = 0;
		uiEternos = 0;
    }

	std::list<uint64> GameObjectList;

	void OnGameObjectCreate(GameObject* pGO, bool bAdd)
    {
        if (pGO->GetEntry() == GO_DRAGON_CAGE_DOOR)
        {
            if (DATA_DRAKOS_EVENT == DONE)
                pGO->SetGoState(GO_STATE_ACTIVE);
            else
                pGO->SetGoState(GO_STATE_READY);
        
            GameObjectList.push_back(pGO->GetGUID());
        }
    }


    void OnCreatureCreate(Creature* pCreature, bool add)
    {
        switch(pCreature->GetEntry())
        {
            case CREATURE_DRAKOS:
                uiDrakos = pCreature->GetGUID();
                break;
            case CREATURE_VAROS:
                uiVaros = pCreature->GetGUID();
                break;
            case CREATURE_UROM:
                uiUrom = pCreature->GetGUID();
                break;
            case CREATURE_EREGOS:
                uiEregos = pCreature->GetGUID();
				pCreature->SetUnitMovementFlags(MOVEMENTFLAG_FLY_MODE);
				break;
			case CREATURE_AZURE_GUARDIAN:
				pCreature->SetUnitMovementFlags(MOVEMENTFLAG_FLY_MODE);
                break;
			case NPC_BELGARISTRASZ:
				uiBera = pCreature->GetGUID();
				pCreature->SetReactState(REACT_PASSIVE);
				break;
			case NPC_VERDISA:
				uiVerdisa = pCreature->GetGUID();
				pCreature->SetReactState(REACT_PASSIVE);
				break;
			case NPC_ETERNOS :
				uiEternos = pCreature->GetGUID();
				pCreature->SetReactState(REACT_PASSIVE);
				break;
			break;	
        }
    }

    void SetData(uint32 type, uint32 data)
    {
        switch(type)
        {
            case DATA_DRAKOS_EVENT:
                m_auiEncounter[0] = data;
				if (data == DONE)
				{
                    OpenCageDoors();
					if(uiBera)
						{
							Creature* pBera = instance->GetCreature(uiBera);
							if(pBera)
							{
								pBera->SetUnitMovementFlags(MOVEMENTFLAG_WALK_MODE);
								pBera->GetMotionMaster()->MovePoint(1,BossMoveLoc[1].x,BossMoveLoc[1].y,BossMoveLoc[1].z);
							}
						}
						if(uiVerdisa)
						{
							Creature* pVerdisa = instance->GetCreature(uiVerdisa);
							if(pVerdisa)
							{
								pVerdisa->SetUnitMovementFlags(MOVEMENTFLAG_WALK_MODE);
								pVerdisa->GetMotionMaster()->MovePoint(2,BossMoveLoc[0].x,BossMoveLoc[0].y,BossMoveLoc[0].z);
							}
						}
						if(uiEternos)
						{
							Creature* pEternos = instance->GetCreature(uiEternos);
							if(pEternos)
							{
								pEternos->SetUnitMovementFlags(MOVEMENTFLAG_WALK_MODE);
								pEternos->GetMotionMaster()->MovePoint(3,BossMoveLoc[2].x,BossMoveLoc[2].y,BossMoveLoc[2].z);
							}
						}
				}
                break;
            case DATA_VAROS_EVENT:
                m_auiEncounter[1] = data;
                break;
            case DATA_UROM_EVENT:
                m_auiEncounter[2] = data;
                break;
            case DATA_EREGOS_EVENT:
                m_auiEncounter[3] = data;
				if(data == DONE)
				{
					Creature* pBera =  instance->GetCreature(uiBera);
					if (pBera)
                    {
                        pBera->SummonGameObject(instance->IsHeroic()? GO_CACHE_OF_ERAGOS_H : GO_CACHE_OF_ERAGOS,1017.197632,1051.705078,605.625916,0.054135,0, 0, 0, 0,90000000);
                    }
				}
                break;
			case DATA_CENTRIFUGE_CONSTRUCT_EVENT:
				m_auiEncounter[4] = data;
				break;

        }

        if (data == DONE)
            SaveToDB();
    }

    uint32 GetData(uint32 type)
    {
        switch(type)
        {
            case DATA_DRAKOS_EVENT:                return m_auiEncounter[0];
            case DATA_VAROS_EVENT:                 return m_auiEncounter[1];
            case DATA_UROM_EVENT:                  return m_auiEncounter[2];
            case DATA_EREGOS_EVENT:                return m_auiEncounter[3];
			case DATA_CENTRIFUGE_CONSTRUCT_EVENT:  return m_auiEncounter[4];;
        }

        return 0;
    }

    uint64 GetData64(uint32 identifier)
    {
        switch(identifier)
        {
            case DATA_DRAKOS:                 return uiDrakos;
            case DATA_VAROS:                  return uiVaros;
            case DATA_UROM:                   return uiUrom;
            case DATA_EREGOS:                 return uiEregos;
        }

        return 0;
    }

	void OpenCageDoors()
    {
        if (GameObjectList.empty())
            return;

        for (std::list<uint64>::const_iterator itr = GameObjectList.begin(); itr != GameObjectList.end(); ++itr)
        {
            if (GameObject* pGO = instance->GetGameObject(*itr))
                pGO->SetGoState(GO_STATE_ACTIVE);
        }
    }



    std::string GetSaveData()
    {
        OUT_SAVE_INST_DATA;

        std::ostringstream saveStream;
        saveStream << "T O " << m_auiEncounter[0] << " " << m_auiEncounter[1] << " " << m_auiEncounter[2] << " " << m_auiEncounter[3] << " " << m_auiEncounter[4];

        str_data = saveStream.str();

        OUT_SAVE_INST_DATA_COMPLETE;
        return str_data;
    }

    void Load(const char* in)
    {
        if (!in)
        {
            OUT_LOAD_INST_DATA_FAIL;
            return;
        }

        OUT_LOAD_INST_DATA(in);

        char dataHead1, dataHead2;
        uint16 data0, data1, data2, data3, data4;

        std::istringstream loadStream(in);
        loadStream >> dataHead1 >> dataHead2 >> data0 >> data1 >> data2 >> data3 >> data4;

        if (dataHead1 == 'T' && dataHead2 == 'O')
        {
            m_auiEncounter[0] = data0;
            m_auiEncounter[1] = data1;
            m_auiEncounter[2] = data2;
            m_auiEncounter[3] = data3;
			m_auiEncounter[4] = data4;

            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (m_auiEncounter[i] == IN_PROGRESS)
                    m_auiEncounter[i] = NOT_STARTED;

        } else OUT_LOAD_INST_DATA_FAIL;

        OUT_LOAD_INST_DATA_COMPLETE;
    }
};

InstanceData* GetInstanceData_instance_oculus(Map* pMap)
{
    return new instance_oculus(pMap);
}

void AddSC_instance_oculus()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "instance_oculus";
    newscript->GetInstanceData = &GetInstanceData_instance_oculus;
    newscript->RegisterSelf();

}
