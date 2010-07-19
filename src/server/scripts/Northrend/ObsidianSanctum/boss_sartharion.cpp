/* Copyright (C) 2006 - 2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 * Copyright (C) 2006 - 2010 TrinityCore <http://www.trinitycore.org/>
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
#include "obsidian_sanctum.h"

enum eEnums
{
    //Sartharion Yell
    SAY_SARTHARION_AGGRO                        = -1615018,
    SAY_SARTHARION_BERSERK                      = -1615019,
    SAY_SARTHARION_BREATH                       = -1615020,
    SAY_SARTHARION_CALL_SHADRON                 = -1615021,
    SAY_SARTHARION_CALL_TENEBRON                = -1615022,
    SAY_SARTHARION_CALL_VESPERON                = -1615023,
    SAY_SARTHARION_DEATH                        = -1615024,
    SAY_SARTHARION_SPECIAL_1                    = -1615025,
    SAY_SARTHARION_SPECIAL_2                    = -1615026,
    SAY_SARTHARION_SPECIAL_3                    = -1615027,
    SAY_SARTHARION_SPECIAL_4                    = -1615028,
    SAY_SARTHARION_SLAY_1                       = -1615029,
    SAY_SARTHARION_SLAY_2                       = -1615030,
    SAY_SARTHARION_SLAY_3                       = -1615031,

    WHISPER_LAVA_CHURN                          = -1615032,

    WHISPER_SHADRON_DICIPLE                     = -1615008,
    WHISPER_VESPERON_DICIPLE                    = -1615041,
    WHISPER_HATCH_EGGS                          = -1615017,
    WHISPER_OPEN_PORTAL                         = -1615042, // whisper, shared by two dragons

    //Sartharion Spells
    SPELL_BERSERK                               = 61632,    // Increases the caster's attack speed by 150% and all damage it deals by 500% for 5 min.
    SPELL_CLEAVE                                = 56909,    // Inflicts 35% weapon damage to an enemy and its nearest allies, affecting up to 10 targets.
    SPELL_FLAME_BREATH                          = 56908,    // Inflicts 8750 to 11250 Fire damage to enemies in a cone in front of the caster.
    SPELL_FLAME_BREATH_H                        = 58956,    // Inflicts 10938 to 14062 Fire damage to enemies in a cone in front of the caster.
    SPELL_TAIL_LASH                             = 56910,    // A sweeping tail strike hits all enemies behind the caster, inflicting 3063 to 3937 damage and stunning them for 2 sec.
    SPELL_TAIL_LASH_H                           = 58957,    // A sweeping tail strike hits all enemies behind the caster, inflicting 4375 to 5625 damage and stunning them for 2 sec.
    SPELL_WILL_OF_SARTHARION                    = 61254,    // Sartharion's presence bolsters the resolve of the Twilight Drakes, increasing their total health by 25%. This effect also increases Sartharion's health by 25%.
    SPELL_LAVA_STRIKE                           = 57571,    // (Real spell casted should be 57578) 57571 then trigger visual missile, then summon Lava Blaze on impact(spell 57572)

    SPELL_TWILIGHT_REVENGE                      = 60639,
    NPC_FIRE_CYCLONE                            = 30648,

    SPELL_PYROBUFFET                            = 56916,    // currently used for hard enrage after 15 minutes
    SPELL_PYROBUFFET_RANGE                      = 58907,    // possibly used when player get too far away from dummy creatures (2x Creature entry 30494)

    SPELL_TWILIGHT_SHIFT_ENTER                  = 57620,    // enter phase. Player get this when click GO
    SPELL_TWILIGHT_SHIFT                        = 57874,    // Twilight Shift Aura
    SPELL_TWILIGHT_SHIFT_REMOVAL                = 61187,    // leave phase
    SPELL_TWILIGHT_SHIFT_REMOVAL_ALL            = 61190,    // leave phase (probably version to make all leave)

    //Mini bosses common spells
    SPELL_TWILIGHT_RESIDUE                      = 61885,    // makes immune to shadow damage, applied when leave phase

    //Miniboses (Vesperon, Shadron, Tenebron)
    SPELL_SHADOW_BREATH_H                       = 59126,    // Inflicts 8788 to 10212 Fire damage to enemies in a cone in front of the caster.
    SPELL_SHADOW_BREATH                         = 57570,    // Inflicts 6938 to 8062 Fire damage to enemies in a cone in front of the caster.

    SPELL_SHADOW_FISSURE_H                      = 59127,    // Deals 9488 to 13512 Shadow damage to any enemy within the Shadow fissure after 5 sec.
    SPELL_SHADOW_FISSURE                        = 57579,    // Deals 6188 to 8812 Shadow damage to any enemy within the Shadow fissure after 5 sec.

    //Vesperon
    //In portal is a disciple, when disciple killed remove Power_of_vesperon, portal open multiple times
    NPC_ACOLYTE_OF_VESPERON                     = 31219,    // Acolyte of Vesperon
    SPELL_POWER_OF_VESPERON                     = 61251,    // Vesperon's presence decreases the maximum health of all enemies by 25%.
    SPELL_TWILIGHT_TORMENT_VESP                 = 57948,    // (Shadow only) trigger 57935 then 57988
    SPELL_TWILIGHT_TORMENT_VESP_ACO             = 58853,    // (Fire and Shadow) trigger 58835 then 57988

    //Shadron
    //In portal is a disciple, when disciple killed remove Power_of_vesperon, portal open multiple times
    NPC_ACOLYTE_OF_SHADRON                      = 31218,    // Acolyte of Shadron
    SPELL_POWER_OF_SHADRON                      = 58105,    // Shadron's presence increases Fire damage taken by all enemies by 100%.
    SPELL_GIFT_OF_TWILIGTH_SHA                  = 57835,    // TARGET_SCRIPT shadron
    SPELL_GIFT_OF_TWILIGTH_SAR                  = 58766,    // TARGET_SCRIPT sartharion
    SPELL_VOID_BLAST                            = 57581,    // Twilight Fissure
    SPELL_VOID_BLAST_H                          = 59128,

    //Tenebron
    //in the portal spawns 6 eggs, if not killed in time (approx. 20s)  they will hatch,  whelps can cast 60708
    SPELL_POWER_OF_TENEBRON                     = 61248,    // Tenebron's presence increases Shadow damage taken by all enemies by 100%.
    //Tenebron, dummy spell
    SPELL_SUMMON_TWILIGHT_WHELP                 = 58035,    // doesn't work, will spawn NPC_TWILIGHT_WHELP
    SPELL_SUMMON_SARTHARION_TWILIGHT_WHELP      = 58826,    // doesn't work, will spawn NPC_SHARTHARION_TWILIGHT_WHELP

    SPELL_HATCH_EGGS_H                          = 59189,
    SPELL_HATCH_EGGS                            = 58542,
    SPELL_HATCH_EGGS_EFFECT_H                   = 59190,
    SPELL_HATCH_EGGS_EFFECT                     = 58685,
    NPC_TWILIHT_WHELP                           = 31214,
    NPC_TWILIGHT_EGG                            = 30882,
    NPC_SARTHARION_TWILIGHT_EGG                 = 31204,

    //Whelps
    NPC_TWILIGHT_WHELP                          = 30890,
    NPC_SHARTHARION_TWILIGHT_WHELP              = 31214,
    SPELL_FADE_ARMOR                            = 60708,    // Reduces the armor of an enemy by 1500 for 15s

    //flame tsunami
    SPELL_FLAME_TSUNAMI                         = 57494,    // the visual dummy
    SPELL_FLAME_TSUNAMI_LEAP                    = 60241,    // SPELL_EFFECT_138 some leap effect, causing caster to move in direction
    SPELL_FLAME_TSUNAMI_DMG_AURA                = 57492,    // periodic damage, npc has this aura
    SPELL_FLAME_TSUNAMI_BUFF                    = 60430,

    NPC_FLAME_TSUNAMI                           = 30616,    // for the flame waves
    NPC_LAVA_BLAZE                              = 30643,    // adds spawning from flame strike

    //using these custom points for dragons start and end
    POINT_ID_INIT                               = 100,
    POINT_ID_LAND                               = 200,

    //Achievements
    ACHIEV_TWILIGHT_ASSIST                      = 2049,
    H_ACHIEV_TWILIGHT_ASSIST                    = 2052,
    ACHIEV_TWILIGHT_DUO                         = 2050,
    H_ACHIEV_TWILIGHT_DUO                       = 2053,
    ACHIEV_TWILIGHT_ZONE                        = 2051,
    H_ACHIEV_TWILIGHT_ZONE                      = 2054
};

//each dragons special points. First where fly to before connect to connon, second where land point is.
Position m_aTene[]=
{
    {3212.854, 575.597, 109.856},                           //init
    {3246.425, 565.367, 61.249}                             //end
};

Position m_aShad[]=
{
    {3293.238, 472.223, 106.968},
    {3271.669, 526.907, 61.931}
};

Position m_aVesp[]=
{
    {3193.310, 472.861, 102.697},
    {3227.268, 533.238, 59.995}
};

#define ACTION_TELEPORT_BACK_SAR 70
#define MAX_WAYPOINT 6
//points around raid "isle", counter clockwise. should probably be adjusted to be more alike
Position m_aDragonCommon[MAX_WAYPOINT]=
{
    {3214.012, 468.932, 98.652},
    {3244.950, 468.427, 98.652},
    {3283.520, 496.869, 98.652},
    {3287.316, 555.875, 98.652},
    {3250.479, 585.827, 98.652},
    {3209.969, 566.523, 98.652}
};
static Position FlameSpawn[] =
{
    // Right
    { 3285.215820f, 516.534100f, 59.188776f, 3.14f },
    { 3284.311035f, 559.839611f, 59.197129f, 3.14f },
    // Left
    { 3209.564697f, 486.982727f, 59.156610f, 0.00f },
    { 3210.280029f, 533.491089f, 59.168331f, 0.00f },
    { 3210.609131f, 579.359375f, 59.120803f, 0.00f }
};

static Position AcolyteofShadron =     { 3363.92, 534.703, 97.2683 };
static Position AcolyteofShadron2 =    { 3246.57, 551.263, 58.6164 };
static Position AcolyteofVesperon =    { 3145.68, 520.71, 89.7 };
static Position AcolyteofVesperon2 =   { 3246.57, 551.263, 58.6164 };

Position TwilightEggs[] =
{
    {3219.28, 669.121 , 88.5549},
    {3221.55, 682.852 , 90.5361},
    {3239.77, 685.94 , 90.3168},
    {3250.33, 669.749 , 88.7637},
    {3246.6, 642.365 , 84.8752},
    {3233.68, 653.117 , 85.7051}
};
Position TwilightEggsSarth[] =
{
    {3261.75, 539.14 , 58.6082},
    {3257.41, 512.939 , 58.5432},
    {3231.04, 498.281 , 58.6439},
    {3264.90, 525.865 , 58.6436},
    {3257.54, 502.285 , 58.2077},
    {3264.26, 516.364 , 58.8011}
};

enum Events
{
    EVENT_NONE,
    EVENT_FLAME_BREATH,
    EVENT_TAIL_SWEEP,
    EVENT_CLEAVE,
    EVENT_ENRAGE,

    EVENT_LAVA_STRIKE,    
    EVENT_FLAME_TSUNAMI,

    EVENT_CALL_TENEBRON,
    EVENT_CALL_SHADRON,
    EVENT_CALL_VESPERON
};

/*######
## Boss Sartharion
######*/

struct boss_sartharionAI : public BossAI
{
    boss_sartharionAI(Creature* pCreature) : BossAI(pCreature, TYPE_SARTHARION_EVENT){}

    bool m_bIsBerserk;
    bool m_bIsSoftEnraged;

    uint32 achievProgress;
    uint32 Acolytes;

    void Reset()
    {
        _Reset();
        if (instance)
            instance->SetData(TYPE_SARTHARION_EVENT, NOT_STARTED);
        RespawnDrakes();

        m_bIsBerserk = false;
        m_bIsSoftEnraged = false;

        if (me->HasAura(SPELL_TWILIGHT_REVENGE))
            me->RemoveAurasDueToSpell(SPELL_TWILIGHT_REVENGE);

        me->ResetLootMode();
        me->SetHomePosition(3246.57, 551.263, 58.6164, 4.66003); 

        achievProgress = 0;
        Acolytes = 2;
    }

    void EnterCombat(Unit* pWho)
    {
        _EnterCombat();
        if (instance)
            instance->SetData(TYPE_SARTHARION_EVENT, IN_PROGRESS);
        DoScriptText(SAY_SARTHARION_AGGRO,me);
        FetchDragons();
        
        events.ScheduleEvent(EVENT_FLAME_TSUNAMI, 30000);
        events.ScheduleEvent(EVENT_FLAME_BREATH, 20000);
        events.ScheduleEvent(EVENT_TAIL_SWEEP, 15000);
        events.ScheduleEvent(EVENT_CLEAVE, 7000);
        events.ScheduleEvent(EVENT_LAVA_STRIKE, 5000);
        events.ScheduleEvent(EVENT_ENRAGE, 15*MINUTE*IN_MILLISECONDS);
    }

    void DoAction(const int32 action)
    {
        switch(action)
        {
            case ACTION_TELEPORT_BACK_SAR:
                Acolytes--;
                break;
        }
    }

    void JustDied(Unit* pKiller)
    {
        _JustDied();
        DoScriptText(SAY_SARTHARION_DEATH,me);
        if (instance)
            instance->SetData(TYPE_SARTHARION_EVENT, DONE);

        if (instance)
        {
            Creature* pTenebron = Unit::GetCreature(*me, instance->GetData64(DATA_TENEBRON));
            Creature* pShadron = Unit::GetCreature(*me, instance->GetData64(DATA_SHADRON));
            Creature* pVesperon = Unit::GetCreature(*me, instance->GetData64(DATA_VESPERON));
            if (pTenebron && pTenebron->isAlive())
                pTenebron->DisappearAndDie();
            if (pShadron && pShadron->isAlive())
                pShadron->DisappearAndDie();
            if (pVesperon && pVesperon->isAlive())
                pVesperon->DisappearAndDie();

            if (achievProgress >= 1)
                instance->DoCompleteAchievement(RAID_MODE(ACHIEV_TWILIGHT_ASSIST,H_ACHIEV_TWILIGHT_ASSIST));
            if (achievProgress >= 2)
                instance->DoCompleteAchievement(RAID_MODE(ACHIEV_TWILIGHT_DUO,H_ACHIEV_TWILIGHT_DUO));
            if (achievProgress == 3)
                instance->DoCompleteAchievement(RAID_MODE(ACHIEV_TWILIGHT_ZONE,H_ACHIEV_TWILIGHT_ZONE));
        }
    }

    void KilledUnit(Unit* pVictim)
    {
        DoScriptText(RAND(SAY_SARTHARION_SLAY_1,SAY_SARTHARION_SLAY_2,SAY_SARTHARION_SLAY_3), me);
    }

    // me->ResetLootMode() is called from Reset()
    // AddDrakeLootMode() should only ever be called from FetchDragons(), which is called from Aggro()
    void AddDrakeLootMode()
    {
        if (me->HasLootMode(LOOT_MODE_HARD_MODE_2))      // Has two Drake loot modes
            me->AddLootMode(LOOT_MODE_HARD_MODE_3);      // Add 3rd Drake loot mode
        else if (me->HasLootMode(LOOT_MODE_HARD_MODE_1)) // Has one Drake loot mode
            me->AddLootMode(LOOT_MODE_HARD_MODE_2);      // Add 2nd Drake loot mode
        else                                                     // Has no Drake loot modes
            me->AddLootMode(LOOT_MODE_HARD_MODE_1);      // Add 1st Drake loot mode
    }

    void FetchDragons()
    {
        if (!instance)
            return;
        Creature* pFetchTene = Unit::GetCreature(*me, instance->GetData64(DATA_TENEBRON));
        Creature* pFetchShad = Unit::GetCreature(*me, instance->GetData64(DATA_SHADRON));
        Creature* pFetchVesp = Unit::GetCreature(*me, instance->GetData64(DATA_VESPERON));

        //if at least one of the dragons are alive and are being called
        bool bCanUseWill = false;

        if (pFetchTene && pFetchTene->isAlive() && !pFetchTene->getVictim())
        {
            bCanUseWill = true;
            pFetchTene->AddAura(SPELL_POWER_OF_TENEBRON, pFetchTene);
            pFetchTene->AddAura(SPELL_WILL_OF_SARTHARION, pFetchTene);
            AddDrakeLootMode();
            achievProgress++;            
            events.ScheduleEvent(EVENT_CALL_TENEBRON, 30000);
            pFetchTene->GetMotionMaster()->MovePoint(POINT_ID_INIT, m_aTene[0]);

            if (!pFetchTene->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                pFetchTene->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        }

        if (pFetchShad && pFetchShad->isAlive() && !pFetchShad->getVictim())
        {
            bCanUseWill = true;
            pFetchShad->AddAura(SPELL_POWER_OF_SHADRON, pFetchShad);
            pFetchShad->AddAura(SPELL_WILL_OF_SARTHARION, pFetchShad);
            AddDrakeLootMode();
            achievProgress++;
            events.ScheduleEvent(EVENT_CALL_SHADRON, 75000);
            pFetchShad->GetMotionMaster()->MovePoint(POINT_ID_INIT, m_aShad[0]);

            if (!pFetchShad->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                pFetchShad->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        }

        if (pFetchVesp && pFetchVesp->isAlive() && !pFetchVesp->getVictim())
        {
            bCanUseWill = true;
            pFetchVesp->AddAura(SPELL_POWER_OF_VESPERON, pFetchVesp);
            pFetchVesp->AddAura(SPELL_WILL_OF_SARTHARION, pFetchVesp);
            AddDrakeLootMode();
            achievProgress++;
            events.ScheduleEvent(EVENT_CALL_VESPERON, 120000);
            pFetchVesp->GetMotionMaster()->MovePoint(POINT_ID_INIT, m_aVesp[0]);

            if (!pFetchVesp->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                pFetchVesp->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        }

        if (bCanUseWill)
            DoCast(me, SPELL_WILL_OF_SARTHARION);
    }

    void RespawnDrakes()
    {
        if (!instance)
            return;

        Creature* pTenebron = Unit::GetCreature(*me, instance->GetData64(DATA_TENEBRON));
        Creature* pShadron = Unit::GetCreature(*me, instance->GetData64(DATA_SHADRON));
        Creature* pVesperon = Unit::GetCreature(*me, instance->GetData64(DATA_VESPERON));
        if (pTenebron)
        {
            pTenebron->SetHomePosition(3239.07, 657.235, 86.8775, 4.74729);
            if(pTenebron->isAlive())
            {
                if (pTenebron->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                    pTenebron->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                pTenebron->RemoveAllAuras();
                pTenebron->GetMotionMaster()->MoveTargetedHome();
            }
            else
            {
                if(instance->GetData(TYPE_TENEBRON_PREKILLED) == false)
                {
                    pTenebron->Respawn();
                    pTenebron->GetMotionMaster()->MoveTargetedHome();
                }
            }
        }
        if (pShadron)
        {
            pShadron->SetHomePosition(3363.06, 525.28, 98.362, 4.76475);
            if(pShadron->isAlive())
            {
                if (pShadron->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                    pShadron->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                pShadron->RemoveAllAuras();
                pShadron->GetMotionMaster()->MoveTargetedHome();
            }else
            {
                if(instance->GetData(TYPE_SHADRON_PREKILLED) == false)
                {
                    pShadron->Respawn();
                    pShadron->GetMotionMaster()->MoveTargetedHome();
                }
            }
        }
        if (pVesperon)
        {
            pVesperon->SetHomePosition(3145.68, 520.71, 89.7, 4.64258);
            if(pVesperon->isAlive())
            {
                if (pVesperon->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                    pVesperon->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                pVesperon->RemoveAllAuras();
                pVesperon->GetMotionMaster()->MoveTargetedHome();
            }else
            {
                if(instance->GetData(TYPE_VESPERON_PREKILLED) == false)
                {
                    pVesperon->Respawn();
                    pVesperon->GetMotionMaster()->MoveTargetedHome();
                }
            }
        }
    }

    void CallDragon(uint32 uiDataId)
    {
        if (instance)
        {
            if (Creature *pTemp = Unit::GetCreature(*me,instance->GetData64(uiDataId)))
            {
                if (pTemp->isAlive() && !pTemp->getVictim())
                {
                    if (pTemp->HasUnitMovementFlag(MOVEMENTFLAG_WALK_MODE))
                        pTemp->RemoveUnitMovementFlag(MOVEMENTFLAG_WALK_MODE);

                    if (pTemp->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                        pTemp->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

                    int32 iTextId = 0;

                    switch(pTemp->GetEntry())
                    {
                        case NPC_TENEBRON:
                            iTextId = SAY_SARTHARION_CALL_TENEBRON;
                            pTemp->GetMotionMaster()->MovePoint(POINT_ID_LAND, m_aTene[1]);                            
                            break;
                        case NPC_SHADRON:
                            iTextId = SAY_SARTHARION_CALL_SHADRON;
                            pTemp->GetMotionMaster()->MovePoint(POINT_ID_LAND, m_aShad[1]);                            
                            break;
                        case NPC_VESPERON:
                            iTextId = SAY_SARTHARION_CALL_VESPERON;
                            pTemp->GetMotionMaster()->MovePoint(POINT_ID_LAND, m_aVesp[1]);
                            break;
                    }

                    DoScriptText(iTextId, me);
                }
            }
        }
    }

    void SendFlameTsunami()
    {
        if (Map* pMap = me->GetMap())
            if (pMap->IsDungeon())
            {
                Map::PlayerList const &PlayerList = pMap->GetPlayers();

                if (!PlayerList.isEmpty())
                    for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                        if (i->getSource() && i->getSource()->isAlive())
                            DoScriptText(WHISPER_LAVA_CHURN, me, i->getSource());
            }
    }

    // Selects a random Fire Cyclone and makes it cast Lava Strike.
    // FIXME: Frequency of the casts reduced to compensate 100% chance of spawning a Lava Blaze add
    void CastLavaStrikeOnTarget(Unit* target)
    {
        std::list<Creature*> pFireCyclonesList;
        Trinity::AllCreaturesOfEntryInRange checker(me, NPC_FIRE_CYCLONE, 200.0f);
        Trinity::CreatureListSearcher<Trinity::AllCreaturesOfEntryInRange> searcher(me, pFireCyclonesList, checker);
        me->VisitNearbyObject(200.0f, searcher);

        if(pFireCyclonesList.empty())
            return;

        std::list<Creature*>::iterator itr = pFireCyclonesList.begin();
        uint32 rnd = rand()%pFireCyclonesList.size();

        for(uint32 i = 0; i < rnd; ++i)
            ++itr;
        (*itr)->CastSpell(target, SPELL_LAVA_STRIKE, true);
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (Acolytes == 0)
        {
            if (instance)
            {              
                Map *map = me->GetMap();
                if (map->IsDungeon())
                {
                    Map::PlayerList const &PlayerList = map->GetPlayers();

                    if (PlayerList.isEmpty())
                        return;

                    for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                    {
                        if (i->getSource()->isAlive() && i->getSource()->HasAura(SPELL_TWILIGHT_SHIFT,0) && !i->getSource()->getVictim())
                        {
                            i->getSource()->CastSpell(i->getSource(),SPELL_TWILIGHT_SHIFT_REMOVAL_ALL,true);
                            i->getSource()->CastSpell(i->getSource(),SPELL_TWILIGHT_RESIDUE,true);
                            i->getSource()->RemoveAurasDueToSpell(SPELL_TWILIGHT_SHIFT);
                            i->getSource()->RemoveAurasDueToSpell(SPELL_TWILIGHT_SHIFT_ENTER);
                        }
                    }
                }
            }
        }

        //Return since we have no target
        if (!UpdateVictim())
            return;

        Unit* pTene = Unit::GetUnit(*me, instance ? instance->GetData64(DATA_TENEBRON) : 0);
        Unit* pShad = Unit::GetUnit(*me, instance ? instance->GetData64(DATA_SHADRON) : 0);
        Unit* pVesp = Unit::GetUnit(*me, instance ? instance->GetData64(DATA_VESPERON) : 0);

        //spell will target dragons, if they are still alive at 35%
        if (!m_bIsBerserk && (me->GetHealth()*100 / me->GetMaxHealth()) <= 35
            && ((pTene && pTene->isAlive()) || (pShad && pShad->isAlive()) || (pVesp && pVesp->isAlive())))
        {
            DoScriptText(SAY_SARTHARION_BERSERK, me);
            DoCast(me, SPELL_BERSERK);
            m_bIsBerserk = true;
        }

        //soft enrage
        if (!m_bIsSoftEnraged && (me->GetHealth()*100 / me->GetMaxHealth()) <= 10)
        {
            // m_bIsSoftEnraged is used while determining Lava Strike cooldown.
            m_bIsSoftEnraged = true;
        }

        events.Update(uiDiff);

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch(eventId)
            {
                case EVENT_ENRAGE:
                    DoCast(me, SPELL_PYROBUFFET, true);
                    break;
                case EVENT_FLAME_TSUNAMI:
                    SendFlameTsunami();
                    if(urand(0,1))
                        for (int8 i = 0; i < 2; i++)
                            me->SummonCreature(NPC_FLAME_TSUNAMI, FlameSpawn[i], TEMPSUMMON_TIMED_DESPAWN, 14000);
                    else
                        for (int8 i = 2; i < 5; i++)
                            me->SummonCreature(NPC_FLAME_TSUNAMI, FlameSpawn[i], TEMPSUMMON_TIMED_DESPAWN, 14000);
                    events.ScheduleEvent(EVENT_FLAME_TSUNAMI, 30000);
                    break;
                case EVENT_FLAME_BREATH:
                    DoScriptText(SAY_SARTHARION_BREATH, me);
                    DoCast(me->getVictim(), RAID_MODE(SPELL_FLAME_BREATH, SPELL_FLAME_BREATH_H));
                    events.ScheduleEvent(EVENT_FLAME_BREATH, urand(25000,35000));
                    break;
                case EVENT_TAIL_SWEEP:
                    DoCast(me->getVictim(), RAID_MODE(SPELL_TAIL_LASH, SPELL_TAIL_LASH_H));
                    events.ScheduleEvent(EVENT_TAIL_SWEEP, urand(15000,20000));
                    break;
                case EVENT_CLEAVE:
                    DoCast(me->getVictim(), SPELL_CLEAVE);
                    events.ScheduleEvent(EVENT_CLEAVE, urand(7000,10000));
                    break;
                case EVENT_LAVA_STRIKE:
                    if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0))
                    {
                        CastLavaStrikeOnTarget(pTarget);
                        if(urand(0,5) == 0)
                            DoScriptText(RAND(SAY_SARTHARION_SPECIAL_1,SAY_SARTHARION_SPECIAL_2,SAY_SARTHARION_SPECIAL_3), me);
                    }
                    events.ScheduleEvent(EVENT_LAVA_STRIKE, (m_bIsSoftEnraged ? urand(1400, 2000) : urand(5000,20000)));
                    break;
                case EVENT_CALL_TENEBRON:
                    CallDragon(DATA_TENEBRON);
                    break;
                case EVENT_CALL_SHADRON:
                    CallDragon(DATA_SHADRON);
                    break;
                case EVENT_CALL_VESPERON:
                    CallDragon(DATA_VESPERON);
                    break;
            }
        }

        // Don't attack current target if he's not visible for us.
        if(me->getVictim()->HasAura(57874, 0))
            me->getThreatManager().modifyThreatPercent(me->getVictim(), -100);

        DoMeleeAttackIfReady();

        EnterEvadeIfOutOfCombatArea(uiDiff);
    }
};

CreatureAI* GetAI_boss_sartharion(Creature* pCreature)
{
    return new boss_sartharionAI(pCreature);
}

enum TeneText
{
    SAY_TENEBRON_AGGRO                      = -1615009,
    SAY_TENEBRON_SLAY_1                     = -1615010,
    SAY_TENEBRON_SLAY_2                     = -1615011,
    SAY_TENEBRON_DEATH                      = -1615012,
    SAY_TENEBRON_BREATH                     = -1615013,
    SAY_TENEBRON_RESPOND                    = -1615014,
    SAY_TENEBRON_SPECIAL_1                  = -1615015,
    SAY_TENEBRON_SPECIAL_2                  = -1615016
};

enum ShadText
{
    SAY_SHADRON_AGGRO                       = -1615000,
    SAY_SHADRON_SLAY_1                      = -1615001,
    SAY_SHADRON_SLAY_2                      = -1615002,
    SAY_SHADRON_DEATH                       = -1615003,
    SAY_SHADRON_BREATH                      = -1615004,
    SAY_SHADRON_RESPOND                     = -1615005,
    SAY_SHADRON_SPECIAL_1                   = -1615006,
    SAY_SHADRON_SPECIAL_2                   = -1615007
};

enum VespText
{
    SAY_VESPERON_AGGRO                      = -1615033,
    SAY_VESPERON_SLAY_1                     = -1615034,
    SAY_VESPERON_SLAY_2                     = -1615035,
    SAY_VESPERON_DEATH                      = -1615036,
    SAY_VESPERON_BREATH                     = -1615037,
    SAY_VESPERON_RESPOND                    = -1615038,
    SAY_VESPERON_SPECIAL_1                  = -1615039,
    SAY_VESPERON_SPECIAL_2                  = -1615040
};
#define ACTION_TELEPORT_BACK                20
#define SHIELD_ON_SHADRON                   30
#define SHIELD_ON_SARTHARION                40
#define VESPERON_PORTAL_EVENT               50
#define ACOLYTE_DEBUFF                      60

struct npc_disciple_of_vesperonAI : public TriggerAI
{
    npc_disciple_of_vesperonAI(Creature *pCreature) : TriggerAI(pCreature)
    {        
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        me->SetVisibility(VISIBILITY_OFF);
    }
    void DoAction(const int32 action)
    {
        switch(action)
        {
            case VESPERON_PORTAL_EVENT:
                DoCast(SPELL_TWILIGHT_TORMENT_VESP);
                    break;
            case ACOLYTE_DEBUFF:
                DoCast(SPELL_TWILIGHT_TORMENT_VESP_ACO);
                    break;
        }
    }
};
CreatureAI* GetAI_npc_disciple_of_vesperon(Creature* pCreature)
{
    return new npc_disciple_of_vesperonAI(pCreature);
}

//to control each dragons common abilities
struct dummy_dragonAI : public ScriptedAI
{
    dummy_dragonAI(Creature* pCreature) : ScriptedAI(pCreature)
    {       
        pInstance = pCreature->GetInstanceData();
    }

    ScriptedInstance* pInstance;

    uint32 m_uiWaypointId;
    uint32 m_uiMoveNextTimer;
    int32 m_iPortalRespawnTime;
    bool m_bCanMoveFree;

    void Reset()
    {
        if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);        

        m_uiWaypointId = 0;
        m_uiMoveNextTimer = 500;
        m_iPortalRespawnTime = 30000;
        m_bCanMoveFree = false;        
    }

    void MovementInform(uint32 uiType, uint32 uiPointId)
    {
        if (!pInstance || uiType != POINT_MOTION_TYPE)
            return;

        sLog.outDebug("dummy_dragonAI: %s reached point %u", me->GetName(), uiPointId);

        //if healers messed up the raid and we was already initialized
        if (pInstance->GetData(TYPE_SARTHARION_EVENT) != IN_PROGRESS)
        {
            EnterEvadeMode();
            return;
        }

        //this is end, if we reach this, don't do much
        if (uiPointId == POINT_ID_LAND)
        {
            me->GetMotionMaster()->Clear();
            m_bCanMoveFree = false;
            return;
        }

        //increase
        m_uiWaypointId = uiPointId+1;

        //if we have reached a point bigger or equal to count, it mean we must reset to point 0
        if (m_uiWaypointId >= MAX_WAYPOINT)
        {
            if (!m_bCanMoveFree)
                m_bCanMoveFree = true;

            m_uiWaypointId = 0;
        }

        m_uiMoveNextTimer = 500;
    }

    //used when open portal and spawn mobs in phase
    void DoRaidWhisper(int32 iTextId)
    {
        Map* pMap = me->GetMap();

        if (pMap && pMap->IsDungeon())
        {
            Map::PlayerList const &PlayerList = pMap->GetPlayers();

            if (!PlayerList.isEmpty())
            {
                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                    DoScriptText(iTextId, me, i->getSource());
            }
        }
    }

    //"opens" the portal and does the "opening" whisper
    void OpenPortal()
    {
        int32 iTextId = 0;
        GameObject * pPortal = GetClosestGameObjectWithEntry(me,GO_TWILIGHT_PORTAL,50.0f);
         if (pPortal && !pPortal->isSpawned())
            pPortal->SetRespawnTime(m_iPortalRespawnTime);

        switch(me->GetEntry())
        {
            case NPC_TENEBRON:
            {
                iTextId = WHISPER_HATCH_EGGS;
                if (pInstance && pInstance->GetData(TYPE_SARTHARION_EVENT) == IN_PROGRESS)
                {
                    for(uint32 i = 0; i < 6; ++i)
                        me->SummonCreature(NPC_SARTHARION_TWILIGHT_EGG, TwilightEggsSarth[i], TEMPSUMMON_CORPSE_TIMED_DESPAWN,5000);
                }
                else
                {
                    for(uint32 i = 0; i < 6; ++i)
                        me->SummonCreature(NPC_TWILIGHT_EGG, TwilightEggs[i], TEMPSUMMON_CORPSE_TIMED_DESPAWN,5000);
                }
                break;
            }
            case NPC_SHADRON:
            {
                iTextId = WHISPER_OPEN_PORTAL;
                if (pInstance && !pInstance->GetData(TYPE_SARTHARION_EVENT) == IN_PROGRESS)
                    me->SummonCreature(NPC_ACOLYTE_OF_SHADRON, AcolyteofShadron, TEMPSUMMON_CORPSE_TIMED_DESPAWN,5000);
                else
                    me->SummonCreature(NPC_ACOLYTE_OF_SHADRON, AcolyteofShadron2, TEMPSUMMON_CORPSE_TIMED_DESPAWN,5000);

                break;
            }
            case NPC_VESPERON:
            {
                if (pInstance && !pInstance->GetData(TYPE_SARTHARION_EVENT) == IN_PROGRESS)
                    me->SummonCreature(NPC_ACOLYTE_OF_VESPERON, AcolyteofVesperon, TEMPSUMMON_CORPSE_TIMED_DESPAWN,20000);
                else
                    me->SummonCreature(NPC_ACOLYTE_OF_VESPERON, AcolyteofVesperon2, TEMPSUMMON_CORPSE_TIMED_DESPAWN,20000);

                me->SummonCreature(NPC_DISCIPLE_OF_VESPERON, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 7000);
                if (Creature* pDisciple = pInstance->instance->GetCreature(pInstance->GetData64(DATA_DISCIPLE_OF_VESPERON)))
                    pDisciple->AI()->DoAction(VESPERON_PORTAL_EVENT);

                iTextId = WHISPER_OPEN_PORTAL;
                break;
            }
        }

        DoRaidWhisper(iTextId);
    }

    void JustDied(Unit* pKiller)
    {
        int32 iTextId = 0;
        uint32 uiSpellId = 0;

        switch(me->GetEntry())
        {
            case NPC_TENEBRON:
                iTextId = SAY_TENEBRON_DEATH;
                if(pInstance && pInstance->GetData(TYPE_SARTHARION_EVENT) != IN_PROGRESS)
                    pInstance->SetData(TYPE_TENEBRON_PREKILLED, 1);
                break;
            case NPC_SHADRON:
                iTextId = SAY_SHADRON_DEATH;
                if(pInstance && pInstance->GetData(TYPE_SARTHARION_EVENT) != IN_PROGRESS)
                    pInstance->SetData(TYPE_SHADRON_PREKILLED, 1);
                break;
            case NPC_VESPERON:
                iTextId = SAY_VESPERON_DEATH;
                if(pInstance && pInstance->GetData(TYPE_SARTHARION_EVENT) != IN_PROGRESS)
                    pInstance->SetData(TYPE_VESPERON_PREKILLED, 1);
                break;
        }

        DoScriptText(iTextId, me);

        if (pInstance)
        {
            // not if solo mini-boss fight
            if (pInstance->GetData(TYPE_SARTHARION_EVENT) != IN_PROGRESS)
                return;

            // Twilight Revenge to main boss
            if (Unit* pSartharion = Unit::GetUnit((*me), pInstance->GetData64(DATA_SARTHARION)))
                if (pSartharion->isAlive())
                    pSartharion->CastSpell(pSartharion, SPELL_TWILIGHT_REVENGE, true);
            me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
        }
    }    

    void UpdateAI(const uint32 uiDiff)
    {
        if (m_bCanMoveFree && m_uiMoveNextTimer)
        {
            if (m_uiMoveNextTimer <= uiDiff)
            {
                if (m_uiWaypointId < MAX_WAYPOINT)
                    me->GetMotionMaster()->MovePoint(m_uiWaypointId, m_aDragonCommon[m_uiWaypointId]);

                sLog.outDebug("dummy_dragonAI: %s moving to point %u", me->GetName(), m_uiWaypointId);
                m_uiMoveNextTimer = 0;
            }
            else
                m_uiMoveNextTimer -= uiDiff;
        }
    }
};

/*######
## Mob Tenebron
######*/

struct mob_tenebronAI : public dummy_dragonAI
{
    mob_tenebronAI(Creature* pCreature) : dummy_dragonAI(pCreature)
    {        
        pInstance = pCreature->GetInstanceData();
    }

    uint32 m_uiShadowBreathTimer;
    uint32 m_uiShadowFissureTimer;
    uint32 m_uiHatchEggTimer;
    bool m_bHasPortalOpen;
    uint32 Eggs;

    void Reset()
    {         
        m_uiShadowBreathTimer = 20000;
        m_uiShadowFissureTimer = 5000;
        m_uiHatchEggTimer = 30000;
        m_bHasPortalOpen = false;
    }

    void EnterCombat(Unit* pWho)
    {
        DoScriptText(SAY_TENEBRON_AGGRO, me);
        DoZoneInCombat();
        DoCast(me, SPELL_POWER_OF_TENEBRON);
    }

    void DoAction(const int32 action)
    {
        switch(action)
        {
            case ACTION_TELEPORT_BACK:
                Eggs--;
                break;
        }
    }

    void JustSummoned(Creature *summon)
    {
        Eggs = 6;
    }

    void KilledUnit(Unit* pVictim)
    {
        DoScriptText(RAND(SAY_TENEBRON_SLAY_1,SAY_TENEBRON_SLAY_2), me);        
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (Eggs == 0)
        {
            if (pInstance)
            {
                Map *map = me->GetMap();
                if (map->IsDungeon())
                {
                    Map::PlayerList const &PlayerList = map->GetPlayers();

                    if (PlayerList.isEmpty())
                        return;

                    for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                    {
                        if (i->getSource()->isAlive() && i->getSource()->HasAura(SPELL_TWILIGHT_SHIFT,0) && !i->getSource()->getVictim())
                        {
                            i->getSource()->CastSpell(i->getSource(),SPELL_TWILIGHT_SHIFT_REMOVAL_ALL,true);
                            i->getSource()->CastSpell(i->getSource(),SPELL_TWILIGHT_RESIDUE,true);
                            i->getSource()->RemoveAurasDueToSpell(SPELL_TWILIGHT_SHIFT);
                            i->getSource()->RemoveAurasDueToSpell(SPELL_TWILIGHT_SHIFT_ENTER);
                        }
                    }
                }
            }
        }
        //if no target, update dummy and return
        if (!UpdateVictim())
        {
            dummy_dragonAI::UpdateAI(uiDiff);
            return;
        }

        // shadow fissure
        if (m_uiShadowFissureTimer <= uiDiff)
        {
            if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0))
                DoCast(pTarget, RAID_MODE(SPELL_SHADOW_FISSURE, SPELL_SHADOW_FISSURE));

            m_uiShadowFissureTimer = urand(15000,20000);
        }
        else
            m_uiShadowFissureTimer -= uiDiff;

        // Hach Egg
        if (m_uiHatchEggTimer <= uiDiff)
        {
            if(m_bHasPortalOpen)
                m_uiHatchEggTimer = 10000;
            else
            {
                OpenPortal();
                m_uiHatchEggTimer = urand(40000,50000);
            }
        }
        else
             m_uiHatchEggTimer -= uiDiff;

        // shadow breath
        if (m_uiShadowBreathTimer <= uiDiff)
        {
            DoScriptText(SAY_TENEBRON_BREATH, me);
            DoCast(me->getVictim(), RAID_MODE(SPELL_SHADOW_BREATH, SPELL_SHADOW_BREATH_H));
            m_uiShadowBreathTimer = urand(20000,25000);
        }
        else
            m_uiShadowBreathTimer -= uiDiff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_tenebron(Creature* pCreature)
{
    return new mob_tenebronAI(pCreature);
}

/*######
## Mob Shadron
######*/

struct mob_shadronAI : public dummy_dragonAI
{
    mob_shadronAI(Creature* pCreature) : dummy_dragonAI(pCreature), lSummons(me) {}

    uint32 m_uiShadowBreathTimer;
    uint32 m_uiShadowFissureTimer;
    uint32 m_uiAcolyteShadronTimer;
    bool m_bHasPortalOpen;
    SummonList lSummons;

    void Reset()
    {
        m_uiShadowBreathTimer = 20000;
        m_uiShadowFissureTimer = 5000;
        m_uiAcolyteShadronTimer = 60000;
        m_bHasPortalOpen = false;
        lSummons.DespawnAll();

        if (me->HasAura(SPELL_TWILIGHT_TORMENT_VESP))
            me->RemoveAurasDueToSpell(SPELL_TWILIGHT_TORMENT_VESP);

        if (me->HasAura(SPELL_GIFT_OF_TWILIGTH_SHA))
            me->RemoveAurasDueToSpell(SPELL_GIFT_OF_TWILIGTH_SHA);
    }

    void EnterCombat(Unit* pWho)
    {
        DoScriptText(SAY_SHADRON_AGGRO,me);
        DoZoneInCombat();
        DoCast(me, SPELL_POWER_OF_SHADRON);
    }

    void JustSummoned(Creature *summon)
    {
        lSummons.Summon(summon);
    }

    void DoAction(const int32 action)
    {
        switch(action)
        {           
            if (pInstance)
            {
                case SHIELD_ON_SHADRON:
                    if (Creature* pShadron = Unit::GetCreature(*me, pInstance->GetData64(DATA_SHADRON))) 
                        pShadron->AddAura(SPELL_GIFT_OF_TWILIGTH_SHA, me);                    
                    break;
                case SHIELD_ON_SARTHARION:
                    if (Creature* pSartharion = Unit::GetCreature(*me, pInstance->GetData64(DATA_SARTHARION)))                        
                        pSartharion->AddAura(SPELL_GIFT_OF_TWILIGTH_SAR, pSartharion);
                    break;
            }
        }
    }

    void KilledUnit(Unit* pVictim)
    {
        DoScriptText(RAND(SAY_SHADRON_SLAY_1,SAY_SHADRON_SLAY_2), me);        
    }

    void UpdateAI(const uint32 uiDiff)
    {
        //if no target, update dummy and return
        if (!UpdateVictim())
        {
            dummy_dragonAI::UpdateAI(uiDiff);
            return;
        }

        // shadow fissure
        if (m_uiShadowFissureTimer <= uiDiff)
        {
            if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0))
                DoCast(pTarget, RAID_MODE(SPELL_SHADOW_FISSURE, SPELL_SHADOW_FISSURE_H));

            m_uiShadowFissureTimer = urand(15000,20000);
        }
        else
            m_uiShadowFissureTimer -= uiDiff;

        // Portal Event
        if (m_uiAcolyteShadronTimer <= uiDiff)
        {
            if(m_bHasPortalOpen)
                m_uiAcolyteShadronTimer = 10000;
            else
            {
                if (me->HasAura(SPELL_GIFT_OF_TWILIGTH_SHA))
                    return;
                OpenPortal();
                m_bHasPortalOpen = true;
                m_uiAcolyteShadronTimer = urand(60000,65000);
            }
        }
        else
            m_uiAcolyteShadronTimer -= uiDiff;

        // shadow breath
        if (m_uiShadowBreathTimer <= uiDiff)
        {
            DoScriptText(SAY_SHADRON_BREATH, me);
            DoCast(me->getVictim(), RAID_MODE(SPELL_SHADOW_BREATH, SPELL_SHADOW_BREATH_H));
            m_uiShadowBreathTimer = urand(20000,25000);
        }
        else
            m_uiShadowBreathTimer -= uiDiff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_shadron(Creature* pCreature)
{
    return new mob_shadronAI(pCreature);
}

/*######
## Mob Vesperon
######*/

struct mob_vesperonAI : public dummy_dragonAI
{
    mob_vesperonAI(Creature* pCreature) : dummy_dragonAI(pCreature), lSummons(me) {}

    uint32 m_uiShadowBreathTimer;
    uint32 m_uiShadowFissureTimer;
    uint32 m_uiAcolyteVesperonTimer;
    bool m_bHasPortalOpen;
    SummonList lSummons;

    void Reset()
    {
        lSummons.DespawnAll();
        m_uiShadowBreathTimer = 20000;
        m_uiShadowFissureTimer = 5000;
        m_uiAcolyteVesperonTimer = 60000;
        m_bHasPortalOpen = false;        
    }

    void EnterCombat(Unit* pWho)
    {
        DoScriptText(SAY_VESPERON_AGGRO,me);
        DoZoneInCombat();
        DoCast(me, SPELL_POWER_OF_VESPERON);
    }

    void KilledUnit(Unit* pVictim)
    {
        DoScriptText(RAND(SAY_VESPERON_SLAY_1,SAY_VESPERON_SLAY_2), me);
    }

    void JustSummoned(Creature *summon)
    {        
        lSummons.Summon(summon);
    }

    void UpdateAI(const uint32 uiDiff)
    {
        //if no target, update dummy and return
        if (!UpdateVictim())
        {
            dummy_dragonAI::UpdateAI(uiDiff);
            return;
        }

        // shadow fissure
        if (m_uiShadowFissureTimer <= uiDiff)
        {
            if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0))
                DoCast(pTarget, RAID_MODE(SPELL_SHADOW_FISSURE, SPELL_SHADOW_FISSURE_H));

            m_uiShadowFissureTimer = urand(15000,20000);
        }
        else
            m_uiShadowFissureTimer -= uiDiff;

        // Portal Event
        if (m_uiAcolyteVesperonTimer <= uiDiff)
        {
            if(m_bHasPortalOpen)
                m_uiAcolyteVesperonTimer = 10000;
            else
            {
                OpenPortal();
                m_bHasPortalOpen = true;
                m_uiAcolyteVesperonTimer = urand(60000,70000);
            }
        }
        else
            m_uiAcolyteVesperonTimer -= uiDiff;

        // shadow breath
        if (m_uiShadowBreathTimer <= uiDiff)
        {
            DoScriptText(SAY_VESPERON_BREATH, me);
            DoCast(me->getVictim(), RAID_MODE(SPELL_SHADOW_BREATH, SPELL_SHADOW_BREATH_H));
            m_uiShadowBreathTimer = urand(20000,25000);
        }
        else
            m_uiShadowBreathTimer -= uiDiff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_vesperon(Creature* pCreature)
{
    return new mob_vesperonAI(pCreature);
}

/*######
## Mob Acolyte of Shadron
######*/

struct mob_acolyte_of_shadronAI : public ScriptedAI
{
    mob_acolyte_of_shadronAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        pInstance = pCreature->GetInstanceData();
    }

    ScriptedInstance* pInstance;
    uint32 uiShiftEffectTimer;
    uint32 uiShieldTimer;
    bool shield;

    void Reset()
    {
        uiShieldTimer = 1000;
        uiShiftEffectTimer = 1000;
        shield = false;
        me->AddAura(SPELL_TWILIGHT_SHIFT_ENTER,me);
        me->SetPhaseMask(2, true);
    }

    void JustDied(Unit* killer)
    {
        if (pInstance->GetData(TYPE_SARTHARION_EVENT) == IN_PROGRESS)
        {
            if (Creature* pSartharion = me->GetCreature(*me, pInstance->GetData64(DATA_SARTHARION)))
                pSartharion->AI()->DoAction(ACTION_TELEPORT_BACK_SAR);
        }
        else
        {
            if (pInstance)
            {
                Creature* Shadron = pInstance->instance->GetCreature(pInstance->GetData64(DATA_SHADRON));
                if(Shadron)
                    ((mob_shadronAI*)Shadron->AI())->m_bHasPortalOpen = false;                
                
                Map *map = me->GetMap();
                if (map->IsDungeon())
                {
                    Map::PlayerList const &PlayerList = map->GetPlayers();

                    if (PlayerList.isEmpty())
                        return;

                    for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                    {
                        if (i->getSource()->isAlive() && i->getSource()->HasAura(SPELL_TWILIGHT_SHIFT,0) && !i->getSource()->getVictim())
                        {
                            i->getSource()->CastSpell(i->getSource(),SPELL_TWILIGHT_SHIFT_REMOVAL_ALL,true);
                            i->getSource()->CastSpell(i->getSource(),SPELL_TWILIGHT_RESIDUE,true);
                            i->getSource()->RemoveAurasDueToSpell(SPELL_TWILIGHT_SHIFT);
                            i->getSource()->RemoveAurasDueToSpell(SPELL_TWILIGHT_SHIFT_ENTER);
                        }
                    }
                }
            }

            Creature* pDebuffTarget = NULL;
            if (pInstance->GetData(TYPE_SARTHARION_EVENT) == IN_PROGRESS)
            {
                //not solo fight, so main boss has deduff
                pDebuffTarget = pInstance->instance->GetCreature(pInstance->GetData64(DATA_SARTHARION));
                if (pDebuffTarget && pDebuffTarget->isAlive() && pDebuffTarget->HasAura(SPELL_GIFT_OF_TWILIGTH_SAR))
                    pDebuffTarget->RemoveAurasDueToSpell(SPELL_GIFT_OF_TWILIGTH_SAR);
            }
            else
            {
                //event not in progress, then solo fight and must remove debuff mini-boss
                pDebuffTarget = pInstance->instance->GetCreature(pInstance->GetData64(DATA_SHADRON));
                if (pDebuffTarget && pDebuffTarget->isAlive() && pDebuffTarget->HasAura(SPELL_GIFT_OF_TWILIGTH_SHA))
                    pDebuffTarget->RemoveAurasDueToSpell(SPELL_GIFT_OF_TWILIGTH_SHA);
            }
        }
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!shield && uiShieldTimer <= uiDiff)
        {
            Creature* pShadron = Unit::GetCreature(*me, pInstance->GetData64(DATA_SHADRON));
            if (pInstance->GetData(TYPE_SARTHARION_EVENT) == IN_PROGRESS)
                pShadron->AI()->DoAction(SHIELD_ON_SARTHARION);
            else            
                pShadron->AI()->DoAction(SHIELD_ON_SHADRON);
                
            uiShieldTimer = 5000;
            shield = true;
        } else uiShieldTimer -= uiDiff;

        if (!UpdateVictim())
            return;
        
        // Don't attack current target if he's not visible for us.
        if(!me->getVictim()->HasAura(57874, 0))
            me->getThreatManager().modifyThreatPercent(me->getVictim(), -100);

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_acolyte_of_shadron(Creature* pCreature)
{
    return new mob_acolyte_of_shadronAI(pCreature);
}

/*######
## Mob Acolyte of Vesperon
######*/

struct mob_acolyte_of_vesperonAI : public ScriptedAI
{
    mob_acolyte_of_vesperonAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        pInstance = pCreature->GetInstanceData();
    }

    ScriptedInstance* pInstance;

    void Reset()
    {
        if (pInstance)
        {
            me->AddAura(SPELL_TWILIGHT_SHIFT_ENTER,me);
        }
        me->SetPhaseMask(2, true);
    }
    
    void EnterCombat(Unit* who)
    {
        if(pInstance)
        {
            me->SummonCreature(NPC_DISCIPLE_OF_VESPERON, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 7000);
            if (Creature* pDisciple = pInstance->instance->GetCreature(pInstance->GetData64(DATA_DISCIPLE_OF_VESPERON)))
                pDisciple->AI()->DoAction(VESPERON_PORTAL_EVENT);
        }
    }

    void JustDied(Unit* pKiller)
    {
        // remove twilight torment on Vesperon
        if (pInstance)
        {
            Creature* pVesperon = pInstance->instance->GetCreature(pInstance->GetData64(DATA_VESPERON));
            if (pVesperon)
                ((mob_vesperonAI*)pVesperon->AI())->m_bHasPortalOpen = false;

            if (pVesperon && pVesperon->isAlive() && pVesperon->HasAura(SPELL_TWILIGHT_TORMENT_VESP))
                pVesperon->RemoveAurasDueToSpell(SPELL_TWILIGHT_TORMENT_VESP);

            if (pInstance->GetData(TYPE_SARTHARION_EVENT) == IN_PROGRESS)
            {
                if (Creature* pSartharion = me->GetCreature(*me, pInstance->GetData64(DATA_SARTHARION)))
                    pSartharion->AI()->DoAction(ACTION_TELEPORT_BACK_SAR);
            }
            else
            {
                Creature* Shadron = pInstance->instance->GetCreature(pInstance->GetData64(DATA_SHADRON));
                if(Shadron)
                    ((mob_shadronAI*)Shadron->AI())->m_bHasPortalOpen = false;                
                
                Map *map = me->GetMap();
                if (map->IsDungeon())
                {
                    Map::PlayerList const &PlayerList = map->GetPlayers();

                    if (PlayerList.isEmpty())
                        return;

                    for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                    {
                        if (i->getSource()->isAlive() && i->getSource()->HasAura(SPELL_TWILIGHT_SHIFT,0) && !i->getSource()->getVictim())
                        {
                            i->getSource()->CastSpell(i->getSource(),SPELL_TWILIGHT_SHIFT_REMOVAL_ALL,true);
                            i->getSource()->CastSpell(i->getSource(),SPELL_TWILIGHT_RESIDUE,true);
                            i->getSource()->RemoveAurasDueToSpell(SPELL_TWILIGHT_SHIFT);
                            i->getSource()->RemoveAurasDueToSpell(SPELL_TWILIGHT_SHIFT_ENTER);
                        }
                    }
                }
            }
        }
    }

    void UpdateAI(const uint32 uiDiff)
    {        
        if (!UpdateVictim())
            return;

        if(!me->getVictim()->HasAura(57874, 0))
            me->getThreatManager().modifyThreatPercent(me->getVictim(), -100);

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_acolyte_of_vesperon(Creature* pCreature)
{
    return new mob_acolyte_of_vesperonAI(pCreature);
}

/*######
## Mob Twilight Eggs
######*/

struct mob_twilight_eggsAI : public Scripted_NoMovementAI
{
    mob_twilight_eggsAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature)
    {
        pInstance = pCreature->GetInstanceData();
    }
    uint32 m_uiFadeArmorTimer;
    uint32 m_uiHatchEggTimer;    

    ScriptedInstance* pInstance;

    void Reset()
    {
        if(pInstance)
        {
            me->AddAura(SPELL_TWILIGHT_SHIFT_ENTER,me);
        }
        m_uiHatchEggTimer = 20000;
        m_uiFadeArmorTimer = 1000;
    }
    void JustDied (Unit *victim)
    {
        if (Creature* pTenebron = me->GetCreature(*me, pInstance->GetData64(DATA_TENEBRON)))
        pTenebron->AI()->DoAction(ACTION_TELEPORT_BACK);
    }
    void SpawnWhelps()
    {
        if (!pInstance->GetData(TYPE_SARTHARION_EVENT) == IN_PROGRESS)
            me->SummonCreature(NPC_TWILIGHT_WHELP, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 60000);
        else
            me->SummonCreature(NPC_SHARTHARION_TWILIGHT_WHELP, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 60000);        
    }
    void UpdateAI(const uint32 uiDiff)
    {
        if (m_uiHatchEggTimer <= uiDiff)
        {
            Creature* Tenebron = pInstance->instance->GetCreature(pInstance->GetData64(DATA_TENEBRON));
            if(Tenebron)
                ((mob_tenebronAI*)Tenebron->AI())->m_bHasPortalOpen = false;
            SpawnWhelps();
        }
        else
            m_uiHatchEggTimer -= uiDiff;
    }
    void JustSummoned(Creature *summon)
    {
        summon->AI()->DoZoneInCombat();
        summon->DealDamage(me, me->GetHealth());       
    }    
    void AttackStart(Unit* pWho) {}
    void MoveInLineOfSight(Unit* pWho) {}
};

CreatureAI* GetAI_mob_twilight_eggs(Creature* pCreature)
{
    return new mob_twilight_eggsAI(pCreature);
}

/*######
## Flame Tzunami
######*/
struct npc_flame_tsunamiAI : public ScriptedAI
{
    npc_flame_tsunamiAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        me->AddAura(SPELL_FLAME_TSUNAMI, me);        
        me->SetFlying(true);
    }

    uint32 uiStartMove;
    bool bMoved;

    void Reset()
    {
        uiStartMove = 3 * IN_MILLISECONDS;
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
        me->SetReactState(REACT_PASSIVE);
        bMoved = false;
    }

    void UpdateAI(const uint32 diff)
    {
        if (!bMoved)
        {
            if (uiStartMove <= diff)
            {
                Position pos;
                me->GetPosition(&pos);
                DoCast(me, SPELL_FLAME_TSUNAMI_DMG_AURA);
                pos.m_positionX -= pos.GetPositionX() < 3240.0f ? -82.0f : 82.0f;
                me->GetMotionMaster()->MovePoint(0, pos);
                bMoved = true;
            }
            else uiStartMove -= diff;
        }
    }
};
/*######
## Twilight Fissure
######*/
struct npc_twilight_fissureAI : public Scripted_NoMovementAI
{
    npc_twilight_fissureAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature)
    {
        Reset();
    }

    uint32 VoidBlast_Timer;

    void Reset()
    {
        VoidBlast_Timer = 5000;        
    }

    void UpdateAI(const uint32 diff)
    {
        if (VoidBlast_Timer <= diff)
        {
            DoCast(RAID_MODE(SPELL_VOID_BLAST,SPELL_VOID_BLAST_H ));
            VoidBlast_Timer = 9000;
            //me->Kill(me);
            me->DisappearAndDie();
        } else VoidBlast_Timer -= diff;
    }
};


CreatureAI* GetAI_npc_flame_tsunami(Creature* pCreature)
{
    return new npc_flame_tsunamiAI(pCreature);
}

CreatureAI* GetAI_npc_twilight_fissure(Creature* pCreature)
{
    return new npc_twilight_fissureAI(pCreature);
}

/*######
## Mob Twilight Whelps
######*/

struct mob_twilight_whelpAI : public ScriptedAI
{
    mob_twilight_whelpAI(Creature* pCreature) : ScriptedAI(pCreature) 
    {
        Reset();
    }

    uint32 m_uiFadeArmorTimer;

    void Reset()
    {        
        me->RemoveAllAuras();
        m_uiFadeArmorTimer = 1000;
        me->SetPhaseMask(1, true);
    }

    void UpdateAI(const uint32 uiDiff)
    {
        me->SetInCombatWithZone();
        //Return since we have no target
        if (!UpdateVictim())
            return;

        // twilight torment
        if (m_uiFadeArmorTimer <= uiDiff)
        {
            DoCast(me->getVictim(), SPELL_FADE_ARMOR);
            m_uiFadeArmorTimer = urand(5000,10000);
        }
        else
            m_uiFadeArmorTimer -= uiDiff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_twilight_whelp(Creature* pCreature)
{
    return new mob_twilight_whelpAI(pCreature);
}

void AddSC_boss_sartharion()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "boss_sartharion";
    newscript->GetAI = &GetAI_boss_sartharion;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_disciple_of_vesperon";
    newscript->GetAI = &GetAI_npc_disciple_of_vesperon;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_vesperon";
    newscript->GetAI = &GetAI_mob_vesperon;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_shadron";
    newscript->GetAI = &GetAI_mob_shadron;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_tenebron";
    newscript->GetAI = &GetAI_mob_tenebron;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_acolyte_of_shadron";
    newscript->GetAI = &GetAI_mob_acolyte_of_shadron;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_acolyte_of_vesperon";
    newscript->GetAI = &GetAI_mob_acolyte_of_vesperon;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_twilight_eggs";
    newscript->GetAI = &GetAI_mob_twilight_eggs;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_flame_tsunami";
    newscript->GetAI = &GetAI_npc_flame_tsunami;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_twilight_fissure";
    newscript->GetAI = &GetAI_npc_twilight_fissure;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_twilight_whelp";
    newscript->GetAI = &GetAI_mob_twilight_whelp;
    newscript->RegisterSelf();
}
