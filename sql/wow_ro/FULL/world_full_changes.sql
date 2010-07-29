--
-- Table structure for table `db_version`
--

DROP TABLE IF EXISTS `db_version`;
CREATE TABLE `db_version` (
  `required_31_world_db_version` bit(1) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Used DB version notes';

--
-- Dumping data for table `db_version`
--

LOCK TABLES `db_version` WRITE;
/*!40000 ALTER TABLE `db_version` DISABLE KEYS */;
INSERT INTO `db_version` VALUES
(NULL);
/*!40000 ALTER TABLE `db_version` ENABLE KEYS */;
UNLOCK TABLES;

-- Patch acherus
REPLACE INTO `creature_template` VALUES ('438700', '0', '0', '0', '0', '0', '18', '0', '18', '0', 'Acherus_porter', null, null, '0', '80', '80', '0', '35', '35', '0', '1', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '', '0', '3', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '', '0', '0');
UPDATE `creature_template` SET `faction_A`=2082 WHERE `entry`=438700;
UPDATE `creature_template` SET `faction_H`=2082 WHERE `entry`=438700;
UPDATE `creature_template` SET `npcflag`=1 WHERE `entry`=438700;
UPDATE `creature_template` SET `unit_flags`=33554432 WHERE `entry`=438700;
UPDATE `creature_template` SET `flags_extra`=130 WHERE `entry`=438700;
DELETE FROM `creature` WHERE `id`=438700;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
('@GUID+1', 438700, 0, 1, 256, 0, 0, 2390.19, -5641.09, 378.069, 0.760892, 300, 0, 0, 5342, 0, 0, 0),
('@GUID+1', 438700, 609, 1, 1, 0, 0, 2386.42, -5643.42, 420.97, 0.629104, 300, 0, 0, 5342, 0, 0, 0),
('@GUID+1', 438700, 609, 1, 1, 0, 0, 2392.36, -5639.5, 377.518, 0.616926, 300, 0, 0, 5342, 0, 0, 0),
('@GUID+1', 438700, 0, 1, 65535, 0, 0, 2386.39, -5643.9, 421.156, 3.57475, 25, 0, 0, 12, 12, 0, 0);

-- Delete an areatrigger teleport to Frozen Throne located in The Spire. Only if you use CTDB.

DELETE FROM `areatrigger_teleport` WHERE (`id`='5718');

-- Argent Tournament
UPDATE gameobject SET state = 0 WHERE id = 194618;
DELETE FROM `gameobject_loot_template` WHERE entry = 194618;
INSERT INTO `gameobject_loot_template` VALUES(
194618, 46070, 100, 1, 0, 1, 1);
UPDATE quest_template SET QuestFlags = 0 WHERE entry = 13678;
UPDATE quest_template SET NextQuestId = 0 WHERE NextQuestId = 13678;
UPDATE quest_template SET ReqCreatureOrGOId1 = 24108 WHERE entry = 13679;
UPDATE quest_template SET NextQuestId = 0 WHERE NextQuestId = 13672;
UPDATE creature_template SET mindmg = 500, maxdmg = 800 WHERE entry = 33448;
UPDATE creature_template SET ScriptName = 'npc_squire_danny' WHERE entry = 33518;
UPDATE creature_template SET mindmg = 650, maxdmg = 1000, ScriptName = 'npc_argent_champion' WHERE entry = 33707;
UPDATE quest_template SET PrevQuestId = 13680 WHERE PrevQuestId = 13687;
UPDATE quest_template SET PrevQuestId = 13679 WHERE PrevQuestId = 13686;
UPDATE quest_template SET ReqSourceId2 = 0, ReqSourceCount2 = 0 WHERE ReqSourceId2 = 45000;
UPDATE item_template SET maxcount = 1 WHERE entry = 45005;
UPDATE creature_template SET  ScriptName = 'npc_argent_valiant' WHERE entry = 33448;

ALTER TABLE `battleground_template`
ADD COLUMN `honor_mod`  FLOAT NOT NULL DEFAULT 1 AFTER `HordeStartO`;


-- script boreal tundra
-- Fizzcrank Fullthrottle
UPDATE creature_template SET  ScriptName = 'npc_fizzcrank_fullthrottle' WHERE entry = 25590;
-- Surristrasz
UPDATE creature_template SET  ScriptName = 'npc_surristrasz' WHERE entry =24795;
-- Librarian Tiare
UPDATE creature_template SET  ScriptName = 'npc_tiare' WHERE entry =30051;

UPDATE instance_template SET script = 'instance_eye_of_eternity' WHERE map = 616;
UPDATE creature_template SET VehicleId=264 WHERE entry = 30248;
UPDATE `gameobject_template` SET `ScriptName` = 'go_malygos_iris' WHERE `entry` IN (193960,193958); 

UPDATE creature_template SET ScriptName = 'boss_malygos', unit_flags = unit_flags & ~256 WHERE entry = 28859;
UPDATE creature_template SET ScriptName = 'mob_nexus_lord' WHERE entry = 30245; -- Nexus Lord
UPDATE creature_template SET ScriptName = 'mob_scion_of_eternity' WHERE entry = 30249; -- Scion of Eternity
UPDATE creature_template SET ScriptName = 'mob_power_spark' WHERE entry = 30084;  -- Power Spark
UPDATE creature_template SET ScriptName = 'npc_arcane_overload' WHERE entry = 30282; -- Arcane Overload

UPDATE creature_template SET unit_flags = 1 WHERE entry = 28859;

UPDATE creature_template SET mindmg = 3684, maxdmg = 4329, dmg_multiplier = 7.5, mechanic_immune_mask = 1072918979 WHERE entry = 30245; -- Nexus Lord
UPDATE creature_template SET mindmg = 3684, maxdmg = 4329, dmg_multiplier = 13,  mechanic_immune_mask = 1072918979 WHERE entry = 31750; -- Nexus Lord (1)
UPDATE creature_template SET mechanic_immune_mask = 1072918979 WHERE entry IN (30249, 31751);

DELETE FROM creature WHERE id = 33224;
INSERT INTO creature (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(33224, 571, 1, 1, 0, 0, 3730.57, -4302.91, 182.097, 2.35789, 300, 0, 0, 40, 120, 0, 0),  
(33224, 571, 1, 1, 0, 0, 3726.49, -4312.76, 179.671, 1.68559, 300, 0, 0, 40, 120, 0, 0),  
(33224, 571, 1, 1, 0, 0, 3714.32, -4311.07, 181.014, 0.81772, 300, 0, 0, 40, 120, 0, 0),  
(33224, 571, 1, 1, 0, 0, 3715.14, -4305.41, 182.313, 1.36436, 300, 0, 0, 40, 120, 0, 0),
(33224, 571, 1, 1, 0, 0, 3723.58, -4306.54, 182.245, 1.89215, 300, 0, 0, 40, 120, 0, 0);  

UPDATE `gameobject_template` SET `data10` = 26572 WHERE `entry`=180912;
UPDATE `gameobject_template` SET `data10` = 26566 WHERE `entry`=180911;

/*
-- achievement realm first magic seeker non-existing criteria Entry: 1400
DELETE FROM achievement_criteria_data WHERE criteria_id = 1400;
INSERT INTO achievement_criteria_data VALUES
(1400, 1, 28859, 0);
*/

UPDATE creature_template SET flags_extra = flags_extra | 2 WHERE entry = 30090; -- Vortex  'Arcane Overload', 'Hover Disk');
UPDATE creature_template SET flags_extra = flags_extra | 2, faction_A = 35, faction_H = 35, VehicleId = 165 WHERE entry IN (30234, 30248); -- Hover Disk
UPDATE creature_template SET flags_extra = flags_extra | 2, faction_A = 35, faction_H = 35 WHERE entry = 30118; -- Portal (Malygos)
UPDATE creature_template SET flags_extra = flags_extra | 2 WHERE entry = 30282; -- Arcane Overload
UPDATE creature_template SET mindmg = 1, maxdmg = 1, dmg_multiplier = 1 WHERE entry = 30592; -- Static Field
UPDATE creature_template SET modelid1 = 11686, modelid2 = 11686 WHERE entry = 22517; -- Some world trigger
-- Wyrmest Drake Spell & mount
UPDATE creature_template SET spell1 = 56091, spell2 = 56092, spell3 = 57090, spell4 = 57143, spell5 = 57108, spell6 = 57403, VehicleId = 165 WHERE entry IN (30161, 31752);
-- add de malygos & gameobject
UPDATE gameobject_template SET flags = 4, data0 = 43 WHERE entry in (193967, 193905);

-- Aggro Malygos
UPDATE creature_model_info SET combat_reach = '30' WHERE modelid = 26752;

-- drakes_disks
UPDATE creature_template SET InhabitType = 4, VehicleId = 223 WHERE entry IN (30234, 30248);
UPDATE creature_template SET spell6 = 57092, spell7 = 57403 WHERE entry IN (30161, 31752);

-- script_texts
DELETE FROM script_texts WHERE entry BETWEEN -1616034 AND -1616000;
INSERT INTO script_texts (npc_entry, entry, content_default, sound, type, language, emote, comment) VALUES
(28859, -1616000, 'Lesser beings, intruding here! A shame that your excess courage does not compensate for your stupidity!', 14512, 1, 0, 0, 'Malygos INTRO 1'),
(28859, -1616001, 'None but the blue dragonflight are welcome here! Perhaps this is the work of Alexstrasza? Well then, she has sent you to your deaths.', 14513, 1, 0, 0, 'Malygos INTRO 2'),
(28859, -1616002, 'What could you hope to accomplish, to storm brazenly into my domain? To employ MAGIC? Against ME?', 14514, 1, 0, 0, 'Malygos INTRO 3'),
(28859, -1616003, 'I am without limits here... the rules of your cherished reality do not apply... In this realm, I am in control...', 14515, 1, 0, 0, 'Malygos INTRO 4'),
(28859, -1616004, 'I give you one chance. Pledge fealty to me, and perhaps I won\'t slaughter you for your insolence!', 14516, 1, 0, 0, 'Malygos INTRO 5'),
(28859, -1616005, 'My patience has reached its limit, I WILL BE RID OF YOU!', 14517, 1, 0, 0, 'Malygos AGGRO 1'),
(28859, -1616006, 'Watch helplessly as your hopes are swept away...', 14525, 1, 0, 0, 'Malygos VORTEX'),
(28859, -1616007, 'I AM UNSTOPPABLE!', 14533, 1, 0, 0, 'Malygos SPARK BUFF'),
(28859, -1616008, 'Your stupidity has finally caught up to you!', 14519, 1, 0, 0, 'Malygos SLAY 1-1'),
(28859, -1616009, 'More artifacts to confiscate...', 14520, 1, 0, 0, 'Malygos SLAY 1-2'),
(28859, -1616010, 'How very... naive...', 14521, 1, 0, 0, 'Malygos SLAY 1-3'),
(28859, -1616012, 'I had hoped to end your lives quickly, but you have proven more...resilient then I had anticipated. Nonetheless, your efforts are in vain, it is you reckless, careless mortals who are to blame for this war! I do what I must...And if it means your...extinction...THEN SO BE IT!', 14522, 1, 0, 0, 'Malygos PHASEEND 1'),
(28859, -1616013, 'Few have experienced the pain I will now inflict upon you!', 14523, 1, 0, 0, 'Malygos AGGRO 2'),
(28859, -1616014, 'YOU WILL NOT SUCCEED WHILE I DRAW BREATH!', 14518, 1, 0, 0, 'Malygos DEEP BREATH'),
(28859, -1616016, 'I will teach you IGNORANT children just how little you know of magic...', 14524, 1, 0, 0, 'Malygos ARCANE OVERLOAD'),
(28859, -1616020, 'Your energy will be put to good use!', 14526, 1, 0, 0, 'Malygos SLAY 2-1'),
(28859, -1616021, 'I AM THE SPELL-WEAVER! My power is INFINITE!', 14527, 1, 0, 0, 'Malygos SLAY 2-2'),
(28859, -1616022, 'Your spirit will linger here forever!', 14528, 1, 0, 0, 'Malygos SLAY 2-3'),
(28859, -1616017, 'ENOUGH! If you intend to reclaim Azeroth\'s magic, then you shall have it...', 14529, 1, 0, 0, 'Malygos PHASEEND 2'),
(28859, -1616018, 'Now your benefactors make their appearance...But they are too late. The powers contained here are sufficient to destroy the world ten times over! What do you think they will do to you?', 14530, 1, 0, 0, 'Malygos PHASE 3 INTRO'),
(28859, -1616019, 'SUBMIT!', 14531, 1, 0, 0, 'Malygos AGGRO 3'),
(28859, -1616026, 'The powers at work here exceed anything you could possibly imagine!', 14532, 1, 0, 0, 'Malygos STATIC FIELD'),
(28859, -1616023, 'Alexstrasza! Another of your brood falls!', 14534, 1, 0, 0, 'Malygos SLAY 3-1'),
(28859, -1616024, 'Little more then gnats!', 14535, 1, 0, 0, 'Malygos SLAY 3-2'),
(28859, -1616025, 'Your red allies will share your fate...', 14536, 1, 0, 0, 'Malygos SLAY 3-3'),
(28859, -1616027, 'Still standing? Not for long...', 14537, 1, 0, 0, 'Malygos SPELL 1'),
(28859, -1616028, 'Your cause is lost!', 14538, 1, 0, 0, 'Malygos SPELL 1'),
(28859, -1616029, 'Your fragile mind will be shattered!', 14539, 1, 0, 0, 'Malygos SPELL 1'),
(28859, -1616030, 'UNTHINKABLE! The mortals will destroy... e-everything... my sister... what have you-', 14540, 1, 0, 0, 'Malygos DEATH'),
(32295, -1616031, 'I did what I had to, brother. You gave me no alternative.', 14406, 1, 0, 0, 'Alexstrasza OUTRO 1'),
(32295, -1616032, 'And so ends the Nexus War.', 14407, 1, 0, 0, 'Alexstrasza OUTRO 2'),
(32295, -1616033, 'This resolution pains me deeply, but the destruction, the monumental loss of life had to end. Regardless of Malygos\' recent transgressions, I will mourn his loss. He was once a guardian, a protector. This day, one of the world\'s mightiest has fallen.', 14408, 1, 0, 0, 'Alexstrasza OUTRO 3'),
(32295, -1616034, 'The red dragonflight will take on the burden of mending the devastation wrought on Azeroth. Return home to your people and rest. Tomorrow will bring you new challenges, and you must be ready to face them. Life...goes on.', 14409, 1, 0, 0, 'Alexstrasza OUTRO 4');

#Fix Spell Heart of the Wild
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` in ('-5487', '-9634', '-768');
INSERT INTO `spell_linked_spell` VALUES
(-5487,-24899,0, 'Heart of the Wild removed if not in Bear Form'),
(-9634,-24899,0, 'Heart of the Wild removed if not in Dire Bear Form'),
(-768,-24900,0, 'Heart of the Wild removed if not in Cat Form');

DELETE FROM `spell_dbc` WHERE `id` in ('24899', '24900');
INSERT INTO spell_dbc VALUES
(24899, 0, 0, 400, 1024, 0, 0, 2097152, 0, 144, 0, 0, 1, 0, 0, 101, 0, 0, 0, 0, 21, 1, 0, -1,
0, 0, 6, 0, 0, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 137, 0,
0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 1, 'Heart of the Wild Bear Effect'),
(24900, 0, 0, 400, 1024, 0, 0, 2097152, 0, 1, 0, 0, 1, 0, 0, 101, 0, 0, 0, 0, 21, 1, 0, -1, 0,
0, 6, 0, 0, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 166, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 1, 'Heart of the Wild Cat Effect');

DELETE FROM spell_bonus_data WHERE entry IN (56160,56131);
INSERT INTO `spell_bonus_data` (`entry`,`direct_bonus`,`dot_bonus`,`ap_bonus`,`ap_dot_bonus`,`comments`) VALUES
(56160, 0, 0, 0, 0, 'Priest Glyph of Power Word: Shield'),
(56131, 0, 0, 0, 0, 'Priest Glyph of Dispel Magic');

REPLACE INTO item_template
   (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `StatsCount`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`, `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `Duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `WDBVerified`)
VALUES
   (49623, 2, 1, -1, 'Shadowmourne', 65153, 5, 0, 0, 1, 2523810, 504762, 17, 260643, 8388607, 284, 80, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 4, 4, 223, 7, 198, 32, 114, 44, 114, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 954, 1592, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3700, 0, 0, 71903, 2, 0, 0, -1, 0, -1, 0, 1, 0, 0, -1, 0, -1, 0, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 145, 0, 0, 0, 0, 2, 0, 2, 0, 2, 0, 3312, 0, -1, 0, 0, 0, 0, '', 0, 0, 0, 0, 11723);

-- (12311) Gag Order (Rank 1)
DELETE FROM `spell_proc_event` WHERE `entry` IN (12311);
INSERT INTO `spell_proc_event` VALUES (12311, 0x01, 0, 0x00000800, 0x00000001, 0x00000000, 0x00020220, 0x00000207, 0, 50, 0);
-- (12958) Gag Order (Rank 2)
DELETE FROM `spell_proc_event` WHERE `entry` IN (12958);
INSERT INTO `spell_proc_event` VALUES (12958, 0x01, 0, 0x00000800, 0x00000001, 0x00000000, 0x00020220, 0x00000207, 0, 100, 0);

#Icecrown Citadel
#Cleanup first

UPDATE `creature_template` SET `ScriptName`='' WHERE `entry` IN (37813,38508,36626,36855,38222,36672,36612,38711,36678,37697,36853,36597,38995,36633,36609,37695,38757,36701,36725,37011,36724,37012,37007,36811,36807,36829,36844,36808,38135,37949,36627,36897,36899,37973,37970,37972,36789,38429,38068,38369,38332,38454,38422,38451);
UPDATE `gameobject_template` SET `ScriptName`='' WHERE `entry` IN (202235,202242,202244,202243,202245,202246,202182,202181);
DELETE FROM `creature` WHERE `id`=38995;

# GameObject
UPDATE `gameobject_template` SET `ScriptName` = 'icecrown_teleporter' WHERE `entry` IN (202223,202235,202242,202243,202244,202245,202246);
UPDATE `gameobject_template` SET `flags` = 32 WHERE `entry` = 202223;
UPDATE `gameobject_template` SET `flags` = 32 WHERE `entry` = 202242;

# Boss
UPDATE `creature_template` SET `ScriptName`='boss_blood_queen_lanathel' WHERE (`entry`='37955');
UPDATE `creature_template` SET `ScriptName`='boss_festergut' WHERE (`entry`='36626');
UPDATE `creature_template` SET `ScriptName`='boss_saurfang' WHERE (`entry`='37813');
UPDATE `creature_template` SET `ScriptName`='boss_lady_deathwisper' WHERE (`entry`='36855');
UPDATE `creature_template` SET `ScriptName`='boss_professor_putricide' WHERE (`entry`='36678');
UPDATE `creature_template` SET `ScriptName`='boss_blood_elf_valanar_icc' WHERE `entry` = 37970;
UPDATE `creature_template` SET `ScriptName`='boss_blood_elf_keleset_icc' WHERE `entry` = 37972;
UPDATE `creature_template` SET `ScriptName`='boss_blood_elf_taldaram_icc' WHERE `entry` = 37973;
UPDATE `creature_template` SET `ScriptName`='boss_sindragosa' WHERE (`entry`='36853');
UPDATE `creature_template` SET `ScriptName`='boss_valithria' WHERE `entry` = 36789;
UPDATE `creature_template` SET `ScriptName`='boss_the_lich_king' WHERE (`entry`='36597');
UPDATE `creature_template` SET `ScriptName`='boss_rotface' WHERE `entry`= 36627;
UPDATE `creature_template` SET `ScriptName`='boss_lord_marrowgar' WHERE (`entry`='36612');

# Mobs
UPDATE `creature_template` SET `ScriptName`='npc_tirion_icc' WHERE (`entry`='38995');
UPDATE `creature_template` SET `ScriptName`='npc_swarming_shadows' WHERE (`entry`='38163');
UPDATE `creature_template` SET `ScriptName`='npc_bloodbeast' WHERE (`entry`='38508');
UPDATE `creature_template` SET `ScriptName`='npc_cold_flame' WHERE (`entry`='36672');
UPDATE `creature_template` SET `ScriptName`='npc_bone_spike' WHERE (`entry`='38711'); 
UPDATE `creature_template` SET `ScriptName`='npc_volatile_ooze' WHERE (`entry`='37697');  
UPDATE `creature_template` SET `ScriptName`='npc_ice_puls_icc' WHERE (`entry`='36633');
UPDATE `creature_template` SET `ScriptName`='npc_valkyr_icc' WHERE (`entry`='36609');
UPDATE `creature_template` SET `ScriptName`='npc_ghoul_icc' WHERE (`entry`='37695');
UPDATE `creature_template` SET `ScriptName`='npc_defile_icc' WHERE (`entry`='38757');
UPDATE `creature_template` SET `ScriptName`='npc_raging_spirit_icc' WHERE (`entry`='36701');
UPDATE `creature_template` SET `ScriptName`='npc_ooze_little' WHERE `entry`= 36897;
UPDATE `creature_template` SET `ScriptName`='npc_ooze_big' WHERE `entry`= 36899;
UPDATE `creature_template` SET `ScriptName`='npc_nerubar_brood_keeper' WHERE `entry` = 36725;
UPDATE `creature_template` SET `ScriptName`='npc_the_damned' WHERE `entry` = 37011;
UPDATE `creature_template` SET `ScriptName`='npc_servant_of_the_throne' WHERE `entry` = 36724;
UPDATE `creature_template` SET `ScriptName`='npc_ancient_skeletal_soldier' WHERE `entry` = 37012;
UPDATE `creature_template` SET `ScriptName`='npc_death_bound_ward' WHERE `entry` = 37007;
UPDATE `creature_template` SET `ScriptName`='npc_death_speaker_attedant' WHERE `entry` = 36811;
UPDATE `creature_template` SET `ScriptName`='npc_death_speaker_disciple' WHERE `entry` = 36807;
UPDATE `creature_template` SET `ScriptName`='npc_death_speaker_high_priest' WHERE `entry` = 36829;
UPDATE `creature_template` SET `ScriptName`='npc_death_speaker_servant' WHERE `entry` = 36844;
UPDATE `creature_template` SET `ScriptName`='npc_death_speaker_zealot' WHERE `entry` = 36808;
UPDATE `creature_template` SET `ScriptName`='npc_cult_fanatic' WHERE `entry` = 38135;
UPDATE `creature_template` SET `ScriptName`='npc_cult_adherent' WHERE `entry` = 37949;
UPDATE `creature_template` SET `ScriptName`='npc_shade' WHERE `entry` = 38222;
UPDATE `creature_template` SET `ScriptName`='npc_skellmage_icc' WHERE `entry` = 37868;
UPDATE `creature_template` SET `ScriptName`='npc_fireskell_icc' WHERE `entry` = 36791;
UPDATE `creature_template` SET `ScriptName`='npc_suppressor_icc' WHERE `entry` = 37863;
UPDATE `creature_template` SET `ScriptName`='npc_manavoid_icc' WHERE `entry` = 38068;
UPDATE `creature_template` SET `ScriptName`='npc_glutabomination_icc' WHERE `entry` = 37886;
UPDATE `creature_template` SET `ScriptName`='npc_blistzombie_icc' WHERE `entry` = 37934;
UPDATE `creature_template` SET `ScriptName`='npc_dreamcloud_icc' WHERE `entry` = 37985;
UPDATE `creature_template` SET `ScriptName`='npc_dreamportal_icc' WHERE `entry` = 37945;
UPDATE `creature_template` set `minlevel` = 80,`maxlevel` = 80,`faction_A` = 16,`Faction_H` = 16,`unit_flags` = 2 where `entry` in (36672);
UPDATE creature_template SET ScriptName='npc_nucleus_icc' WHERE entry=38369;
UPDATE creature_template SET ScriptName='npc_fireball_icc' WHERE entry=38332;
UPDATE creature_template SET ScriptName='npc_bomb_icc' WHERE entry=38454;
UPDATE creature_template SET ScriptName='npc_vortex_icc' WHERE entry=38422;
UPDATE creature_template SET ScriptName='npc_empfireball_icc' WHERE entry=38451; 

# Other
UPDATE `creature_template` SET `faction_A` = '35', `faction_H` = '35', `unit_flags` = '8', `type_flags` = '67113038' WHERE `entry` IN(36789,10067,10068,10069);

-- Fix crash until get properly fixed
UPDATE `creature_template` SET `VehicleId` = 0 WHERE `entry` IN (37813,13106,13107,13108);
-- UPDATE `creature_template` SET `VehicleId` = 639 WHERE `entry` IN (37813,13106,13107,13108);

UPDATE `creature_template` SET `vehicleId` = 0 WHERE `entry` = 36609;
-- UPDATE `creature_template` SET `vehicleId` = 318 WHERE `entry` = 36609;

# Instance
UPDATE `instance_template` SET `script`='instance_icecrown_citadel' WHERE (`map`='631');

# Script Texts

DELETE FROM script_texts WHERE entry <= -1665892 AND entry >= -1666080;
DELETE FROM script_texts WHERE entry <= -1810001 AND entry >= -1810031;

# 1
INSERT INTO `script_texts` VALUES ('36612', '-1665892', 'This is the beginning AND the end, mortals. None may enter the master''s sanctum!', '', '', '', '', '', '', '', '', '16950', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('36612', '-1665893', 'The Scourge will wash over this world as a swarm of death and destruction!', '', '', '', '', '', '', '', '', '16941', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('36612', '-1665894', 'BONE STORM!', '', '', '', '', '', '', '', '', '16946', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('36612', '-1665895', 'Bound by bone!', '', '', '', '', '', '', '', '', '16947', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36612', '-1665896', 'Stick Around!', '', '', '', '', '', '', '', '', '16948', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36612', '-1665897', 'The only escape is death!', '', '', '', '', '', '', '', '', '16949', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36612', '-1665898', 'More bones for the offering!', '', '', '', '', '', '', '', '', '16942', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36612', '-1665899', 'Languish in damnation!', '', '', '', '', '', '', '', '', '16943', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36612', '-1665900', 'I see... only darkness...', '', '', '', '', '', '', '', '', '16944', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36612', '-1665901', 'THE MASTER''S RAGE COURSES THROUGH ME!', '', '', '', '', '', '', '', '', '16945', '1', '0', '0', '');

# 2
INSERT INTO `script_texts` VALUES ('36855', '-1665902', 'You have found your way here, because you are among the few gifted with true vision in a world cursed with blindness!', '', '', '', '', '', '', '', '', '17272', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36855', '-1665903', 'You can see through the fog that hangs over this world like a shroud and grasp where true power lies!', '', '', '', '', '', '', '', '', '17273', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36855', '-1665904', 'Fix your eyes upon your crude hands! The sinew, the soft meat, the dark blood coursing within!', '', '', '', '', '', '', '', '', '16878', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36855', '-1665905', 'It is a weakness! A crippling flaw! A joke played by the creators upon their own creations!', '', '', '', '', '', '', '', '', '17268', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36855', '-1665906', 'The sooner you come to accept your condition as a defect, the sooner you will find yourselves in a position to transcend it!', '', '', '', '', '', '', '', '', '17269', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36855', '-1665907', 'Through our master all things are possible! His power is without limit, and his will unbending!', '', '', '', '', '', '', '', '', '17270', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36855', '-1665908', 'Those who oppose him will be destroyed utterly! And those who serve, who serve wholly, unquestioningly, with utter devotion of mind and soul? Elevated! To heights beyond your ken!', '', '', '', '', '', '', '', '', '17271', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36855', '-1665909', 'What is this disturbance?! You dare trespass upon this hallowed ground? This shall be your final resting place.', '', '', '', '', '', '', '', '', '16868', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36855', '-1665910', 'Enough! I see I must take matters into my own hands!', '', '', '', '', '', '', '', '', '16877', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36855', '-1665911', 'Take this blessing and show these intruders a taste of our master''s power.', '', '', '', '', '', '', '', '', '16873', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36855', '-1665912', 'I release you from the curse of flesh!', '', '', '', '', '', '', '', '', '16874', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36855', '-1665913', 'Arise and exalt in your pure form!', '', '', '', '', '', '', '', '', '16875', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36855', '-1665914', 'You are weak, powerless to resist my will!', '', '', '', '', '', '', '', '', '16876', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36855', '-1665915', 'This charade has gone on long enough.', '', '', '', '', '', '', '', '', '16872', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36855', '-1665916', 'All part of the masters plan! Your end is... inevitable!', '', '', '', '', '', '', '', '', '16871', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36855', '-1665917', 'Do you yet grasp of the futility of your actions?', '', '', '', '', '', '', '', '', '16869', '1', '0', '0', '');
INSERT INTO `script_texts` VALUES ('36855', '-1665918', 'Embrace the darkness... Darkness eternal!', '', '', '', '', '', '', '', '', '16870', '1', '0', '0', '');

# 3
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(0,-1665919,'Thank the spirits for you, brothers and sisters. The Skybreaker has already left. Quickly now, to Orgrim''s Hammer! If you leave soon, you may be able to catch them.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,''),
(0,-1665920,'This should be helpin''ya!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,''),
(0,-1665921,'Aka''Magosh, brave warriors. The alliance is in great number here.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665922,'Captain Saurfang will be pleased to see you aboard Orgrim''s Hammer. Make haste, we will secure the area until you are ready for take-off.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665923,'A screeching cry pierces the air above!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665924,'A Spire Frostwyrm lands just before Orgrim''s Hammer.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665925,'Rise up, sons and daughters of the Horde! Today we battle a hated enemy of the Horde! LOK''TAR OGAR! Kor''kron, take us out!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665926,'What is that?! Something approaching in the distance!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665927,'ALLIANCE GUNSHIP! ALL HANDS ON DECK!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665928,'Move yer jalopy or we''ll blow it out of the sky, orc! The Horde''s got no business here!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665929,'You will know our business soon! KOR''KRON, ANNIHILATE THEM!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665930,'Marines, Sergeants, attack!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665931,'You DARE board my ship? Your death will come swiftly.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665932,'Riflemen, shoot faster!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665933,'Mortar team, reload!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665934,'We''re taking hull damage, get a sorcerer out here to shut down those cannons!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665935,'The Alliance falter. Onward to the Lich King!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665936,'Damage control! Put those fires out! You haven''t seen the last of the Horde!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665937,'Thank goodness you arrived when you did, heroes. Orgrim''s Hammer has already left. Quickly now, to The Skybreaker! If you leave soon, you may be able to catch them.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665938,'This ought to help!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665939,'Skybreaker Sorcerer summons a Skybreaker Battle Standard.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665940,'You have my thanks. We were outnumbered until you arrived.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665941,'Captain Muradin is waiting aboard The Skybreaker. We''ll secure the area until you are ready for take off.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665942,'Skybreaker infantry, hold position!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665943,'A screeching cry pierces the air above!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665944,'A Spire Frostwyrm lands just before The Skybreaker. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665945,'Fire up the engines! We got a meetin with destiny, lads!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665946,'Hold on to yer hats!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665947,'What in the world is that? Grab me spyglass, crewman!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665948,'By me own beard! HORDE SAILIN IN FAST N HOT!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665949,'EVASIVE ACTION! MAN THE GUNS!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665950,'Cowardly dogs! Ye blindsighted us!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665951,'This is not your battle, dwarf. Back down or we will be forced to destroy your ship.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665952,'Not me battle? I dunnae who ye? think ye are, mister, but I got a score to settle with Arthas and yer not gettin in me way! FIRE ALL GUNS! FIRE! FIRE!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665953,'Reavers, Sergeants, attack!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665954,'What''s this then?! Ye won''t be takin this son o Ironforge''s vessel without a fight!.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665955,'Axethrowers, hurl faster!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665956,'Rocketeers, reload!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665957,'We''re taking hull damage, get a battle-mage out here to shut down those cannons!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665958,'Don''t say I didn''t warn ya, scoundrels! Onward, brothers and sisters!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665959,'Captain Bartlett, get us out of here! We''re taken too much damage to stay afloat!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'');

# 4
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(0,-1665960,'For every Horde soldier that you killed, for every Alliance dog that fell, the Lich King''s armies grew. Even now the Val''kyr work to raise your fallen... As Scourge.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665961,'Things are about to get much worse. Come, taste the power that the Lich King has bestowed upon me!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665962,'A lone orc, against the might of the Alliance? Charge!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665963,'Hahahaha! Dwarves.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665964,'Kor''kron, move out! Champions, watch your backs! The Scourge have been...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665965,'Join me, father. Join me and we will crush this world in the name of the Scourge. For the glory of the Lich King!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665966,'My boy died at the Wrathgate. I am here only to collect his body!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665967,'Stubborn and old. What chance do you have? I am stronger and more powerful than you ever were!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665968,'We named him Dranosh. It means "Heart of Draenor" in Orcish. I would not let the warlocks take him. My boy would be safe, hidden away by the elders of Garadar.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665969,'I made a promise to his mother before she died: that I would cross the Dark Portal alone - whether I lived or died, my son would be safe. Untainted...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665970,'Today, I fulfill that promise.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665971,'High Overlord Saurfang charges!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665972,'Pathetic old orc. Come then heroes, come and face the might of the Scourge!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665973,'BY THE MIGHT OF THE LICH KING!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16694,1,0,0,''),
(0,-1665974,'The ground runs red with your blood!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16699,1,0,0,''),
(0,-1665975,'Feast, my minions!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16700,1,0,0,''),
(0,-1665976,'You are nothing!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16695,1,0,0,''),
(0,-1665977,'Your soul will find no redemption here!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16696,1,0,0,''),
(0,-1665978,'I have become...DEATH!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16698,1,0,0,''),
(0,-1665979,'I... Am... Released.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16697,1,0,0,''),
(0,-1665980,'Muradin Bronzebeard gasps for air.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665981,'That was Saurfang''s boy - the Horde commander at the Wrath Gate. Such a tragic end...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665982,'What in the... There, in the distance!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665983,'A Horde Zeppelin flies up to the rise',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665984,'Soldiers, fall in! Looks like the Horde are comin in to take another shot!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665985,'The Zeppelin docks, and High Overlord Saurfang hops out, confronting the Alliance soldiers and Muradin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665986,'Don''t force my hand, orc. We can''t let you pass.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665987,'Behind you lies the body of my only son. Nothing will keep me from him.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665988,'He... I can''t do it. Get back on your ship and we''ll spare your life.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665989,'Stand down, Muradin. Let a grieving father pass.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665990,'High Overlord Saurfang kneels over his son''s body.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665991,'[Orcish] No''ku kil zil''nok ha tar.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665992,'Higher Overlord Saurfang picks up the body of his son and walks over towards Varian',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665993,'I will not forget this kindess. I thank you, highness.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665994,'I... I was not at the Wrathgate. But the soldiers who survived told me much of what happened. Your son fought with honor. He died a hero''s death. He deserves a hero''s burial.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665995,'Lady Jaina Proudmoore cries.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665996,'Jaina, why are you crying?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665997,'It was nothing, your majesty. Just... I''m proud of my king.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665998,'Muradin, secure the deck and prepare our soldiers for an assault on the Upper Citadel. I''ll send out another regiment from Stormwind.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665999,'Let''s get the move then. Move out!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666000,'High Overlord Saurfang coughs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666001,'High Overlord Saurfang weeps over the corpse of his son.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666002,'You will have a proper ceremony in Nagrand next to the pyres of your mother and ancestors.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666003,'Honor, young heroes... no matter how dire the battle... Never forsake it!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'');

# 5
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(0,-1666004,'NOOOO! You kill Stinky! You pay!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16907,1,0,0,''),
(0,-1666005,'Fun time!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16901,1,0,0,''),
(0,-1666006,'Just an ordinary gas cloud. But watch out, because that''s no ordinary gas cloud!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666007,'Festergut farts.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16911,4,0,0,''),
(0,-1666008,'Gyah! Uhhh, I not feel so good...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16906,1,0,0,''),
(0,-1666009,'Festergut vomits.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666010,'Daddy, I did it!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16902,1,0,0,''),
(0,-1666011,'Dead, dead, dead! ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16903,1,0,0,''),
(0,-1666012,'Fun time over!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16905,1,0,0,''),
(0,-1666013,'Da...Daddy...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16904,1,0,0,''),
(0,-1666014,'Oh, Festergut. You were always my favorite. Next to Rotface. The good news is you left behind so much gas, I can practically taste it!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'');

# 6
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(0,-1666015,'What? Precious? Noooooooooo!!!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16993,1,0,0,''),
(0,-1666016,'WEEEEEE!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16986,1,0,0,''),
(0,-1666017,'Icky sticky.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16991,1,0,0,''),
(0,-1666018,'I think I made an angry poo-poo. It gonna blow! ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16992,1,0,0,''),
(0,-1666019,'Great news, everyone! The slime is flowing again!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666020,'Good news, everyone! I''ve fixed the poison slime pipes!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666021,'Daddy make toys out of you!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16988,1,0,0,''),
(0,-1666022,'I brokes-ded it...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16987,1,0,0,''),
(0,-1666023,'Sleepy Time!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16990,1,0,0,''),
(0,-1666024,'Bad news daddy.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16989,1,0,0,''),
(0,-1666025,' Terrible news, everyone, Rotface is dead! But great news everyone, he left behind plenty of ooze for me to use! Whaa...? I''m a poet, and I didn''t know it? Astounding!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'');

# 7
INSERT INTO `script_texts`(`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(0,-1666026,'Good news, everyone! I think I perfected a plague that will destroy all life on Azeroth!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666027,'You can''t come in here all dirty like that! You need that nasty flesh scrubbed off first!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666028,'Two oozes, one room! So many delightful possibilities...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666029,'Hmm. I don''t feel a thing. Whaa...? Where''d those come from?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666030,'Tastes like... Cherry! Oh! Excuse me!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666031,'Hmm... Interesting...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666032,'That was unexpected!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666033,'Great news, everyone!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666034,'Bad news, everyone! I don''t think I''m going to make it.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'');

# 8
INSERT INTO `script_texts`(`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(0,-1666035,'Foolish mortals. You thought us defeated so easily? The San''layn are the Lich King''s immortal soldiers! Now you shall face their might combined!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666036,'Rise up, brothers, and destroy our enemies.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666037,'Such wondrous power! The Darkfallen Orb has made me INVINCIBLE!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666038,'Blood will flow!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666039,'Were you ever a threat?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666040,'Truth is found in death.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666041,'Prince Keleseth cackles maniacally!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0,''),
(0,-1666042,'My queen... they come...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666043,'Tremble before Taldaram, mortals, for the power of the orb flows through me!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666044,'Delight in the pain!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666045,'Worm food.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666046,'Beg for mercy!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666047,'Prince Taldaram laughs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0,''),
(0,-1666048,'Prince Taldaram gurgles and dies.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0,''),
(0,-1666049,'Naxxanar was merely a setback! With the power of the orb, Valanar will have his vengeance!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666050,'Dinner... is served.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666051,'Do you see NOW the power of the Darkfallen?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666052,'BOW DOWN BEFORE THE SAN''LAYN!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666053,'...why...?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'');

# 9
INSERT INTO `script_texts`(`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(0,-1666054,'You have made an... unwise... decision.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16782,1,0,0,''),
(0,-1666055,'Just a taste...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16783,1,0,0,''),
(0,-1666056,'Know my hunger!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16784,1,0,0,''),
(0,-1666057,'SUFFER!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16787,1,0,0,''),
(0,-1666058,'Can you handle this?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16787,1,0,0,''),
(0,-1666059,'Yes... feed my precious one! You''re mine now! ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16790,1,0,0,''),
(0,-1666060,'Here it comes.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666061,'THIS ENDS NOW!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16793,1,0,0,''),
(0,-1666062,'But... we were getting along... so well...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16794,1,0,0,'');

# 10
INSERT INTO `script_texts`(`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(0,-1666063,'Heroes, lend me your aid! I... I cannot hold them off much longer! You must heal my wounds!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17064,1,0,0,''),
(0,-1666064,'I have opened a portal into the Emerald Dream. Your salvation lies within, heroes.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666065,'My strength is returning! Press on, heroes!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17070,1,0,0,''),
(0,-1666066,'I will not last much longer!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17069,1,0,0,''),
(0,-1666067,'Forgive me for what I do! I... cannot... stop... ONLY NIGHTMARES REMAIN!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17072,1,0,0,''),
(0,-1666068,'A tragic loss...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17066,1,0,0,''),
(0,-1666069,'FAILURES!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17067,1,0,0,''),
(0,-1666070,'I am renewed! Ysera grants me the favor to lay these foul creatures to rest!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17071,1,0,0,'');

# 11
INSERT INTO `script_texts`(`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(0,-1666071,'You are fools who have come to this place! The icy winds of Northrend will consume your souls!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17007,1,0,0,''),
(0,-1666072,'Suffer, mortals, as your pathetic magic betrays you!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17014,1,0,0,''),
(0,-1666073,'Can you feel the cold hand of death upon your heart?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17013,1,0,0,''),
(0,-1666074,'Aaah! It burns! What sorcery is this?!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17015,1,0,0,''),
(0,-1666075,'Your incursion ends here! None shall survive!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17012,1,0,0,''),
(0,-1666076,'Now feel my master''s limitless power and despair!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17016,1,0,0,''),
(0,-1666077,'Perish!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17008,1,0,0,''),
(0,-1666078,'A flaw of mortality...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17009,1,0,0,''),
(0,-1666079,'Enough! I tire of these games!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17011,1,0,0,''),
(0,-1666080,'Free...at last...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17010,1,0,0,'');

# 12
INSERT INTO script_texts (entry,content_default,content_loc1,content_loc2,content_loc3,content_loc4,content_loc5,content_loc6,content_loc7,content_loc8,sound,type,language,emote,comment)VALUES
(-1810001, 'So...the Light''s vaunted justice has finally arrived. Shall I lay down Frostmourne and throw myself at your mercy, Fordring?',null,null,null,null,null,null,null,null,17349,1,0,0,''),
(-1810002, 'We will grant you a swift death, Arthas. More than can be said for the thousands you''ve tortured and slain.',null,null,null,null,null,null,null,null,17390,1,0,0,''),
(-1810003, 'You will learn of that first hand. When my work is complete, you will beg for mercy -- and I will deny you. Your anguished cries will be testament to my unbridled power.',null,null,null,null,null,null,null,null,17350,1,0,0,''),
(-1810004, 'So be it. Champions, attack!',null,null,null,null,null,null,null,null,17391,1,0,0,''),
(-1810005, 'I''ll keep you alive to witness the end, Fordring. I would not want the Light''s greatest champion to miss seeing this wretched world remade in my image.',null,null,null,null,null,null,null,null,17351,1,0,0,''),
(-1810006, 'Come then champions, feed me your rage!',null,null,null,null,null,null,null,null,17352,1,0,0,''),
(-1810007, 'I will freeze you from within until all that remains is an icy husk!',null,null,null,null,null,null,null,null,17369,1,0,0,''),
(-1810008, 'Apocalypse!',null,null,null,null,null,null,null,null,17371,1,0,0,''),
(-1810009, 'Bow down before your lord and master!',null,null,null,null,null,null,null,null,17372,1,0,0,''),
(-1810010, 'Hope wanes!',null,null,null,null,null,null,null,null,17363,1,0,0,''),
(-1810011, 'The end has come!',null,null,null,null,null,null,null,null,17364,1,0,0,''),
(-1810012, 'Face now your tragic end!',null,null,null,null,null,null,null,null,17365,1,0,0,''),
(-1810013, 'No question remains unanswered. No doubts linger. You are Azeroth''s greatest champions! You overcame every challenge I laid before you. My mightiest servants have fallen before your relentless onslaught, your unbridled fury... Is it truly righteousness that drives you? I wonder.',null,null,null,null,null,null,null,null,17353,1,0,0,''),
(-1810014, 'You trained them well, Fordring. You delivered the greatest fighting force this world has ever known... right into my hands -- exactly as I intended. You shall be rewarded for your unwitting sacrifice.',null,null,null,null,null,null,null,null,17355,1,0,0,''),
(-1810015, 'Watch now as I raise them from the dead to become masters of the Scourge. They will shroud this world in chaos and destruction. Azeroth''s fall will come at their hands -- and you will be the first to die.',null,null,null,null,null,null,null,null,17356,1,0,0,''),
(-1810016, 'I delight in the irony.',null,null,null,null,null,null,null,null,17357,1,0,0,''),
(-1810017, 'LIGHT, GRANT ME ONE FINAL BLESSING. GIVE ME THE STRENGTH... TO SHATTER THESE BONDS!',null,null,null,null,null,null,null,null,17392,1,0,0,''),
(-1810018, 'Impossible...',null,null,null,null,null,null,null,null,17358,1,0,0,''),
(-1810019, '',null,null,null,null,null,null,null,null,17360,1,0,0,''),
(-1810020, 'No more, Arthas! No more lives will be consumed by your hatred!',null,null,null,null,null,null,null,null,17393,1,0,0,''),
(-1810021, 'Free at last! It is over, my son. This is the moment of reckoning.',null,null,null,null,null,null,null,null,17397,1,0,0,''),
(-1810022, 'The Lich King must fall!',null,null,null,null,null,null,null,null,17389,1,0,0,''),
(-1810023, 'Rise up, champions of the Light!',null,null,null,null,null,null,null,null,17398,1,0,0,''),
(-1810024, 'Now I stand, the lion before the lambs... and they do not fear.',null,null,null,null,null,null,null,null,17361,1,0,0,''),
(-1810025, 'They cannot fear.',null,null,null,null,null,null,null,null,17362,1,0,0,''),
(-1810026, 'Argh... Frostmourne, obey me!',null,null,null,null,null,null,null,null,17367,1,0,0,''),
(-1810027, 'Frostmourne hungers...',null,null,null,null,null,null,null,null,17366,1,0,0,''),
(-1810028, 'Frostmourne feeds on the soul of your fallen ally!',null,null,null,null,null,null,null,null,17368,1,0,0,''),
(-1810029, 'Val''kyr, your master calls!',null,null,null,null,null,null,null,null,17373,1,0,0,''),
(-1810030, 'Watch as the world around you collapses!',null,null,null,null,null,null,null,null,17370,1,0,0,''),
(-1810031, 'You gnats actually hurt me! Perhaps I''ve toyed with you long enough, now taste the vengeance of the grave!',null,null,null,null,null,null,null,null,17359,1,0,0,'');

DELETE FROM `gameobject_scripts` WHERE `id`=201584;
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`) VALUES 
(201584, 0, 15, 70308, 0, 'Transformation'),
(201584, 5000, 15, 70311, 0, 'Transformation End'),
(201584, 5000, 13, 201584, 0, 'Spawn');

REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES (38285, 0, 0, 0, 0, 0, 31008, 0, 31008, 0, 'Mutated Abomination', '', '', 0, 82, 82, 0, 35, 35, 0, 1, 1, 488, 642, 0, 782, 8.5, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 363, 521, 121, 6, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 72508, 72527, 70539, 70542, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 167.345, 1, 0, 0, 0, 0, 0, 0, 0, 170, 1, 0, 609320197, 0, '');
REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES (37672, 0, 38285, 0, 0, 0, 31008, 0, 31008, 0, 'Mutated Abomination', '', '', 0, 80, 80, 2, 35, 35, 0, 1, 1, 422, 586, 0, 642, 7.5, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 345, 509, 103, 6, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 72508, 72527, 70539, 70542, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 108.471, 1, 0, 0, 0, 0, 0, 0, 0, 170, 1, 0, 609320197, 0, '');
REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES (38159, 0, 0, 0, 0, 0, 1126, 27823, 1126, 0, 'Choking Gas Bomb', '', '', 0, 80, 80, 2, 2068, 2068, 0, 1, 0, 422, 586, 0, 642, 1.4, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 345, 509, 103, 10, 16778240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'EventAI', 0, 3, 4.71733, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 'npc_choke_bomb');
REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES (37006, 0, 0, 0, 0, 0, 1126, 11686, 1126, 0, 'Sticky Ooze', '', '', 0, 1, 1, 0, 16, 16, 0, 1, 0, 2, 2, 0, 24, 1, 2000, 2000, 1, 0, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 201786289, 0, 'npc_sticky_ooze');
REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES (37013, 0, 0, 0, 0, 0, 1126, 11686, 1126, 0, 'Puddle Stalker', '', '', 0, 1, 1, 0, 14, 14, 0, 1, 0, 2, 2, 0, 24, 1, 2000, 2000, 1, 33554432, 8, 0, 0, 0, 0, 0, 1, 1, 100, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2067619643, 0, 'npc_flood_ooze');
REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`,  `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES (37985, 0, 0, 0, 0, 0, 30877, 169, 30877, 0, 'Dream Cloud', '', '', 0, 80, 80, 0, 16, 16, 0, 1, 0, 1, 2, 0, 0, 1, 2000, 2000, 1, 0, 8, 0, 0, 0, 0, 0, 1, 1, 1, 10, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 400, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2128592795, 0, 'npc_dreamcloud_icc');
REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`,  `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES (38068, 0, 0, 0, 0, 0, 169, 11686, 169, 0, 'Mana Void', '', '', 0, 80, 80, 0, 16, 16, 0, 1, 0, 307, 459, 0, 115, 1, 2000, 2000, 1, 0, 8, 0, 0, 0, 0, 0, 246, 367, 92, 10, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 71085, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100677675, 0, 'npc_manavoid_icc');

INSERT INTO spell_linked_spell VALUES (-69290, 72103, 0, 'Festergut: Spores end => Inoculated');

-- some naxx loot and script_ai

DELETE FROM `creature_loot_template` WHERE (`entry`=16017);
INSERT INTO `creature_loot_template` VALUES 
(16017, 33470, 33, 1, 0, 2, 7),
(16017, 43852, 17, 1, 0, 1, 1),
(16017, 35947, 7, 1, 0, 1, 1),
(16017, 33445, 4, 1, 0, 1, 1),
(16017, 33447, 2, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29347);
INSERT INTO `creature_loot_template` VALUES 
(29347, 33470, 33, 1, 0, 2, 7),
(29347, 43852, 17, 1, 0, 1, 1),
(29347, 35947, 7, 1, 0, 1, 1),
(29347, 33445, 4, 1, 0, 1, 1),
(29347, 40412, 1.5, 1, 1, 1, 1),
(29347, 40409, 1.5, 1, 1, 1, 1),
(29347, 40408, 1.5, 1, 1, 1, 1),
(29347, 40406, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16018);
INSERT INTO `creature_loot_template` VALUES 
(16018, 33470, 33, 1, 0, 2, 7),
(16018, 43852, 17, 1, 0, 1, 1),
(16018, 35947, 7, 1, 0, 1, 1),
(16018, 33445, 4, 1, 0, 1, 1),
(16018, 33447, 2, 1, 0, 1, 1),
(16018, 39470, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29353);
INSERT INTO `creature_loot_template` VALUES 
(29353, 33470, 33, 1, 0, 2, 7),
(29353, 43852, 17, 1, 0, 1, 1),
(29353, 35947, 7, 1, 0, 1, 1),
(29353, 33445, 4, 1, 0, 1, 1),
(29353, 40412, 1.5, 1, 1, 1, 1),
(29353, 40409, 1.5, 1, 1, 1, 1),
(29353, 40414, 1.5, 1, 1, 1, 1),
(29353, 40410, 1.5, 1, 1, 1, 1),
(29353, 40406, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16029);
INSERT INTO `creature_loot_template` VALUES 
(16029, 33470, 33, 1, 0, 2, 7),
(16029, 43852, 17, 1, 0, 1, 1),
(16029, 35947, 7, 1, 0, 1, 1),
(16029, 33445, 4, 1, 0, 1, 1),
(16029, 33447, 2, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29356);
INSERT INTO `creature_loot_template` VALUES 
(29356, 33470, 33, 1, 0, 2, 7),
(29356, 43852, 17, 1, 0, 1, 1),
(29356, 35947, 7, 1, 0, 1, 1),
(29356, 33445, 4, 1, 0, 1, 1),
(29356, 40412, 1.5, 1, 1, 1, 1),
(29356, 40406, 1.5, 1, 1, 1, 1),
(29356, 40408, 1.5, 1, 1, 1, 1),
(29356, 40407, 1.5, 1, 1, 1, 1),
(29356, 40410, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16020);
INSERT INTO `creature_loot_template` VALUES 
(16020, 33470, 33, 1, 0, 2, 7),
(16020, 43852, 17, 1, 0, 1, 1),
(16020, 35947, 7, 1, 0, 1, 1),
(16020, 33445, 4, 1, 0, 1, 1),
(16020, 33447, 2, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29362);
INSERT INTO `creature_loot_template` VALUES 
(29362, 33470, 33, 1, 0, 2, 7),
(29362, 43852, 17, 1, 0, 1, 1),
(29362, 35947, 7, 1, 0, 1, 1),
(29362, 33445, 4, 1, 0, 1, 1),
(29362, 40409, 1.5, 1, 1, 1, 1),
(29362, 40412, 1.5, 1, 1, 1, 1),
(29362, 40414, 1.5, 1, 1, 1, 1),
(29362, 40407, 1.5, 1, 1, 1, 1),
(29362, 40408, 1.5, 1, 1, 1, 1),
(29362, 40410, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16022);
INSERT INTO `creature_loot_template` VALUES 
(16022, 33470, 33, 1, 0, 2, 7),
(16022, 43852, 17, 1, 0, 1, 1),
(16022, 35947, 7, 1, 0, 1, 1),
(16022, 33445, 4, 1, 0, 1, 1),
(16022, 33447, 2, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29363);
INSERT INTO `creature_loot_template` VALUES 
(29363, 33470, 33, 1, 0, 2, 7),
(29363, 43852, 17, 1, 0, 1, 1),
(29363, 35947, 7, 1, 0, 1, 1),
(29363, 33445, 4, 1, 0, 1, 1),
(29363, 33447, 2, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16021);
INSERT INTO `creature_loot_template` VALUES 
(16021, 33470, 33, 1, 0, 2, 7),
(16021, 43852, 17, 1, 0, 1, 1),
(16021, 35947, 7, 1, 0, 1, 1),
(16021, 33445, 4, 1, 0, 1, 1),
(16021, 33447, 2, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29359);
INSERT INTO `creature_loot_template` VALUES 
(29359, 33470, 33, 1, 0, 2, 7),
(29359, 43852, 17, 1, 0, 1, 1),
(29359, 35947, 7, 1, 0, 1, 1),
(29359, 33445, 4, 1, 0, 1, 1),
(29359, 40409, 1.5, 1, 1, 1, 1),
(29359, 40412, 1.5, 1, 1, 1, 1),
(29359, 40407, 1.5, 1, 1, 1, 1),
(29359, 40406, 1.5, 1, 1, 1, 1),
(29359, 40414, 1.5, 1, 1, 1, 1);


DELETE FROM `creature_loot_template` WHERE (`entry`=16025);
INSERT INTO `creature_loot_template` VALUES 
(16025, 33470, 33, 1, 0, 2, 7),
(16025, 43852, 17, 1, 0, 1, 1),
(16025, 35947, 7, 1, 0, 1, 1),
(16025, 33445, 4, 1, 0, 1, 1),
(16025, 33447, 2, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29371);
INSERT INTO `creature_loot_template` VALUES 
(29371, 33470, 33, 1, 0, 2, 7),
(29371, 43852, 17, 1, 0, 1, 1),
(29371, 35947, 7, 1, 0, 1, 1),
(29371, 33445, 4, 1, 0, 1, 1),
(29371, 33447, 2, 1, 0, 1, 1),
(29371, 40409, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=30071);
INSERT INTO `creature_loot_template` VALUES 
(30071, 33470, 33, 1, 0, 2, 7),
(30071, 43852, 17, 1, 0, 1, 1),
(30071, 35947, 7, 1, 0, 1, 1),
(30071, 33445, 4, 1, 0, 1, 1),
(30071, 33447, 2, 1, 0, 1, 1),
(30071, 40409, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=30075);
INSERT INTO `creature_loot_template` VALUES 
(30075, 33470, 33, 1, 0, 2, 7),
(30075, 43852, 17, 1, 0, 1, 1),
(30075, 35947, 7, 1, 0, 1, 1),
(30075, 33445, 4, 1, 0, 1, 1),
(30075, 40412, 1.5, 1, 1, 1, 1),
(30075, 40406, 1.5, 1, 1, 1, 1),
(30075, 40408, 1.5, 1, 1, 1, 1),
(30075, 40407, 1.5, 1, 1, 1, 1),
(30075, 40410, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16146);
INSERT INTO `creature_loot_template` VALUES 
(16146, 33470, 33, 1, 0, 2, 7),
(16146, 43852, 17, 1, 0, 1, 1),
(16146, 35947, 7, 1, 0, 1, 1),
(16146, 33445, 4, 1, 0, 1, 1),
(16146, 33447, 2, 1, 0, 1, 1),
(16146, 40409, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29823);
INSERT INTO `creature_loot_template` VALUES 
(29823, 33470, 33, 1, 0, 2, 7),
(29823, 43852, 17, 1, 0, 1, 1),
(29823, 35947, 7, 1, 0, 1, 1),
(29823, 33445, 4, 1, 0, 1, 1),
(29823, 33447, 2, 1, 0, 1, 1),
(29823, 40406, 1.5, 1, 2, 1, 1),
(29823, 40412, 1.5, 1, 2, 1, 1),
(29823, 40414, 1.5, 1, 2, 1, 1),
(29823, 40409, 1.5, 1, 2, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16165);
INSERT INTO `creature_loot_template` VALUES 
(16165, 33470, 33, 1, 0, 2, 7),
(16165, 43852, 17, 1, 0, 1, 1),
(16165, 35947, 7, 1, 0, 1, 1),
(16165, 33445, 4, 1, 0, 1, 1),
(16165, 33447, 2, 1, 0, 1, 1),
(16165, 40409, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29828);
INSERT INTO `creature_loot_template` VALUES 
(29828, 33470, 33, 1, 0, 2, 7),
(29828, 43852, 17, 1, 0, 1, 1),
(29828, 35947, 7, 1, 0, 1, 1),
(29828, 33445, 4, 1, 0, 1, 1),
(29828, 33447, 2, 1, 0, 1, 1),
(29828, 40408, 1.5, 1, 2, 1, 1),
(29828, 40412, 1.5, 1, 2, 1, 1),
(29828, 40414, 1.5, 1, 2, 1, 1),
(29828, 40407, 1.5, 1, 2, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16164);
INSERT INTO `creature_loot_template` VALUES 
(16164, 33470, 33, 1, 0, 2, 7),
(16164, 43852, 17, 1, 0, 1, 1),
(16164, 35947, 7, 1, 0, 1, 1),
(16164, 33445, 4, 1, 0, 1, 1),
(16164, 33447, 2, 1, 0, 1, 1),
(16164, 40409, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29825);
INSERT INTO `creature_loot_template` VALUES 
(29825, 33470, 33, 1, 0, 2, 7),
(29825, 43852, 17, 1, 0, 1, 1),
(29825, 35947, 7, 1, 0, 1, 1),
(29825, 33445, 4, 1, 0, 1, 1),
(29825, 33447, 2, 1, 0, 1, 1),
(29825, 40409, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16145);
INSERT INTO `creature_loot_template` VALUES 
(16145, 33470, 33, 1, 0, 2, 7),
(16145, 43852, 17, 1, 0, 1, 1),
(16145, 35947, 7, 1, 0, 1, 1),
(16145, 33445, 4, 1, 0, 1, 1),
(16145, 33447, 2, 1, 0, 1, 1),
(16145, 40409, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29824);
INSERT INTO `creature_loot_template` VALUES 
(29824, 33470, 33, 1, 0, 2, 7),
(29824, 43852, 17, 1, 0, 1, 1),
(29824, 35947, 7, 1, 0, 1, 1),
(29824, 33445, 4, 1, 0, 1, 1),
(29824, 33447, 2, 1, 0, 1, 1),
(29824, 40408, 1.5, 1, 2, 1, 1),
(29824, 40412, 1.5, 1, 2, 1, 1),
(29824, 40414, 1.5, 1, 2, 1, 1),
(29824, 40410, 1.5, 1, 2, 1, 1),
(29824, 40407, 1.5, 1, 2, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16167);
INSERT INTO `creature_loot_template` VALUES 
(16167, 33470, 33, 1, 0, 2, 7),
(16167, 43852, 17, 1, 0, 1, 1),
(16167, 35947, 7, 1, 0, 1, 1),
(16167, 33445, 4, 1, 0, 1, 1),
(16167, 33447, 2, 1, 0, 1, 1),
(16167, 33448, 1.5, 1, 0, 1, 1),
(16167, 39427, 1.1, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29835);
INSERT INTO `creature_loot_template` VALUES 
(29835, 33470, 33, 1, 0, 2, 7),
(29835, 43852, 17, 1, 0, 1, 1),
(29835, 35947, 7, 1, 0, 1, 1),
(29835, 33445, 4, 1, 0, 1, 1),
(29835, 33447, 2, 1, 0, 1, 1),
(29835, 33448, 1.5, 1, 0, 1, 1),
(29835, 40407, 1.1, 1, 0, 1, 1),
(29835, 40410, 1.1, 1, 0, 1, 1),
(29835, 40406, 1.1, 1, 0, 1, 1),
(29835, 43510, 1.1, 1, 0, 1, 1),
(29835, 39152, 1.1, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16193);
INSERT INTO `creature_loot_template` VALUES 
(16193, 33470, 33, 1, 0, 2, 7),
(16193, 43852, 17, 1, 0, 1, 1),
(16193, 35947, 7, 1, 0, 1, 1),
(16193, 33445, 4, 1, 0, 1, 1),
(16193, 33447, 2, 1, 0, 1, 1),
(16193, 40409, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29837);
INSERT INTO `creature_loot_template` VALUES 
(29837, 33470, 33, 1, 0, 2, 7),
(29837, 43852, 17, 1, 0, 1, 1),
(29837, 35947, 7, 1, 0, 1, 1),
(29837, 33445, 4, 1, 0, 1, 1),
(29837, 33447, 2, 1, 0, 1, 1),
(29837, 40408, 1.5, 1, 2, 1, 1),
(29837, 40412, 1.5, 1, 2, 1, 1),
(29837, 40414, 1.5, 1, 2, 1, 1),
(29837, 40410, 1.5, 1, 2, 1, 1),
(29837, 40407, 1.5, 1, 2, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16163);
INSERT INTO `creature_loot_template` VALUES 
(16163, 33470, 33, 1, 0, 2, 7),
(16163, 43852, 17, 1, 0, 1, 1),
(16163, 35947, 7, 1, 0, 1, 1),
(16163, 33445, 4, 1, 0, 1, 1),
(16163, 33447, 2, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29842);
INSERT INTO `creature_loot_template` VALUES 
(29842, 33470, 33, 1, 0, 2, 7),
(29842, 43852, 17, 1, 0, 1, 1),
(29842, 35947, 7, 1, 0, 1, 1),
(29842, 33445, 4, 1, 0, 1, 1),
(29842, 33447, 2, 1, 0, 1, 1),
(29842, 40408, 1.5, 1, 2, 1, 1),
(29842, 40412, 1.5, 1, 2, 1, 1),
(29842, 40414, 1.5, 1, 2, 1, 1),
(29842, 40410, 1.5, 1, 2, 1, 1),
(29842, 40407, 1.5, 1, 2, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16067);
INSERT INTO `creature_loot_template` VALUES 
(16067, 33470, 33, 1, 0, 2, 7),
(16067, 43852, 17, 1, 0, 1, 1),
(16067, 35947, 7, 1, 0, 1, 1),
(16067, 33445, 4, 1, 0, 1, 1),
(16067, 39468, 1.5, 1, 0, 1, 1),
(16067, 33447, 2, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29852);
INSERT INTO `creature_loot_template` VALUES 
(29852, 33470, 33, 1, 0, 2, 7),
(29852, 43852, 17, 1, 0, 1, 1),
(29852, 35947, 7, 1, 0, 1, 1),
(29852, 33445, 4, 1, 0, 1, 1),
(29852, 39468, 1.5, 1, 0, 1, 1),
(29852, 33447, 2, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16154);
INSERT INTO `creature_loot_template` VALUES 
(16154, 33470, 33, 1, 0, 2, 7),
(16154, 43852, 17, 1, 0, 1, 1),
(16154, 35947, 7, 1, 0, 1, 1),
(16154, 33445, 4, 1, 0, 1, 1),
(16154, 39467, 1.5, 1, 1, 1, 1),
(16154, 39472, 1.5, 1, 1, 1, 1),
(16154, 33447, 2, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29831);
INSERT INTO `creature_loot_template` VALUES 
(29831, 33470, 33, 1, 0, 2, 7),
(29831, 43852, 17, 1, 0, 1, 1),
(29831, 35947, 7, 1, 0, 1, 1),
(29831, 33445, 4, 1, 0, 1, 1),
(29831, 40408, 1.5, 1, 1, 1, 1),
(29831, 40407, 1.5, 1, 1, 1, 1),
(29831, 40410, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16194);
INSERT INTO `creature_loot_template` VALUES 
(16194, 33470, 33, 1, 0, 2, 7),
(16194, 43852, 17, 1, 0, 1, 1),
(16194, 35947, 7, 1, 0, 1, 1),
(16194, 33445, 4, 1, 0, 1, 1),
(16194, 33447, 2, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29898);
INSERT INTO `creature_loot_template` VALUES 
(29898, 33470, 33, 1, 0, 2, 7),
(29898, 43852, 17, 1, 0, 1, 1),
(29898, 35947, 7, 1, 0, 1, 1),
(29898, 33445, 4, 1, 0, 1, 1),
(29898, 33447, 2, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16215);
INSERT INTO `creature_loot_template` VALUES 
(16215, 33470, 33, 1, 0, 2, 7),
(16215, 43852, 17, 1, 0, 1, 1),
(16215, 35947, 7, 1, 0, 1, 1),
(16215, 33445, 4, 1, 0, 1, 1),
(16215, 33447, 2, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29899);
INSERT INTO `creature_loot_template` VALUES 
(29899, 33470, 33, 1, 0, 2, 7),
(29899, 43852, 17, 1, 0, 1, 1),
(29899, 35947, 7, 1, 0, 1, 1),
(29899, 33445, 4, 1, 0, 1, 1),
(29899, 33447, 2, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16216);
INSERT INTO `creature_loot_template` VALUES 
(16216, 33470, 33, 1, 0, 2, 7),
(16216, 43852, 17, 1, 0, 1, 1),
(16216, 35947, 7, 1, 0, 1, 1),
(16216, 33445, 4, 1, 0, 1, 1),
(16216, 33447, 2, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29900);
INSERT INTO `creature_loot_template` VALUES 
(29900, 33470, 33, 1, 0, 2, 7),
(29900, 43852, 17, 1, 0, 1, 1),
(29900, 35947, 7, 1, 0, 1, 1),
(29900, 33445, 4, 1, 0, 1, 1),
(29900, 33447, 2, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=15974);
INSERT INTO `creature_loot_template` VALUES 
(15974, 44758, 70, 1, 0, 2, 4),
(15974, 42253, 30, 1, 1, 1, 3),
(15974, 44759, 15, 1, 0, 2, 3);

DELETE FROM `creature_loot_template` WHERE (`entry`=29242);
INSERT INTO `creature_loot_template` VALUES 
(29242, 44758, 70, 1, 0, 2, 4),
(29242, 42253, 30, 1, 1, 1, 3),
(29242, 44759, 15, 1, 0, 2, 3);

DELETE FROM `creature_loot_template` WHERE (`entry`=15975);
INSERT INTO `creature_loot_template` VALUES 
(15975, 44758, 70, 1, 0, 2, 4),
(15975, 42253, 30, 1, 1, 1, 3),
(15975, 44759, 15, 1, 0, 2, 3);

DELETE FROM `creature_loot_template` WHERE (`entry`=29241);
INSERT INTO `creature_loot_template` VALUES 
(29241, 44758, 70, 1, 0, 2, 4),
(29241, 42253, 30, 1, 1, 1, 3),
(29241, 44759, 15, 1, 0, 2, 3);

DELETE FROM `creature_loot_template` WHERE (`entry`=15976);
INSERT INTO `creature_loot_template` VALUES 
(15976, 44758, 70, 1, 0, 2, 4),
(15976, 42253, 30, 1, 1, 1, 3),
(15976, 44759, 15, 1, 0, 2, 3);

DELETE FROM `creature_loot_template` WHERE (`entry`=29243);
INSERT INTO `creature_loot_template` VALUES 
(29243, 44758, 70, 1, 0, 2, 4),
(29243, 42253, 30, 1, 1, 1, 3),
(29243, 44759, 15, 1, 0, 2, 3);

DELETE FROM `creature_loot_template` WHERE (`entry`=15978);
INSERT INTO `creature_loot_template` VALUES 
(15978, 44758, 70, 1, 0, 2, 4),
(15978, 44759, 15, 1, 0, 2, 3);

DELETE FROM `creature_loot_template` WHERE (`entry`=30389);
INSERT INTO `creature_loot_template` VALUES 
(30389, 44758, 70, 1, 0, 2, 4),
(30389, 44759, 15, 1, 0, 2, 3);

DELETE FROM `creature_loot_template` WHERE (`entry`=15980);
INSERT INTO `creature_loot_template` VALUES 
(15980, 33470, 40, 1, 0, 2, 7),
(15980, 43852, 17, 1, 0, 1, 1),
(15980, 35947, 7, 1, 0, 1, 1),
(15980, 33445, 4, 1, 0, 1, 1),
(15980, 33447, 2, 1, 0, 1, 1),
(15980, 39470, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29247);
INSERT INTO `creature_loot_template` VALUES 
(29247, 33470, 40, 1, 0, 2, 7),
(29247, 43852, 17, 1, 0, 1, 1),
(29247, 35947, 7, 1, 0, 1, 1),
(29247, 33445, 4, 1, 0, 1, 1),
(29247, 33447, 2, 1, 0, 1, 1),
(29247, 39470, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=15981);
INSERT INTO `creature_loot_template` VALUES 
(15981, 33470, 40, 1, 0, 2, 7),
(15981, 43852, 17, 1, 0, 1, 1),
(15981, 35947, 7, 1, 0, 1, 1),
(15981, 33445, 4, 1, 0, 1, 1),
(15981, 33447, 2, 1, 0, 1, 1),
(15981, 39470, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29248);
INSERT INTO `creature_loot_template` VALUES 
(29248, 33470, 40, 1, 0, 2, 7),
(29248, 43852, 17, 1, 0, 1, 1),
(29248, 35947, 7, 1, 0, 1, 1),
(29248, 33445, 4, 1, 0, 1, 1),
(29248, 33447, 2, 1, 0, 1, 1),
(29248, 39470, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=15979);
INSERT INTO `creature_loot_template` VALUES 
(15979, 44758, 70, 1, 0, 2, 4),
(15979, 44759, 15, 1, 0, 2, 3);

DELETE FROM `creature_loot_template` WHERE (`entry`=29286);
INSERT INTO `creature_loot_template` VALUES 
(29286, 44758, 70, 1, 0, 2, 4),
(29286, 44759, 15, 1, 0, 2, 3);

DELETE FROM `creature_loot_template` WHERE (`entry`=16244);
INSERT INTO `creature_loot_template` VALUES 
(16244, 33470, 40, 1, 0, 2, 7),
(16244, 43852, 17, 1, 0, 1, 1),
(16244, 35947, 7, 1, 0, 1, 1),
(16244, 33445, 4, 1, 0, 1, 1),
(16244, 33447, 2, 1, 0, 1, 1),
(16244, 39470, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29574);
INSERT INTO `creature_loot_template` VALUES 
(29574, 33470, 33, 1, 0, 2, 7),
(29574, 43852, 17, 1, 0, 1, 1),
(29574, 35947, 7, 1, 0, 1, 1),
(29574, 33445, 4, 1, 0, 1, 1),
(29574, 40412, 1.5, 1, 1, 1, 1),
(29574, 40409, 1.5, 1, 1, 1, 1),
(29574, 40414, 1.5, 1, 1, 1, 1),
(29574, 40410, 1.5, 1, 1, 1, 1),
(29574, 40406, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16243);
INSERT INTO `creature_loot_template` VALUES 
(16243, 33470, 40, 1, 0, 2, 7),
(16243, 43852, 17, 1, 0, 1, 1),
(16243, 35947, 7, 1, 0, 1, 1),
(16243, 33445, 4, 1, 0, 1, 1),
(16243, 33447, 2, 1, 0, 1, 1),
(16243, 39470, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29575);
INSERT INTO `creature_loot_template` VALUES 
(29575, 33470, 33, 1, 0, 2, 7),
(29575, 43852, 17, 1, 0, 1, 1),
(29575, 35947, 7, 1, 0, 1, 1),
(29575, 33445, 4, 1, 0, 1, 1),
(29575, 40412, 1.5, 1, 1, 1, 1),
(29575, 40409, 1.5, 1, 1, 1, 1),
(29575, 40414, 1.5, 1, 1, 1, 1),
(29575, 40410, 1.5, 1, 1, 1, 1),
(29575, 40406, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16168);
INSERT INTO `creature_loot_template` VALUES 
(16168, 33470, 40, 1, 0, 2, 7),
(16168, 43852, 17, 1, 0, 1, 1),
(16168, 35947, 7, 1, 0, 1, 1),
(16168, 33445, 4, 1, 0, 1, 1),
(16168, 33447, 2, 1, 0, 1, 1),
(16168, 39470, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29576);
INSERT INTO `creature_loot_template` VALUES 
(29576, 33470, 33, 1, 0, 2, 7),
(29576, 43852, 17, 1, 0, 1, 1),
(29576, 35947, 7, 1, 0, 1, 1),
(29576, 33445, 4, 1, 0, 1, 1),
(29576, 40412, 1.5, 1, 1, 1, 1),
(29576, 40409, 1.5, 1, 1, 1, 1),
(29576, 40414, 1.5, 1, 1, 1, 1),
(29576, 40410, 1.5, 1, 1, 1, 1),
(29576, 40406, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16297);
INSERT INTO `creature_loot_template` VALUES 
(16297, 33470, 40, 1, 0, 2, 7),
(16297, 43852, 17, 1, 0, 1, 1),
(16297, 35947, 7, 1, 0, 1, 1),
(16297, 33445, 4, 1, 0, 1, 1),
(16297, 33447, 2, 1, 0, 1, 1),
(16297, 39470, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29601);
INSERT INTO `creature_loot_template` VALUES 
(29601, 33470, 33, 1, 0, 2, 7),
(29601, 43852, 17, 1, 0, 1, 1),
(29601, 35947, 7, 1, 0, 1, 1),
(29601, 33445, 4, 1, 0, 1, 1),
(29601, 40412, 1.5, 1, 1, 1, 1),
(29601, 40409, 1.5, 1, 1, 1, 1),
(29601, 40414, 1.5, 1, 1, 1, 1),
(29601, 40410, 1.5, 1, 1, 1, 1),
(29601, 40406, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16036);
INSERT INTO `creature_loot_template` VALUES 
(16036, 33470, 40, 1, 0, 2, 7),
(16036, 43852, 17, 1, 0, 1, 1),
(16036, 35947, 7, 1, 0, 1, 1),
(16036, 33445, 4, 1, 0, 1, 1),
(16036, 33447, 2, 1, 0, 1, 1),
(16036, 39470, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29608);
INSERT INTO `creature_loot_template` VALUES 
(29608, 33470, 33, 1, 0, 2, 7),
(29608, 43852, 17, 1, 0, 1, 1),
(29608, 35947, 7, 1, 0, 1, 1),
(29608, 33445, 4, 1, 0, 1, 1),
(29608, 40412, 1.5, 1, 1, 1, 1),
(29608, 40409, 1.5, 1, 1, 1, 1),
(29608, 40414, 1.5, 1, 1, 1, 1),
(29608, 40410, 1.5, 1, 1, 1, 1),
(29608, 40406, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=16034);
INSERT INTO `creature_loot_template` VALUES 
(16034, 33470, 40, 1, 0, 2, 7),
(16034, 43852, 17, 1, 0, 1, 1),
(16034, 35947, 7, 1, 0, 1, 1),
(16034, 33445, 4, 1, 0, 1, 1),
(16034, 33447, 2, 1, 0, 1, 1),
(16034, 39470, 1.5, 1, 1, 1, 1);

DELETE FROM `creature_loot_template` WHERE (`entry`=29609);
INSERT INTO `creature_loot_template` VALUES 
(29609, 33470, 33, 1, 0, 2, 7),
(29609, 43852, 17, 1, 0, 1, 1),
(29609, 35947, 7, 1, 0, 1, 1),
(29609, 33445, 4, 1, 0, 1, 1);

DELETE FROM `creature_ai_scripts` WHERE (`id`=16427020);
INSERT INTO `creature_ai_scripts` VALUES 
(16427020, 16236, 0, 0, 100, 3, 1000, 3000, 3000, 6000, 11, 29407, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Spell N');
DELETE FROM `creature_ai_scripts` WHERE (`id`=16427021);
INSERT INTO `creature_ai_scripts` VALUES 
(16427021, 16236, 0, 0, 100, 5, 1000, 3000, 3000, 6000, 11, 54805, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Spell H');

DELETE FROM `creature_loot_template` WHERE `item` IN (39467, 39472, 39470, 39427, 39468, 39473);
INSERT INTO `creature_loot_template` VALUES 
(16017, 39467, 1.5, 1, 1, 1, 1),
(16017, 39472, 1.5, 1, 1, 1, 1),
(16017, 39470, 1.5, 1, 1, 1, 1),
(16017, 39427, 1.5, 1, 1, 1, 1),
(16017, 39468, 1.5, 1, 1, 1, 1),
(16017, 39473, 1.5, 1, 1, 1, 1),
(16018, 39467, 1.5, 1, 1, 1, 1),
(16018, 39472, 1.5, 1, 1, 1, 1),
(16018, 39470, 1.5, 1, 1, 1, 1),
(16018, 39427, 1.5, 1, 1, 1, 1),
(16018, 39468, 1.5, 1, 1, 1, 1),
(16018, 39473, 1.5, 1, 1, 1, 1),
(16029, 39467, 1.5, 1, 1, 1, 1),
(16029, 39472, 1.5, 1, 1, 1, 1),
(16029, 39470, 1.5, 1, 1, 1, 1),
(16029, 39427, 1.5, 1, 1, 1, 1),
(16029, 39468, 1.5, 1, 1, 1, 1),
(16029, 39473, 1.5, 1, 1, 1, 1),
(16020, 39467, 1.5, 1, 1, 1, 1),
(16020, 39472, 1.5, 1, 1, 1, 1),
(16020, 39470, 1.5, 1, 1, 1, 1),
(16020, 39427, 1.5, 1, 1, 1, 1),
(16020, 39468, 1.5, 1, 1, 1, 1),
(16020, 39473, 1.5, 1, 1, 1, 1),
(16021, 39467, 1.5, 1, 1, 1, 1),
(16021, 39472, 1.5, 1, 1, 1, 1),
(16021, 39470, 1.5, 1, 1, 1, 1),
(16021, 39427, 1.5, 1, 1, 1, 1),
(16021, 39468, 1.5, 1, 1, 1, 1),
(16021, 39473, 1.5, 1, 1, 1, 1),
(16025, 39467, 1.5, 1, 1, 1, 1),
(16025, 39472, 1.5, 1, 1, 1, 1),
(16025, 39470, 1.5, 1, 1, 1, 1),
(16025, 39427, 1.5, 1, 1, 1, 1),
(16025, 39468, 1.5, 1, 1, 1, 1),
(16025, 39473, 1.5, 1, 1, 1, 1),
(30071, 39467, 1.5, 1, 1, 1, 1),
(30071, 39472, 1.5, 1, 1, 1, 1),
(30071, 39470, 1.5, 1, 1, 1, 1),
(30071, 39427, 1.5, 1, 1, 1, 1),
(30071, 39468, 1.5, 1, 1, 1, 1),
(30071, 39473, 1.5, 1, 1, 1, 1),
(16146, 39467, 1.5, 1, 1, 1, 1),
(16146, 39472, 1.5, 1, 1, 1, 1),
(16146, 39470, 1.5, 1, 1, 1, 1),
(16146, 39427, 1.5, 1, 1, 1, 1),
(16146, 39468, 1.5, 1, 1, 1, 1),
(16146, 39473, 1.5, 1, 1, 1, 1),
(16165, 39467, 1.5, 1, 1, 1, 1),
(16165, 39472, 1.5, 1, 1, 1, 1),
(16165, 39470, 1.5, 1, 1, 1, 1),
(16165, 39427, 1.5, 1, 1, 1, 1),
(16165, 39468, 1.5, 1, 1, 1, 1),
(16165, 39473, 1.5, 1, 1, 1, 1),
(16164, 39467, 1.5, 1, 1, 1, 1),
(16164, 39472, 1.5, 1, 1, 1, 1),
(16164, 39470, 1.5, 1, 1, 1, 1),
(16164, 39427, 1.5, 1, 1, 1, 1),
(16164, 39468, 1.5, 1, 1, 1, 1),
(16164, 39473, 1.5, 1, 1, 1, 1),
(16145, 39467, 1.5, 1, 1, 1, 1),
(16145, 39472, 1.5, 1, 1, 1, 1),
(16145, 39470, 1.5, 1, 1, 1, 1),
(16145, 39427, 1.5, 1, 1, 1, 1),
(16145, 39468, 1.5, 1, 1, 1, 1),
(16145, 39473, 1.5, 1, 1, 1, 1),
(16167, 39467, 1.5, 1, 1, 1, 1),
(16167, 39472, 1.5, 1, 1, 1, 1),
(16167, 39470, 1.5, 1, 1, 1, 1),
(16167, 39427, 1.5, 1, 1, 1, 1),
(16167, 39468, 1.5, 1, 1, 1, 1),
(16167, 39473, 1.5, 1, 1, 1, 1),
(16193, 39467, 1.5, 1, 1, 1, 1),
(16193, 39472, 1.5, 1, 1, 1, 1),
(16193, 39470, 1.5, 1, 1, 1, 1),
(16193, 39427, 1.5, 1, 1, 1, 1),
(16193, 39468, 1.5, 1, 1, 1, 1),
(16193, 39473, 1.5, 1, 1, 1, 1),
(16163, 39467, 1.5, 1, 1, 1, 1),
(16163, 39472, 1.5, 1, 1, 1, 1),
(16163, 39470, 1.5, 1, 1, 1, 1),
(16163, 39427, 1.5, 1, 1, 1, 1),
(16163, 39468, 1.5, 1, 1, 1, 1),
(16163, 39473, 1.5, 1, 1, 1, 1),
(16067, 39467, 1.5, 1, 1, 1, 1),
(16067, 39472, 1.5, 1, 1, 1, 1),
(16067, 39470, 1.5, 1, 1, 1, 1),
(16067, 39427, 1.5, 1, 1, 1, 1),
(16067, 39468, 1.5, 1, 1, 1, 1),
(16067, 39473, 1.5, 1, 1, 1, 1),
(16154, 39467, 1.5, 1, 1, 1, 1),
(16154, 39472, 1.5, 1, 1, 1, 1),
(16154, 39470, 1.5, 1, 1, 1, 1),
(16154, 39427, 1.5, 1, 1, 1, 1),
(16154, 39468, 1.5, 1, 1, 1, 1),
(16154, 39473, 1.5, 1, 1, 1, 1),
(16194, 39467, 1.5, 1, 1, 1, 1),
(16194, 39472, 1.5, 1, 1, 1, 1),
(16194, 39470, 1.5, 1, 1, 1, 1),
(16194, 39427, 1.5, 1, 1, 1, 1),
(16194, 39468, 1.5, 1, 1, 1, 1),
(16194, 39473, 1.5, 1, 1, 1, 1),
(16215, 39467, 1.5, 1, 1, 1, 1),
(16215, 39472, 1.5, 1, 1, 1, 1),
(16215, 39470, 1.5, 1, 1, 1, 1),
(16215, 39427, 1.5, 1, 1, 1, 1),
(16215, 39468, 1.5, 1, 1, 1, 1),
(16215, 39473, 1.5, 1, 1, 1, 1),
(16216, 39467, 1.5, 1, 1, 1, 1),
(16216, 39472, 1.5, 1, 1, 1, 1),
(16216, 39470, 1.5, 1, 1, 1, 1),
(16216, 39427, 1.5, 1, 1, 1, 1),
(16216, 39468, 1.5, 1, 1, 1, 1),
(16216, 39473, 1.5, 1, 1, 1, 1),
(15974, 39467, 1.5, 1, 1, 1, 1),
(15974, 39472, 1.5, 1, 1, 1, 1),
(15974, 39470, 1.5, 1, 1, 1, 1),
(15974, 39427, 1.5, 1, 1, 1, 1),
(15974, 39468, 1.5, 1, 1, 1, 1),
(15974, 39473, 1.5, 1, 1, 1, 1),
(15975, 39467, 1.5, 1, 1, 1, 1),
(15975, 39472, 1.5, 1, 1, 1, 1),
(15975, 39470, 1.5, 1, 1, 1, 1),
(15975, 39427, 1.5, 1, 1, 1, 1),
(15975, 39468, 1.5, 1, 1, 1, 1),
(15975, 39473, 1.5, 1, 1, 1, 1),
(15976, 39467, 1.5, 1, 1, 1, 1),
(15976, 39472, 1.5, 1, 1, 1, 1),
(15976, 39470, 1.5, 1, 1, 1, 1),
(15976, 39427, 1.5, 1, 1, 1, 1),
(15976, 39468, 1.5, 1, 1, 1, 1),
(15976, 39473, 1.5, 1, 1, 1, 1),
(15978, 39467, 1.5, 1, 1, 1, 1),
(15978, 39472, 1.5, 1, 1, 1, 1),
(15978, 39470, 1.5, 1, 1, 1, 1),
(15978, 39427, 1.5, 1, 1, 1, 1),
(15978, 39468, 1.5, 1, 1, 1, 1),
(15978, 39473, 1.5, 1, 1, 1, 1),
(15980, 39467, 1.5, 1, 1, 1, 1),
(15980, 39472, 1.5, 1, 1, 1, 1),
(15980, 39470, 1.5, 1, 1, 1, 1),
(15980, 39427, 1.5, 1, 1, 1, 1),
(15980, 39468, 1.5, 1, 1, 1, 1),
(15980, 39473, 1.5, 1, 1, 1, 1),
(15981, 39467, 1.5, 1, 1, 1, 1),
(15981, 39472, 1.5, 1, 1, 1, 1),
(15981, 39470, 1.5, 1, 1, 1, 1),
(15981, 39427, 1.5, 1, 1, 1, 1),
(15981, 39468, 1.5, 1, 1, 1, 1),
(15981, 39473, 1.5, 1, 1, 1, 1),
(15979, 39467, 1.5, 1, 1, 1, 1),
(15979, 39472, 1.5, 1, 1, 1, 1),
(15979, 39470, 1.5, 1, 1, 1, 1),
(15979, 39427, 1.5, 1, 1, 1, 1),
(15979, 39468, 1.5, 1, 1, 1, 1),
(15979, 39473, 1.5, 1, 1, 1, 1),
(16244, 39467, 1.5, 1, 1, 1, 1),
(16244, 39472, 1.5, 1, 1, 1, 1),
(16244, 39470, 1.5, 1, 1, 1, 1),
(16244, 39427, 1.5, 1, 1, 1, 1),
(16244, 39468, 1.5, 1, 1, 1, 1),
(16244, 39473, 1.5, 1, 1, 1, 1),
(16243, 39467, 1.5, 1, 1, 1, 1),
(16243, 39472, 1.5, 1, 1, 1, 1),
(16243, 39470, 1.5, 1, 1, 1, 1),
(16243, 39427, 1.5, 1, 1, 1, 1),
(16243, 39468, 1.5, 1, 1, 1, 1),
(16243, 39473, 1.5, 1, 1, 1, 1),
(16168, 39467, 1.5, 1, 1, 1, 1),
(16168, 39472, 1.5, 1, 1, 1, 1),
(16168, 39470, 1.5, 1, 1, 1, 1),
(16168, 39427, 1.5, 1, 1, 1, 1),
(16168, 39468, 1.5, 1, 1, 1, 1),
(16168, 39473, 1.5, 1, 1, 1, 1),
(16297, 39467, 1.5, 1, 1, 1, 1),
(16297, 39472, 1.5, 1, 1, 1, 1),
(16297, 39470, 1.5, 1, 1, 1, 1),
(16297, 39427, 1.5, 1, 1, 1, 1),
(16297, 39468, 1.5, 1, 1, 1, 1),
(16297, 39473, 1.5, 1, 1, 1, 1),
(16036, 39467, 1.5, 1, 1, 1, 1),
(16036, 39472, 1.5, 1, 1, 1, 1),
(16036, 39470, 1.5, 1, 1, 1, 1),
(16036, 39427, 1.5, 1, 1, 1, 1),
(16036, 39468, 1.5, 1, 1, 1, 1),
(16036, 39473, 1.5, 1, 1, 1, 1),
(16034, 39467, 1.5, 1, 1, 1, 1),
(16034, 39472, 1.5, 1, 1, 1, 1),
(16034, 39470, 1.5, 1, 1, 1, 1),
(16034, 39427, 1.5, 1, 1, 1, 1),
(16034, 39468, 1.5, 1, 1, 1, 1),
(16034, 39473, 1.5, 1, 1, 1, 1);



-- http://www.wowhead.com/npc=16211
UPDATE `creature_template` SET `unit_flags` = 131074 WHERE `entry` = 16211;


-- some scripts_ai
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=29256);
INSERT INTO `creature_ai_scripts` VALUES 
( 100000100, 29256, 0, 0, 100, 2, 0, 0, 0, 0, 11, 28969, 4, 32, 0, 0, 0, 0, 0, 0, 0, 0, 'Crypt Guard (Normal) - Cast Acid Spit on Aggro'),
( 100000101, 29256, 0, 0, 100, 4, 0, 0, 0, 0, 11, 56098, 4, 32, 0, 0, 0, 0, 0, 0, 0, 0, 'Crypt Guard (Heroic) - Cast Acid Spit on Aggro'),
( 100000102, 29256, 0, 0, 100, 3, 4000, 6000, 4000, 7000, 11, 28969, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crypt Guard (Normal) - Cast Acid Spit'),
( 100000104, 29256, 0, 0, 100, 5, 4000, 6000, 4000, 7000, 11, 56098, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crypt Guard (Heroic) - Cast Acid Spit'),
( 100000105, 29256, 0, 0, 100, 7, 7000, 9000, 7000, 9000, 11, 40504, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crypt Guard - Cast Cleave'),
( 100000106, 29256, 2, 0, 100, 7, 30, 0, 120000, 120000, 11, 8269, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crypt Guard - Cast Frenzy at 30% HP'),
(100000107, 29256, 6, 0, 100, 0, 0, 0, 0, 0, 11, 28864, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crypt Guard - Summon Corpse Scarabs');

UPDATE `creature_template` SET `spell1` = 55765, `AIName` = 'EventAI' WHERE `entry` = 16429;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=16429);
INSERT INTO `creature_ai_scripts` VALUES 
(100000108, 16429, 9, 0, 100, 3, 0, 3, 500, 1000, 11, 55765, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Wail of Souls - Normal'),
(100000109, 16429, 9, 0, 100, 5, 0, 3, 500, 1000, 11, 55765, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Wail of Souls - Hero');


UPDATE `creature_template` SET `spell1` = 28457, `AIName` = 'EventAI', `spell2` = 55714 WHERE `entry` = 16427;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=16427);
INSERT INTO `creature_ai_scripts` VALUES 
(100000110, 16427, 9, 0, 100, 3, 0, 3, 0, 0, 11, 28457, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Explode - Normal'),
(100000111, 16427, 9, 0, 100, 5, 0, 3, 0, 0, 11, 55714, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Explode - Hero');

--
-- Obsidian Sanctum
--
UPDATE `instance_template` SET `script`='instance_obsidian_sanctum' WHERE `map`=615;
UPDATE `creature_template` SET `ScriptName`='boss_sartharion' WHERE `entry`=28860;
UPDATE `creature_template` SET `ScriptName`='mob_vesperon' WHERE `entry`=30449;
UPDATE `creature_template` SET `ScriptName`='mob_shadron' WHERE `entry`=30451;
UPDATE `creature_template` SET `ScriptName`='mob_tenebron' WHERE `entry`=30452;
UPDATE `creature_template` SET `ScriptName`='mob_acolyte_of_shadron' WHERE `entry`=31218;
UPDATE `creature_template` SET `ScriptName`='mob_acolyte_of_vesperon' WHERE `entry`=31219;
-- flametsunami
UPDATE creature_template SET minlevel=83, maxlevel=83, faction_A=14, faction_H=14, unit_flags=0x02000000, flags_extra=0x00000002, ScriptName="npc_flame_tsunami" WHERE entry=30616;

UPDATE creature_template SET ScriptName="npc_twilight_fissure" WHERE entry=30641; 
UPDATE creature_template SET ScriptName="npc_flame_tsunami" WHERE entry=30616;

-- safezone flag
UPDATE creature_template SET flags_extra = 0x00000002 WHERE entry=30494;

-- sartharion door
UPDATE `gameobject_template` SET `flags` = 4 WHERE `entry` = 181247;


-- Add Twilight Portals
DELETE FROM gameobject WHERE id=193988;
INSERT INTO gameobject (id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES
(193988, 615, 3, 1, 3137.26, 501.08, 87.9118, 0.846795, 0, 0, 0.41086, 0.911698, -30, 0, 1),
(193988, 615, 3, 1, 3238.37, 518.595, 58.9057, 0.739184, 0, 0, 0.361235, 0.932475, -30, 0, 1),
(193988, 615, 3, 1, 3362.01, 553.726, 95.7068, 4.56818, 0, 0, 0.756211, -0.654328, -30, 0, 1),
(193988, 615, 3, 1, 3219.67, 656.795, 87.2898, 5.92596, 0, 0, 0.177664, -0.984091, 25, 0, 1);

-- Set creature data to creatures used in Sartharion encounter
UPDATE creature_template SET flags_extra = flags_extra | 2 WHERE entry = 31103; -- Twilight Egg (Cosmetic)
UPDATE creature_template SET unit_flags = unit_flags | 4, faction_A = 103, faction_H = 103, flags_extra = 2 WHERE entry = 30648; -- Fire Cyclone 
UPDATE creature SET spawndist = 0 WHERE id = 30648; -- Fire Cyclone
UPDATE creature_template SET ScriptName = 'npc_twilight_fissure' WHERE entry = 30641;
UPDATE creature_template SET ScriptName = 'npc_flame_tsunami' WHERE entry = 30616;
UPDATE creature_template SET ScriptName = 'mob_twilight_eggs' WHERE entry IN (30882, 31204);
UPDATE creature_template SET ScriptName = 'mob_twilight_whelp' WHERE entry IN (30890, 31540, 31214, 31548);
UPDATE creature_template SET faction_A = 103, faction_H = 103, minlevel = 81, maxlevel = 81, mindmg = 1857, maxdmg = 2703 WHERE entry IN (30890, 31214);
UPDATE creature_template SET faction_A = 103, faction_H = 103, minlevel = 81, maxlevel = 81, mindmg = 3032, maxdmg = 5194 WHERE entry IN (31540, 31548);
UPDATE creature_template SET faction_A = 103, faction_H = 103, minlevel = 81, maxlevel = 81 WHERE entry IN (30882, 31539); -- Twilight Egg
UPDATE creature_template SET faction_A = 103, faction_H = 103, minlevel = 81, maxlevel = 81 WHERE entry IN (31204, 31547); -- Sartharion Twilight Egg
UPDATE creature_template SET faction_A = 103, faction_H = 103, minlevel = 81, maxlevel = 81, flags_extra = 2, scale = 0.75 WHERE entry IN (30641, 31521); -- Twilight Fissure
UPDATE creature_template SET faction_A = 14, faction_H = 14, minlevel = 81, maxlevel = 81, mindmg = 693, maxdmg = 963, attackpower = 1567, dmg_multiplier = 1 WHERE entry = 30643; -- Lava Blaze
UPDATE creature_template SET faction_A = 14, faction_H = 14, minlevel = 81, maxlevel = 81, mindmg = 894, maxdmg = 1203, attackpower = 3134, dmg_multiplier = 1 WHERE entry = 31317; -- Lava Blaze (1)
UPDATE creature_template SET faction_A = 14, faction_H = 14, minlevel = 81, maxlevel = 81, flags_extra = 2 WHERE entry = 30616; -- Flame Tsunami
UPDATE creature_template SET faction_A = 103, faction_H = 103, mindmg = 409, maxdmg = 502, attackpower = 780, dmg_multiplier = 35, mechanic_immune_mask = 617299803, minlevel = 81, maxlevel = 81 WHERE entry IN (31218, 31219); -- Acolytes of Vesperon/Shandron
--  twilight fissure
UPDATE creature_template SET flags_extra = 0 WHERE entry IN (30641, 31521);
UPDATE creature_template SET modelid1 = 29038 WHERE entry IN (30641, 31521);

-- mob obsidian
UPDATE creature_template SET unit_flags = 33554434 WHERE entry IN (30641, 31521, 31103);

-- disciple of vesperon
UPDATE creature_template SET faction_H = 16, faction_A = 16, ScriptName = 'npc_disciple_of_vesperon' WHERE entry = 30858;
UPDATE gameobject SET spawntimesecs = -60 WHERE id = 193988;

UPDATE `instance_template` SET `script`='instance_oculus' WHERE `map`=578;
UPDATE `creature_template` SET `ScriptName`='npc_unstable_sphere' WHERE `entry`=28166;
UPDATE `creature_template` SET `ScriptName`='npc_oculus_drake' WHERE `entry` IN (27657,27658,27659);

-- Ruby drake
UPDATE creature_template SET spell1 = 50232, spell2 = 50248, spell3 = 50240, spell4 =  50253, spell5 = 53112, VehicleId = 70 WHERE entry = 27756;
-- Amber Drake
UPDATE creature_template SET spell1 = 49840, spell2 = 49838, spell3 = 49592, spell4 =  0, spell5 = 53112, VehicleId = 70 WHERE entry = 27755;
-- Emerald Drake
UPDATE creature_template SET spell1 = 50328, spell2 = 50341, spell3 = 50344, spell4 =  0, spell5 = 53112, VehicleId = 70 WHERE entry = 27692;
/*
UPDATE creature_template SET npcflag=1 WHERE entry IN (27657,27658,27659);
*/
UPDATE creature_template SET ScriptName='boss_drakos' WHERE entry = 27654;
UPDATE creature_template SET ScriptName='boss_urom' WHERE entry = 27655;
UPDATE creature_template SET ScriptName='mob_centrifige_construct' WHERE entry = 27641;
UPDATE creature_template SET ScriptName='boss_varos' WHERE entry = 27447;
UPDATE creature_template SET ScriptName='boss_eregos' WHERE entry = 27656;

-- Unstable Sphere
UPDATE creature_template SET minlevel = 80, maxlevel = 80, mindmg = 422, maxdmg = 586, faction_A = 16, faction_H = 16, attackpower = 642, dmg_multiplier = 1, minrangedmg = 345, maxrangedmg = 509, rangedattackpower = 103 WHERE entry = 28166;

-- Drakos the Interrogator
DELETE FROM `script_texts` WHERE npc_entry='27654';
INSERT INTO `script_texts` VALUES ('27654', -1578000, 'The prisoners shall not go free. The word of Malygos is law!','', '', '', '', '', '', '', '', 13594,1,0,0, 'drakos SAY_AGGRO');
INSERT INTO `script_texts` VALUES ('27654', -1578001, 'A fitting punishment!','', '', '', '', '', '', '', '', 13602, 1,0,0, 'drakos SAY_KILL_1');
INSERT INTO `script_texts` VALUES ('27654', -1578002, 'Sentence: executed!','', '', '', '', '', '', '', '', 13603,1,0,0, 'drakos SAY_KILL_2');
INSERT INTO `script_texts` VALUES ('27654', -1578003, 'Another casualty of war!','', '', '', '', '', '', '', '', 13604, 1,0,0, 'drakos SAY_KILL_3');
INSERT INTO `script_texts` VALUES ('27654', -1578004, 'The war... goes on.','', '', '', '', '', '', '', '', 13605,1,0,0,  'drakos SPELL_DEATH');
INSERT INTO `script_texts` VALUES ('27654', -1578005, 'It is too late to run!','', '', '', '', '', '', '', '', 13598, 1,0,0, 'drakos SAY_PULL_1');
INSERT INTO `script_texts` VALUES ('27654', -1578006, 'Gather \'round! ','', '', '', '', '', '', '', '', 13599, 1,0,0, 'drakos SAY_PULL_2');
INSERT INTO `script_texts` VALUES ('27654', -1578007, 'None shall escape!','', '', '', '', '', '', '', '', 13600, 1,0,0, 'drakos SAY_PULL_3');
INSERT INTO `script_texts` VALUES ('27654', -1578008, 'I condemn you to death!','', '', '', '', '', '', '', '', 13601,1,0,0,  'drakos SAY_PULL_4');
INSERT INTO `script_texts` VALUES ('27654', -1578009, 'Tremble, worms!','', '', '', '', '', '', '', '', 13595,1,0,0,  'drakos SAY_STOMP_1');
INSERT INTO `script_texts` VALUES ('27654', -1578010, 'I will crush you!', '', '', '', '', '', '', '', '', 13596, 1,0,0, 'drakos SAY_STOMP_2');
INSERT INTO `script_texts` VALUES ('27654', -1578011, 'Can you fly?', '', '', '', '', '', '', '', '', 13597, 1,0,0, 'drakos SAY_STOMP_3');

-- Mage-Lord Urom
DELETE FROM `script_texts` WHERE npc_entry= '27655';
INSERT INTO `script_texts` VALUES ('27655', -1578012, 'Poor blind fools!','', '', '', '', '', '', '', '', 13638,1,0,0, 'urom SAY_AGGRO');
INSERT INTO `script_texts` VALUES ('27655', -1578013, 'If only you understood!','', '', '', '', '', '', '', '', 13641,1,0,0, 'urom SAY_KILL_1');
INSERT INTO `script_texts` VALUES ('27655', -1578014, 'Now, do you see? DO YOU?!','', '', '', '', '', '', '', '', 13642,1,0,0, 'urom SAY_KILL_2');
INSERT INTO `script_texts` VALUES ('27655', -1578015, 'Unfortunate, but necessary.','', '', '', '', '', '', '', '', 13643,1,0,0, 'urom SAY_KILL_3');
INSERT INTO `script_texts` VALUES ('27655', -1578016, 'Everything I\'ve done... has been for Azeroth...','', '', '', '', '', '', '', '', 13644,1,0,0, 'urom SAY_DEATH');
INSERT INTO `script_texts` VALUES ('27655', -1578017, 'A taste... just a small taste... of the Spell-Weaver\'s power!','', '', '', '', '', '', '', '', 13639,1,0,0, 'urom SAY_EXPLOSION_1');
INSERT INTO `script_texts` VALUES ('27655', -1578018, 'So much unstable energy... but worth the risk to destroy you!','', '', '', '', '', '', '', '', 13640,1,0,0, 'urom SAY_EXPLOSION_2');
INSERT INTO `script_texts` VALUES ('27655', -1578019, 'What do we have here... those would defy the Spell-Weaver? Those without foresight or understanding. How could I make you see? Malygos is saving the world from itself! Bah! You are hardly worth my time!','', '', '', '', '', '', '', '', 13635,1,0,0, 'urom SAY_SUMMON_1');
INSERT INTO `script_texts` VALUES ('27655', -1578020, 'Clearly my pets failed. Perhaps another demonstration is in order.','', '', '', '', '', '', '', '', 13636,1,0,0, 'urom SAY_SUMMON_2');
INSERT INTO `script_texts` VALUES ('27655', -1578021, 'Still you fight. Still you cling to misguided principles. If you survive, you\'ll find me in the center ring.','', '', '', '', '', '', '', '', 13637,1,0,0, 'urom SAY_SUMMON_3');

-- Varos Cloudstrider
DELETE FROM `script_texts` WHERE npc_entry = '27447';
INSERT INTO `script_texts` VALUES ('27447', -1578022, 'There will be no mercy!','', '', '', '', '', '', '', '', 13649,1,0,0, 'varos SAY_AGGRO');
INSERT INTO `script_texts` VALUES ('27447', -1578023, 'You were warned.','', '', '', '', '', '', '', '', 13653,1,0,0, 'varos SAY_KILL_1');
INSERT INTO `script_texts` VALUES ('27447', -1578024, 'The Oculus is ours.','', '', '', '', '', '', '', '', 13654,1,0,0, 'varos SAY_KILL_2');
INSERT INTO `script_texts` VALUES ('27447', -1578025, 'They are... too strong! Underestimated their... fortitude.','', '', '', '', '', '', '', '', 13655,1,0,0, 'varos SAY_DEATH');
INSERT INTO `script_texts` VALUES ('27447', -1578026, 'Blast them! Destroy them!','', '', '', '', '', '', '', '', 13650,1,0,0, 'varos SAY_STRIKE_1');
INSERT INTO `script_texts` VALUES ('27447', -1578027, 'Take no prisoners! Attack!','', '', '', '', '', '', '', '', 13651,1,0,0, 'varos SAY_STRIKE_2');
INSERT INTO `script_texts` VALUES ('27447', -1578028, 'Strike now! Obliterate them!','', '', '', '', '', '', '', '', 13652,1,0,0, 'varos SAY_STRIKE_3');

-- Varos says when Drakos dies
INSERT INTO `script_texts` VALUES ('27447', -1578029, 'Intruders, your victory will be short-lived. I am Commander Varos Cloudstrider. My drakes control the skies and protest this conduit. I will see to it personally that the Oculus does not fall into your hands!','', '', '', '', '', '', '', '', 13648,1,0,0, 'varos SAY_SPAWN');


UPDATE gameobject_template SET flags=4 where entry IN (189986,193995);

-- 8276
-- Fix Arcane Beam npc
UPDATE creature SET phaseMask = 0 WHERE id = 28239;
-- Fix Centrifuge Core npc
UPDATE creature SET phaseMask = 1 WHERE id = 28183;
-- Fix fazione Arcane beam
UPDATE creature_template SET faction_A = 35, faction_H = 35 WHERE entry = 28239;
-- Planar Anomaly
UPDATE creature_template SET InhabitType = 5, modelid1 = 28107, modelid3 = 28107 WHERE entry = 30879;

-- Exit portal
UPDATE gameobject_template set data17 = 0 where entry = 193908;

-- 8380
-- Reputazione a Oculus
DELETE FROM `creature_onkill_reputation` WHERE creature_id IN (27654, 27656, 27655, 27447, 27633, 27636, 28236, 27638, 27635, 27641, 28276, 27650, 27645, 27651, 27642, 27649, 27648, 27647, 27653, 27644, 30879, 27640, 27639, 28153);
INSERT INTO `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES 
(27654, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- Drakos the interrogator
(27656, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- Ley Guardian Eregos
(27655, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- Mage lord urom
(27447, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- Varos cloudstrider
-- Trash
(27633, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(27636, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(28236, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(27638, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(27635, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(27641, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(28276, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(27650, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(27645, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(27651, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(27642, 1037, 1052, 7, 0, 5, 7, 0, 5, 1), 
(27649, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(27648, 1037, 1052, 7, 0, 5, 7, 0, 5, 1), 
(27647, 1037, 1052, 7, 0, 5, 7, 0, 5, 1),
(27653, 1037, 1052, 7, 0, 5, 7, 0, 5, 1),
(27644, 1037, 1052, 7, 0, 5, 7, 0, 5, 1),
(30879, 1037, 1052, 7, 0, 5, 7, 0, 5, 1),
(27640, 1037, 1052, 7, 0, 5, 7, 0, 5, 1),
(27639, 1037, 1052, 7, 0, 5, 7, 0, 5, 1),
(28153, 1037, 1052, 7, 0, 5, 7, 0, 5, 1);
-- Planar Anomlay di Eregos
UPDATE creature_template SET ScriptName = 'npc_planar_anomaly' WHERE entry = 30879;
-- Arcane beam
DELETE FROM creature WHERE id = 28239;
UPDATE creature_template SET modelid3 = 0 WHERE entry = 30879;

-- Script Texts
REPLACE INTO script_texts (`entry`, `content_default`, `npc_entry`, `content_loc3`, `sound`, `type`, `language`) VALUES
('-1752008', '', '0', 'Help I\'m caught in that tree! Help me!', '17490', '1', '7'),	 	
('-1752009', '', '0', 'Thank you', '17491', '1', '7'),	 	
('-1752010', '', '0', 'We believed the Sanctum is well appreciated but this type of attack we were not prepared ...', '17492', '0', '7'),	 	
('-1752011', '', '0', 'The Black Dragonkin appeared from nowhere and attacked us to respond before we could ...', '17493', '0', '7'), 	
('-1752012', '', '0', 'We had no chance ... While my brothers died, I could retire here and the entrance block.', '17494', '0', '7'), 	
('-1752013', '', '0', 'They slaughtered us with cold efficiency ... But their wares goal seemed to be the eggs which are located in the Sanctum.', '17495', '0', '7'),	
('-1752014', '', '0', 'The commander of ground troops is a cruel beast called Zarithrian. But I fear greater powers are at work ...', '17496', '0', '7'),	
('-1752015', '', '0', 'I saw in their attack shortly their true leader ... a terrible twilight adult dragon.', '17497', '0', '7'),	
('-1752016', '', '0', 'I know their exact plans but I know one thing: They may not be successful!', '17498', '0', '7'),

( -1752001, "Ah, the entertainment has arrived.", 0, "Ahh...Die Unterhaltung ist eingetroffen!", 17520, 1, 7),
( -1752002, "Baltharus leaves nobody alive!", 0, "Baltharus lasst niemanden am Leben!", 17521, 1, 7),
( -1752003, "This world has enough heroes.", 0, "Diese Welt hat genug Helden!", 17522, 1, 7),
( -1752004, "I..don't saw...that coming...", 0, "Das...habe ich...nicht..kommen sehen...", 17523, 1, 7),
( -1752005, "Twice the pain and half the fun.", 0, "Doppelter Schmerz, Halb so viel Spa?!", 17524, 1, 7),
( -1752006, "", 0, "Eure Macht schwindet, Uralte! Balt folgt ihr euren Freunden!", 17525, 1, 7),

( -1752017, "Alexstrasza has chosen capable allies... A pity that I must END YOU!", 0, "Alextrasza hat fahige Verbundete... Zu Schade, dass es hier mit euch ENDET!", 17512, 1, 7),
( -1752018, "You thought you stood a chance?", 0, "Ihr dachtet ihr konntet bestehen?", 17513, 1, 7),
( -1752019, "It's for the best.", 0, "Es ist zu eurem Besten.", 17514, 1, 7),
( -1752020, "HALION! I...", 0, "HALION! Ich...", 17515, 1, 7),
( -1752021, "Turn them to ashes, minions!", 0, "Aschert sie ein, Lakeien!", 17516, 1, 7),

( -1752022, "You will sssuffer for this intrusion!", 0, "Fur dieses Eindringen werdet ihr leiden!", 17528, 1, 7),
( -1752023, "As it should be...", 0, "Wie es sich gehort...", 17529, 1, 7),
( -1752024, "Halion will be pleased", 0, "Halion wird erfreut sein...", 17530, 1, 7),
( -1752025, "HHrr...Grr..", 0, "HHrr...Grr..", 17531, 1, 7),
( -1752026, "Burn in the master's flame!", 0, "Brennt in der Flamme des Meisters!", 17532, 1, 7),

('-1752027', '', '0', 'Annoying insects! You\'re too late! The Ruby Sanctum is lost ...', '17499', '1', '7'),	
('-1752028', '', '0', 'Your world is in the balance. You all will be witnesses of the beginning of a new age of destruction', '17500', '1', '7'),	 	
('-1752029', '', '0', 'Another hero is gone!', '17501', '1', '7'),	 	
('-1752030', '', '0', 'Hrrhahaha!', '17502', '1', '7'),	 	
('-1752031', '', '0', 'Enjoy your victory, mortals for it was your Last! On the return of the master will burn this world ...', '17499', '1', '7'),
('-1752032', '', '0', 'Not good enough.', '17504', '1', '7'),
('-1752033', '', '0', 'Burn The Sky!', '17505', '1', '7'),
('-1752033', '', '0', 'Beware the shadows!', '17506', '1', '7'),
('-1752033', '', '0', 'You will find only in the realm of twilight suffering. Come in if you dare!', '17507', '1', '7'),
('-1752033', '', '0', 'I am the light and darkness. Tremble mortals before the herald Deathwing!', '17508', '1', '7');

-- Scriptnames
UPDATE `instance_template` SET `script`='instance_ruby_sanctum' WHERE (`map`='724');
UPDATE `creature_template` SET `ScriptName` = 'boss_baltharus' WHERE `entry` = '39751';
UPDATE `creature_template` SET `ScriptName` = 'boss_baltharus_clone' WHERE `entry` = '39899';
UPDATE `creature_template` SET `ScriptName` = 'npc_xerestrasza' WHERE `entry` = '40429';
UPDATE `creature_template` SET `ScriptName` = 'boss_zarithrian' WHERE `entry` = '39746';
UPDATE `creature_template` SET `ScriptName` = 'boss_ragefire' WHERE `entry` = '39747';
UPDATE `creature_template` SET `ScriptName` = 'boss_halion' WHERE `entry`= '39863';
UPDATE `creature_template` SET `ScriptName` = 'boss_twilight_halion' WHERE `entry` = '40142';
UPDATE `creature_template` SET `ScriptName` = 'npc_onyx_flamecaller' WHERE `entry` = '39814';
UPDATE `gameobject_template` SET `ScriptName` = 'go_firefield' WHERE `entry` = '203005';

DELETE FROM `spell_bonus_data` WHERE `entry` IN (20187,54158);

-- Limit Flame Tsunami buff to Lava Blazes only
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=60430;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
(13,60430,18,1,30643),
(13,60430,18,1,31317);

UPDATE `instance_template` SET `script`='instance_trial_of_the_champion' WHERE `map`=650;
UPDATE `creature_template` SET `ScriptName`='npc_announcer_toc5' WHERE `entry`IN (35004,35005);

-- Moturas
DELETE FROM `vehicle_accessory` WHERE `entry` in (35491,33299,33418,33409,33300,33408,33301,33414,33297,33416,33298);
INSERT INTO `vehicle_accessory` (`entry`,`accessory_entry`,`seat_id`,`minion`,`description`) VALUES
(35491,35451,0,0, 'Black Knight'),
(33299,35323,0,1, 'Darkspear Raptor'),
(33418,35326,0,1, 'Silvermoon Hawkstrider'),
(33409,35314,0,1, 'Orgrimmar Wolf'),
(33300,35325,0,1, 'Thunder Bluff Kodo'),
(33408,35329,0,1, 'Ironforge Ram'),
(33301,35331,0,1, 'Gnomeregan Mechanostrider'),
(33414,35327,0,1, 'Forsaken Warhorse'),
(33297,35328,0,1, 'Stormwind Steed'),
(33416,35330,0,1, 'Exodar Elekk'),
(33298,35332,0,1, 'Darnassian Nightsaber');


-- Textos originales.
DELETE FROM `script_texts` WHERE `entry` <= -1999926 and `entry` >= -1999956;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(0,-1999926, 'Coming out of the gate Grand Champions other faction.  ' ,0,0,0,1, 'SAY_START' ),
(0,-1999927, 'Good work! You can get your award from Crusader\'s Coliseum chest!.  ' ,0,1,0,1, 'Win' ),
(0,-1999928, 'You spoiled my grand entrance. Rat.' ,16256,1,0,5, 'SAY_AGGRO' ),
(0,-1999929, 'Did you honestly think an agent if the Kich King would be bested on the field of your pathetic little tournament?' ,16257,1,0,5, 'SAY_AGGRO_1' ),
(0,-1999930, 'I have come to finish my task ' ,16258,1,0,5, 'SAY_AGGRO_2' ),
(0,-1999931, 'This farce ends here!' ,16259,1,0,5, 'SAY_AGGRO_3' ),
(0,-1999932, '[Zombie]Brains.... .... ....' ,0,1,0,5, 'SAY_SLAY' ),
(0,-1999933, 'My roting flash was just getting in the way!' ,16262,1,0,5, 'SAY_DEATH_1' ),
(0,-1999934, 'I have no need for bones to best you!' ,16263,1,0,5, 'SAY_DEATH_2' ),
(0,-1999935, 'No! I must not fail...again...' ,16264,1,0,5, 'SAY_DEATH_3' ),
(0,-1999936, 'What\'s that. up near the rafters ?' ,0,1,0,5, 'detected' ),
(0,-1999937, 'Please change your weapon! Next battle will be start now!' ,0,3,0,5, 'nx' ),
(0,-1999939, 'Excellent work!' ,0,1,0,1, 'work' ),
(0,-1999940, 'Coming out of the gate Crusader\'s Coliseum Champion.' ,0,0,0,1, 'SAY_START3' ),
(0,-1999941, 'Excellent work! You are win Argent champion!' ,0,3,0,0, 'win' ),
(0,-1999942, 'The Sunreavers are proud to present their representatives in this trial by combat.' ,0,0,0,1, 'an1' ),
(0,-1999943, 'Welcome, champions. Today, before the eyes of your leeders and peers, you will prove youselves worthy combatants.' ,0,0,0,1, 'an2' ),
(0,-1999944, 'Fight well, Horde! Lok\'tar Ogar!' ,0,1,0,5, 'Thrall' ),
(0,-1999945, 'Finally, a fight worth watching.' ,0,1,0,5, 'Garrosh' ),
(0,-1999946, 'I did not come here to watch animals tear at each other senselessly, Tirion' ,0,1,0,5, 'King' ),
(0,-1999947, 'You will first be facing three of the Grand Champions of the Tournament! These fierce contenders have beaten out all others to reach the pinnacle of skill in the joust.' ,0,1,0,5, 'Hightlord' ),
(0,-1999948, 'Will tought! You next challenge comes from the Crusade\'s own ranks. You will be tested against their consederable prowess.' ,0,1,0,5, 'Hightlord2' ),
(0,-1999949, 'You may begin!' ,0,0,0,5, 'text' ),
(0,-1999950, 'Well, then. Let us begin.' ,0,1,0,5, 'pal agro' ),
(0,-1999951, 'Take this time to consider your past deeds.' ,16248,1,0,5, 'palsum' ),
(0,-1999952, 'What is the meaning of this?' ,0,1,0,5, 'dk_hightlord' ),
(0,-1999953, 'No...I\'m still too young' ,0,1,0,5, 'die' ),
(0,-1999954, 'Excellent work! You are win Argent champion!' ,0,3,0,0, 'win' );


-- actualizaci�n nueva de todos los npc relacionado a prueba del campe�n
-- Update mob's stats
-- Memory's Stats
-- Health, mana, vehicle id, etc...
-- Equipment
-- Faction for Vehicle

DELETE FROM `creature_template` WHERE `entry` IN 
(33297, 33298, 33299, 33300, 33301, 33408, 33409, 33414, 33416, 33418, 34657, 34658, 34701, 34702, 34703, 34705, 34928, 34942, 35028, 35029, 
35030, 35031, 35032, 35033, 35034, 35035, 35036, 35037, 35038, 35039, 35040, 35041, 35042, 35043, 35044, 35045, 35046, 35047, 35048, 35049, 
35050, 35051, 35052, 35119, 35305, 35306, 35307, 35308, 35309, 35310, 35314, 35323, 35325, 35326, 35327, 35328, 35329, 35330, 35331, 35332, 
35451, 35490, 35517, 35518, 35519, 35520, 35521, 35522, 35523, 35524, 35525, 35527, 35528, 35529, 35530, 35531, 35532, 35533, 35534, 35535, 
35536, 35537, 35538, 35539, 35541, 35542, 35543, 35544, 35545, 35564, 35568, 35569, 35570, 35571, 35572, 35590, 35617, 35633, 35634, 35635, 
35636, 35637, 35638, 35640, 35641, 35644, 35717, 35768, 36082, 36083, 36084, 36085, 36086, 36087, 36088, 36089, 36090, 36091, 36558);


INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES 
('33297','0','0','0','0','0','28912','0','0','0','Stormwind Steed','','','0','80','80','0','14','14','0','1','1.14286','1','0','20000','30000','0','24','1','2000','0','1','0','8','0','0','0','0','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','140','1','0','0','0','generic_vehicleAI_toc5','1'),
('33298','0','0','0','0','0','29256','0','0','0','Darnassian Nightsaber','','','0','80','80','0','14','14','0','1','1.14286','1','0','20000','30000','0','24','1','2000','0','1','0','8','0','0','0','0','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','140','1','0','0','0','generic_vehicleAI_toc5','11723'),
('33299','0','0','0','0','0','29261','0','0','0','Darkspear Raptor','','','0','80','80','0','14','14','0','1','1.14286','1','0','20000','30000','0','24','1','2000','0','1','0','8','0','0','0','0','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','140','1','0','0','0','generic_vehicleAI_toc5','11159'),
('33300','0','0','0','0','0','29259','0','0','0','Thunder Bluff Kodo','','','0','80','80','0','14','14','0','1','1.14286','1','0','20000','30000','0','24','1','2000','0','1','0','8','0','0','0','0','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','140','1','0','0','0','generic_vehicleAI_toc5','11159'),
('33301','0','0','0','0','0','28571','0','0','0','Gnomeregan Mechanostrider','','','0','80','80','0','14','14','0','1','1.14286','1','0','20000','30000','0','24','1','2000','0','1','0','8','0','0','0','0','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','140','1','0','0','0','generic_vehicleAI_toc5','1'),
('33408','0','0','0','0','0','29258','0','0','0','Ironforge Ram','','','0','80','80','0','14','14','0','1','1.14286','1','0','20000','30000','0','24','1','2000','0','1','0','8','0','0','0','0','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','140','1','0','0','0','generic_vehicleAI_toc5','1'),
('33409','0','0','0','0','0','29260','0','0','0','Orgrimmar Wolf','','','0','80','80','0','14','14','0','1','1.14286','1','0','20000','30000','0','24','1','2000','0','1','0','8','0','0','0','0','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','140','1','0','0','0','generic_vehicleAI_toc5','11159'),
('33414','0','0','0','0','0','29257','0','0','0','Forsaken Warhorse','','','0','80','80','0','14','14','0','1','1.14286','1','0','20000','30000','0','24','1','2000','0','1','0','8','0','0','0','0','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','140','1','0','0','0','generic_vehicleAI_toc5','11159'),
('33416','0','0','0','0','0','29255','0','0','0','Exodar Elekk','','','0','80','80','0','14','14','0','1','1.14286','1','0','20000','30000','0','24','1','2000','0','1','0','8','0','0','0','0','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','140','1','0','0','0','generic_vehicleAI_toc5','11403'),
('33418','0','0','0','0','0','29262','0','0','0','Silvermoon Hawkstrider','','','0','80','80','0','14','14','0','1','1.14286','1','0','20000','30000','0','24','1','2000','0','1','0','8','0','0','0','0','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','140','1','0','0','0','generic_vehicleAI_toc5','1'),
('34657','36086','0','0','0','0','28735','0','28735','0','Jaelyne Evensong','Grand Champion of Darnassus','','0','80','80','2','1802','1802','0','1','1','1','1','420','630','0','158','10.2','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','68340','66083','66081','66079','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2095','617297499','0','boss_hunter_toc5','1'),
('34658','0','0','0','0','0','9991','0','0','0','Jaelyne Evensong\'s Mount','','','0','80','80','2','14','14','0','1','1.14286','1','0','20000','30000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','generic_vehicleAI_toc5','11723'),
('34701','36083','0','0','0','0','28736','0','28736','0','Colosos','Grand Champion of the Exodar','','0','80','80','2','1802','1802','0','1','1','1','1','420','630','0','158','10.2','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','67529','67530','67528','67534','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2096','617297499','0','boss_shaman_toc5','1'),
('34702','36082','0','0','0','0','28586','0','28586','0','Ambrose Boltspark','Grand Champion of Gnomeregan','','0','80','80','2','1802','1802','0','1','1','1','1','420','630','0','158','10.2','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','64','0','0','0','0','0','0','0','0','0','66044','66042','66045','66043','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','0','617297499','0','boss_mage_toc5','1'),
('34703','36087','0','0','0','0','28564','0','28564','0','Lana Stouthammer','Grand Champion of Ironforge','','0','80','80','2','1802','1802','0','1','1','1','1','420','630','0','158','10.2','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','67709','67706','67701','0','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','441','1','2093','617297499','0','boss_rouge_toc5','1'),
('34705','36088','0','0','0','0','28560','0','28560','0','Marshal Jacob Alerius','Grand Champion of Stormwind','','0','80','80','2','1802','1802','0','1','1','1','1','420','630','0','158','10.2','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2092','617297499','0','boss_warrior_toc5','1'),
('34928','35517','0','0','0','0','29490','0','29490','0','Argent Confessor Paletress','','','0','82','82','2','14','14','0','1','1','1','1','452','678','0','170','14.5','2000','2000','2','0','0','0','0','0','0','0','362','542','136','7','104','0','0','0','0','0','0','0','0','0','66546','66536','66515','66537','0','0','0','0','0','0','0','0','','0','3','8','20','1','0','0','0','0','0','0','0','151','1','235','805257215','0','boss_paletress','1'),
('34942','35531','0','0','0','0','29525','0','29525','0','Memory of Hogger','','','0','82','82','2','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35028','35541','0','0','0','0','29536','0','29536','0','Memory of VanCleef','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35029','35538','0','0','0','0','29556','0','29556','0','Memory of Mutanus','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35030','35530','0','0','0','0','29537','0','29537','0','Memory of Herod','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35031','35536','0','0','0','0','29562','0','29562','0','Memory of Lucifron','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','66619','66552','0','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35032','0','0','0','0','0','14992','0','14992','0','Memory of Thunderaan','','','0','82','82','0','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','10','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35033','35521','0','0','0','0','14367','0','14367','0','Memory of Chromaggus','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','2','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35034','35528','0','0','0','0','29540','0','29540','0','Memory of Hakkar','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','10','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35035','0','0','0','0','0','29888','0','0','0','Barrett Ramsey','Argent Coliseum Master','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','768','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','','11723'),
('35036','35543','0','0','0','0','29541','0','29541','0','Memory of Vek\'nilash','','','0','82','82','2','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','10','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35037','35535','0','0','0','0','29542','0','29542','0','Memory of Kalithresh','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66552','66620','66619','0','0','0','0','0','0','0','0','0','','0','3','29.2313','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35038','35537','0','0','0','0','29543','0','29543','0','Memory of Malchezaar','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','3','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35039','35527','0','0','0','0','18698','0','18698','0','Memory of Gruul','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35040','35542','0','0','0','0','29545','0','0','0','Memory of Vashj','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35041','35520','0','0','0','0','29546','0','29546','0','Memory of Archimonde','','','0','82','82','2','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','3','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35042','35533','0','0','0','0','29547','0','29547','0','Memory of Illidan','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','3','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35043','35523','0','0','0','0','18699','0','18699','0','Memory of Delrissa','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35044','35525','0','0','0','0','23428','0','23428','0','Memory of Entropius','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','10','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35045','35534','0','0','0','0','29558','0','29558','0','Memory of Ingvar','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','6','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35046','35522','0','0','0','0','29549','0','29549','0','Memory of Cyanigosa','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','2','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35047','35524','0','0','0','0','26644','0','26644','0','Memory of Eck','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35048','35539','0','0','0','0','21401','0','21401','0','Memory of Onyxia','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','2','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35049','35529','0','0','0','0','29557','0','29557','0','Memory of Heigan','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','6','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35050','35532','0','0','0','0','29185','0','29185','0','Memory of Ignis','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','5','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35051','35544','0','0','0','0','28548','0','28548','0','Memory of Vezax','','','0','82','82','0','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','10','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35052','35519','0','0','0','0','29553','0','29553','0','Memory of Algalon','','','0','82','82','2','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','4','72','0','0','0','0','0','0','0','0','0','67679','67678','67677','0','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35119','35518','0','0','0','0','29616','0','29616','0','Eadric the Pure','Grand Champion of the Argent Crusade','','0','82','82','2','14','14','0','1','1','1','1','452','678','0','170','14.5','2000','2000','2','0','0','0','0','0','0','0','362','542','136','7','104','0','0','0','0','0','0','0','0','0','66865','66863','66867','66935','0','0','0','0','0','0','0','0','','0','3','42.5','20','1','0','0','0','0','0','0','0','151','1','834','805257215','0','boss_eadric','1'),
('35305','35306','0','0','0','0','29758','29759','29758','0','Argent Monk','','','0','80','80','2','14','14','0','1','1','1','1','420','630','0','158','8','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','8','0','0','0','0','0','0','0','0','0','67251','67255','67233','67235','0','0','0','0','0','0','7661','7661','','0','3','8','1','1','0','0','0','0','0','0','0','0','1','0','0','0','npc_argent_soldier','1'),
('35306','0','0','0','0','0','29758','29759','29758','0','Argent Monk','','','0','80','80','0','14','14','0','1','1','1','1','420','630','0','158','12','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','8','0','0','0','0','0','0','0','0','0','67251','67255','67233','67235','0','0','0','0','0','0','7661','7661','','0','3','23.5867','1','1','0','0','0','0','0','0','0','0','1','0','0','0','','1'),
('35307','35308','0','0','0','0','29760','29761','29760','0','Argent Priestess','','','0','80','80','2','14','14','0','1','1','1','1','420','630','0','158','5.5','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','8','0','0','0','0','0','0','0','0','0','67194','36176','67289','67229','0','0','0','0','0','0','7653','7653','','0','3','8','8','1','0','0','0','0','0','0','0','0','1','0','0','0','npc_argent_soldier','1'),
('35308','0','0','0','0','0','29760','29761','29760','0','Argent Priestess','','','0','80','80','2','14','14','0','1','1','1','1','420','630','0','158','8.5','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','8','0','0','0','0','0','0','0','0','0','67194','36176','67289','67229','0','0','0','0','0','0','7653','7653','','0','3','10','8','1','0','0','0','0','0','0','0','0','1','0','0','0','','1'),
('35309','35310','0','0','0','0','29762','29763','29762','0','Argent Lightwielder','','','0','80','80','2','14','14','0','1','1','1','1','420','630','0','158','8.4','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','8','0','0','0','0','0','0','0','0','0','67247','67290','15284','67237','0','0','0','0','0','0','7651','7651','','0','3','8','5','1','0','0','0','0','0','0','0','0','1','0','0','0','npc_argent_soldier','1'),
('35310','0','0','0','0','0','29762','29763','29762','0','Argent Lightwielder','','','0','80','80','2','14','14','0','1','1','1','1','420','630','0','158','12.6','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','8','0','0','0','0','0','0','0','0','0','67247','67290','15284','67237','0','0','0','0','0','0','7651','7651','','0','3','8','5','1','0','0','0','0','0','0','0','0','1','0','0','0','','1'),
('35314','0','0','0','0','0','29090','0','0','0','Orgrimmar Champion','','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','33554432','8','0','0','0','0','0','345','509','103','7','2048','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','PassiveAI','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','2049','0','0','','11723'),
('35323','0','0','0','0','0','28702','0','0','0','Sen\'jin Champion','','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','33554432','8','0','0','0','0','0','345','509','103','7','2048','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','PassiveAI','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','2049','0','0','','11723'),
('35325','33471','0','0','0','0','28864','0','0','0','Thunder Bluff Champion','','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','33554432','8','0','0','0','0','0','345','509','103','7','2048','35325','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','PassiveAI','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','2049','0','0','','11723'),
('35326','0','0','0','0','0','28862','0','0','0','Silvermoon Champion','','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','33554432','8','0','0','0','0','0','345','509','103','7','2048','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','PassiveAI','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','2049','0','0','','11723'),
('35327','0','0','0','0','0','28865','0','0','0','Undercity Champion','','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','33554432','8','0','0','0','0','0','345','509','103','7','2048','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','PassiveAI','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','2049','0','0','','11723'),
('35328','0','0','0','0','0','28863','0','0','0','Stormwind Champion','','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','33554432','8','0','0','0','0','0','345','509','103','7','2048','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','PassiveAI','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','2049','0','0','','11723'),
('35329','0','0','0','0','0','28860','0','0','0','Ironforge Champion','','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','33554432','8','0','0','0','0','0','345','509','103','7','2048','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','PassiveAI','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','2049','0','0','','11723'),
('35330','0','0','0','0','0','28858','0','0','0','Exodar Champion','','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','33554432','8','0','0','0','0','0','345','509','103','7','2048','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','PassiveAI','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','2049','0','0','','11723'),
('35331','0','0','0','0','0','28859','0','0','0','Gnomeregan Champion','','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','33554432','8','0','0','0','0','0','345','509','103','7','2048','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','PassiveAI','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','2049','0','0','','11723'),
('35332','0','0','0','0','0','28857','0','0','0','Darnassus Champion','','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','33554432','8','0','0','0','0','0','345','509','103','7','2048','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','PassiveAI','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','2049','0','0','','11723'),
('35451','35490','0','0','0','0','29837','0','29837','0','The Black Knight','','','0','80','80','2','14','14','0','1','1','1','1','420','630','0','158','11.8','2000','2000','1','0','0','0','0','0','0','0','336','504','126','6','72','35451','0','0','0','0','0','0','0','0','67724','67745','67718','67725','0','0','0','0','0','0','9530','9530','','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','0','805257215','0','boss_black_knight','1'),
('35490','0','0','0','0','0','29837','0','29837','0','The Black Knight','','','0','80','80','0','14','14','0','1','1','1','1','420','630','0','158','17.6','2000','2000','1','0','0','0','0','0','0','0','336','504','126','6','72','35490','0','0','0','0','0','0','0','0','67884','68306','67881','67883','0','0','0','0','0','0','10700','10700','','0','3','37.7387','1','1','0','0','0','0','0','0','0','0','1','0','805257215','1','','1'),
('35517','0','0','0','0','0','29490','0','29490','0','Argent Confessor Paletress','','','0','82','82','2','14','14','0','1','1','1','1','452','678','0','170','22.4','2000','2000','2','0','0','0','0','0','0','0','362','542','136','7','104','0','0','0','0','0','0','0','0','0','66546','67674','66515','67675','0','0','0','0','0','0','0','0','','0','3','8','20','1','0','0','0','0','0','0','0','151','1','235','805257215','1','','1'),
('35518','0','0','0','0','0','29616','0','29616','0','Eadric the Pure','Grand Champion of the Argent Crusade','','0','82','82','2','14','14','0','1','1','1','1','452','678','0','170','22.4','2000','2000','2','0','0','0','0','0','0','0','362','542','136','7','104','0','0','0','0','0','0','0','0','0','66865','66863','66867','66935','0','0','0','0','0','0','0','0','','0','3','42.5','20','1','0','0','0','0','0','0','0','151','1','834','805257215','1','','1'),
('35519','0','0','0','0','0','29553','0','29553','0','Memory of Algalon','','','0','82','82','0','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','4','72','0','0','0','0','0','0','0','0','0','67679','67678','67677','0','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35520','0','0','0','0','0','29546','0','29546','0','Memory of Archimonde','','','0','82','82','0','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','3','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35521','0','0','0','0','0','14367','0','14367','0','Memory of Chromaggus','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','2','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35522','0','0','0','0','0','29549','0','29549','0','Memory of Cyanigosa','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','2','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35523','0','0','0','0','0','18699','0','18699','0','Memory of Delrissa','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35524','0','0','0','0','0','26644','0','26644','0','Memory of Eck','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35525','0','0','0','0','0','23428','0','23428','0','Memory of Entropius','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','10','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35527','0','0','0','0','0','18698','0','18698','0','Memory of Gruul','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35528','0','0','0','0','0','29540','0','29540','0','Memory of Hakkar','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','10','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35529','0','0','0','0','0','29557','0','29557','0','Memory of Heigan','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','6','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35530','0','0','0','0','0','29537','0','29537','0','Memory of Herod','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35531','0','0','0','0','0','29525','0','29525','0','Memory of Hogger','','','0','82','82','0','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35532','0','0','0','0','0','29185','0','29185','0','Memory of Ignis','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','5','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35533','0','0','0','0','0','29547','0','29547','0','Memory of Illidan','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','3','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35534','0','0','0','0','0','29558','0','29558','0','Memory of Ingvar','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','6','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35535','0','0','0','0','0','29542','0','29542','0','Memory of Kalithresh','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66552','66620','66619','0','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35536','0','0','0','0','0','29562','0','29562','0','Memory of Lucifron','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','66619','66552','0','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35537','0','0','0','0','0','29543','0','29543','0','Memory of Malchezaar','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','3','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35538','0','0','0','0','0','29556','0','29556','0','Memory of Mutanus','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35539','0','0','0','0','0','21401','0','21401','0','Memory of Onyxia','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','2','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35541','0','0','0','0','0','29536','0','29536','0','Memory of VanCleef','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35542','0','0','0','0','0','29545','0','29545','0','Memory of Vashj','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35543','0','0','0','0','0','29541','0','29541','0','Memory of Vek\'nilash','','','0','82','82','0','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','10','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35544','0','0','0','0','0','28548','0','28548','0','Memory of Vezax','','','0','82','82','0','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','10','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35545','0','0','0','0','0','25528','0','25528','0','Risen Jaeren Sunsworn','Black Knight\'s Minion','','0','80','80','2','14','14','0','1','1','1','0','420','630','0','158','1.4','2000','2000','1','0','0','0','0','0','0','0','336','504','126','6','72','0','0','0','0','0','0','0','0','0','67774','67879','67729','67886','0','0','0','0','0','0','0','0','','0','3','2.5','1','1','0','0','0','0','0','0','0','0','1','0','0','0','npc_risen_ghoul','1'),
('35564','35568','0','0','0','0','25528','0','25528','0','Risen Arelas Brightstar','Black Knight\'s Minion','','0','80','80','2','14','14','0','1','1','1','0','420','630','0','158','1.4','2000','2000','1','0','0','0','0','0','0','0','336','504','126','6','72','0','0','0','0','0','0','0','0','0','67774','67879','67729','67886','0','0','0','0','0','0','0','0','','0','3','2.5','1','1','0','0','0','0','0','0','0','0','1','0','0','0','npc_risen_ghoul','1'),
('35568','0','0','0','0','0','25528','0','25528','0','Risen Arelas Brightstar','Black Knight\'s Minion','','0','80','80','0','14','14','0','1','1','1','0','420','630','0','158','1.4','2000','2000','1','0','0','0','0','0','0','0','336','504','126','6','72','0','0','0','0','0','0','0','0','0','67879','67886','67880','0','0','0','0','0','0','0','0','0','','0','3','9.43467','1','1','0','0','0','0','0','0','0','0','1','0','0','0','','1'),
('35569','36085','0','0','0','0','28637','0','28637','0','Eressea Dawnsinger','Grand Champion of Silvermoon','','0','80','80','2','1801','1801','0','1','1','1','1','420','630','0','158','10.2','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','66044','66042','66045','66043','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2021','617297499','0','boss_mage_toc5','1'),
('35570','36091','0','0','0','0','28588','0','28588','0','Zul\'tore','Grand Champion of Sen\'jin','','0','80','80','2','1801','1801','0','1','1','1','1','420','630','0','158','10.2','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','68340','66083','66081','66079','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2019','617297499','0','boss_hunter_toc5','1'),
('35571','36090','0','0','0','0','28597','0','28597','0','Runok Wildmane','Grand Champion of the Thunder Bluff','','0','80','80','2','1801','1801','0','1','1','1','1','420','630','0','158','10.2','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','67529','67530','67528','67534','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2025','617297499','0','boss_shaman_toc5','1'),
('35572','36089','0','0','0','0','28587','0','28587','0','Mokra the Skullcrusher','Grand Champion of Orgrimmar','','0','80','80','2','1801','1801','0','1','1','1','1','420','630','0','158','10.2','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','441','1','2018','617297499','0','boss_warrior_toc5','1'),
('35590','35717','0','0','0','0','24996','24999','24997','0','Risen Champion','Black Knight\'s Minion','','0','80','80','2','14','14','0','1','1','1','0','420','630','0','158','1','2000','2000','1','0','0','0','0','0','0','0','336','504','126','6','72','0','0','0','0','0','0','0','0','0','67774','67879','67729','67886','0','0','0','0','0','0','0','0','','0','3','1.5','1','1','0','0','0','0','0','0','0','0','1','0','0','0','','1'),
('35617','36084','0','0','0','0','28589','0','28589','0','Deathstalker Visceri','Grand Champion of Undercity','','0','80','80','2','1801','1801','0','1','1','1','1','420','630','0','158','10.2','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','67709','67706','67701','0','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2020','617297499','0','boss_rouge_toc5','1'),
('35633','0','0','0','0','0','28571','0','0','0','Ambrose Boltspark\'s Mount','','','0','80','80','2','14','14','0','1','1.14286','1','0','20000','30000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','generic_vehicleAI_toc5','11723'),
('35634','0','0','0','0','0','10718','0','0','0','Deathstalker Visceri\'s Mount','','','0','80','80','2','14','14','0','1','1.14286','1','0','20000','30000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','generic_vehicleAI_toc5','11723'),
('35635','0','0','0','0','0','28607','0','0','0','Eressea Dawnsinger\'s Mount','','','0','80','80','2','14','14','0','1','1.14286','1','0','20000','30000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','generic_vehicleAI_toc5','11723'),
('35636','0','0','0','0','0','2787','0','0','0','Lana Stouthammer\'s Mount','','','0','80','80','2','14','14','0','1','1.14286','1','0','20000','30000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','generic_vehicleAI_toc5','11723'),
('35637','0','0','0','0','0','29284','0','0','0','Marshal Jacob Alerius\' Mount','','','0','80','80','2','14','14','0','1','1.14286','1','0','20000','30000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','generic_vehicleAI_toc5','11723'),
('35638','0','0','0','0','0','29879','0','0','0','Mokra the Skullcrusher\'s Mount','','','0','80','80','2','14','14','0','1','1.14286','1','0','20000','30000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','generic_vehicleAI_toc5','11723'),
('35640','0','0','0','0','0','29880','0','0','0','Runok Wildmane\'s Mount','','','0','80','80','2','14','14','0','1','1.14286','1','0','20000','30000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','generic_vehicleAI_toc5','11723'),
('35641','0','0','0','0','0','29261','0','0','0','Zul\'tore\'s Mount','','','0','80','80','2','14','14','0','1','1.14286','1','0','20000','30000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','generic_vehicleAI_toc5','11723'),
('35644','0','0','0','0','0','28918','0','0','0','Argent Warhorse','','vehichleCursor','0','80','80','2','35','35','0','1','2','1','0','10000','20000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','10','0','0','0','0','0','0','0','0','0','0','62544','62575','63010','66482','0','0','0','0','0','486','0','0','','0','3','40','1','1','0','0','0','0','0','0','0','157','1','0','0','0','','11723'),
('35717','0','0','0','0','0','24996','24999','24997','0','Risen Champion','Black Knight\'s Minion','','0','80','80','0','14','14','0','1','1','1','0','420','630','0','158','1.4','2000','2000','1','0','0','0','0','0','0','0','336','504','126','6','72','0','0','0','0','0','0','0','0','0','67774','67879','67729','67886','0','0','0','0','0','0','0','0','','0','3','7.076','1','1','0','0','0','0','0','0','0','0','1','0','0','0','','1'),
('35768','0','0','0','0','0','29255','0','0','0','Colosos\' Mount','','','0','80','80','2','14','14','0','1','1.14286','1','0','20000','30000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','generic_vehicleAI_toc5','11723'),
('36082','0','0','0','0','0','28586','0','28586','0','Ambrose Boltspark','Grand Champion of Gnomeregan','','0','80','80','2','1802','1802','0','1','1','1','1','420','630','0','158','15.2','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','64','0','0','0','0','0','0','0','0','0','68312','68310','66045','68311','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','0','617297499','1','','1'),
('36083','0','0','0','0','0','28736','0','28736','0','Colosos','Grand Champion of the Exodar','','0','80','80','2','1802','1802','0','1','1','1','1','420','630','0','158','17','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','68319','67530','68318','67534','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2096','617297499','1','','1'),
('36084','0','0','0','0','0','28589','0','28589','0','Deathstalker Visceri','Grand Champion of Undercity','','0','80','80','0','1801','1801','0','1','1','1','1','420','630','0','158','15.2','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','67709','67706','67701','0','0','0','0','0','0','0','0','0','','0','3','35.38','20','1','0','0','0','0','0','0','0','0','1','2020','617297499','1','','1'),
('36085','0','0','0','0','0','28637','0','28637','0','Eressea Dawnsinger','Grand Champion of Silvermoon','','0','80','80','2','1801','1801','0','1','1','1','1','420','630','0','158','15.2','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','68312','68310','66045','68311','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2021','617297499','1','','1'),
('36086','0','0','0','0','0','28735','0','28735','0','Jaelyne Evensong','Grand Champion of Darnassus','','0','80','80','2','1802','1802','0','1','1','1','1','420','630','0','158','15.2','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','68340','66083','66081','66079','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2095','617297499','1','','1'),
('36087','0','0','0','0','0','28564','0','28564','0','Lana Stouthammer','Grand Champion of Ironforge','','0','80','80','0','1802','1802','0','1','1','1','1','420','630','0','158','15.2','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','35.38','20','1','0','0','0','0','0','0','0','441','1','2093','617297499','1','','1'),
('36088','0','0','0','0','0','28560','0','28560','0','Marshal Jacob Alerius','Grand Champion of Stormwind','','0','80','80','0','1802','1802','0','1','1','1','1','420','630','0','158','15.2','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','35.38','20','1','0','0','0','0','0','0','0','0','1','2092','617297499','1','','1'),
('36089','0','0','0','0','0','28587','0','28587','0','Mokra the Skullcrusher','Grand Champion of Orgrimmar','','0','80','80','0','1801','1801','0','1','1','1','1','420','630','0','158','15.2','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','35.38','20','1','0','0','0','0','0','0','0','441','1','2018','617297499','1','','1'),
('36090','0','0','0','0','0','28597','0','28597','0','Runok Wildmane','Grand Champion of the Thunder Bluff','','0','80','80','2','1801','1801','0','1','1','1','1','420','630','0','158','15.2','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','68319','67530','67528','67534','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2025','617297499','1','','1'),
('36091','0','0','0','0','0','28588','0','28588','0','Zul\'tore','Grand Champion of Sen\'jin','','0','80','80','0','1801','1801','0','1','1','1','1','420','630','0','158','15.2','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','68340','66083','66081','66079','0','0','0','0','0','0','0','0','','0','3','35.38','20','1','0','0','0','0','0','0','0','0','1','2019','617297499','1','','1'),
('36558','0','0','0','0','0','29283','0','0','0','Argent Battleworg','','vehichleCursor','0','80','80','2','35','35','0','1','2','1','0','10000','20000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','10','0','0','0','0','0','0','0','0','0','0','62544','62575','63010','66482','0','0','0','0','0','486','0','0','','0','3','40','1','1','0','0','0','0','0','0','0','157','1','0','0','0','','11723');

-- Anuncios al comienzo del evento.
DELETE FROM `creature_template` WHERE `entry` in (35591,35592);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES 
(35591, 0, 0, 0, 0, 0, 29894, 0, 0, 0, 'Jaeren Sunsworn', '', '', 0, 75, 75, 2, 14, 14, 0, 1, 1, 0, 0, 0, 0, 0, 1, 2000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 'npc_anstart'),
(35592, 0, 0, 0, 0, 0, 29893, 0, 0, 0, 'Arelas Brightstar', '', '', 0, 75, 75, 2, 14, 14, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 'npc_anstart');


-- Fountain of Light
DELETE FROM `creature_template` WHERE `entry`=35311;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES 
(35311, 0, 0, 0, 0, 0, 27769, 0, 0, 0, 'Fountain of Light', '', '', 0, 79, 80, 0, 14, 14, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, '');


-- Grifo esquel�tico del Caballero Negro http://es.wowhead.com/npc=35491
DELETE FROM `creature_template` WHERE `entry`=35491;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES 
(35491, 0, 0, 0, 0, 0, 29842, 0, 0, 0, 'Black Knight\'s Skeletal Gryphon', '', '', 0, 80, 80, 2, 35, 35, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 33554432, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 1048576, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 486, 0, 0, '', 0, 4, 15, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 0, 0, 0, 'npc_black_knight_skeletal_gryphon');
DELETE FROM `script_waypoint` WHERE `entry`=35491;
INSERT INTO `script_waypoint` VALUES
(35491,1,781.513062, 657.989624, 466.821472,0,''),
(35491,2,759.004639, 665.142029, 462.540771,0,''),
(35491,3,732.936646, 657.163879, 452.678284,0,''),
(35491,4,717.490967, 646.008545, 440.136902,0,''),
(35491,5,707.570129, 628.978455, 431.128632,0,''),
(35491,6,705.164063, 603.628418, 422.956635,0,''),
(35491,7,716.350891, 588.489746, 420.801666,0,''),
(35491,8,741.702881, 580.167725, 420.523010,0,''),
(35491,9,761.634033, 586.382690, 422.206207,0,''),
(35491,10,775.982666, 601.991943, 423.606079,0,''),
(35491,11,769.051025, 624.686157, 420.035126,0,''),
(35491,12,756.582214, 631.692322, 412.529785,0,''),
(35491,13,744.841,634.505,411.575,0,'');
-- Grifo esquel�tico del Caballero Negro antes de comenzar la batalla
DELETE FROM `creature_template` WHERE `entry` in (35492);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES 
(35492, 0, 0, 0, 0, 0, 29842, 0, 0, 0, 'Black Knight\'s Skeletal Gryphon', '', '', 0, 80, 80, 2, 35, 35, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 33554432, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 1048576, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 486, 0, 0, '', 0, 3, 15, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 0, 0, 0, 'npc_gr');
DELETE FROM `script_waypoint` WHERE `entry`=35492;
INSERT INTO `script_waypoint` VALUES
(35492,1,741.067078, 634.471558, 411.569366,0,''),
(35492,2,735.726196, 639.247498, 414.725555,0,''),
(35492,3,730.187256, 653.250977, 418.913269,0,''),
(35492,4,734.517700, 666.071350, 426.259247,0,''),
(35492,5,739.638489, 675.339417, 438.226776,0,''),
(35492,6,741.833740, 698.797302, 456.986328,0,''),
(35492,7,734.647339, 711.084778, 467.165314,0,''),
(35492,8,715.388489, 723.820862, 470.333588,0,''),
(35492,9,687.178711, 730.140503, 470.569336,0,'');



-- Spawn Announcer in normal/heroic mode
DELETE FROM `creature` WHERE `id`=35004;
DELETE FROM `creature` WHERE `guid`=130961;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(130961, 35004, 650, 3, 1, 0, 0, 746.626, 618.54, 411.09, 4.63158, 86400, 0, 0, 10635, 0, 0, 0);

-- Da�o
UPDATE `creature_template` SET `dmg_multiplier`= (dmg_multiplier*1.40) WHERE `entry` IN (SELECT `id` FROM creature WHERE `map`=650);
-- El Caballero Negro 35451 11.8 - 35490 17.6p
UPDATE `creature_template` SET `dmg_multiplier`= (dmg_multiplier*2) WHERE `entry`= 35451;
UPDATE `creature_template` SET `dmg_multiplier`= (dmg_multiplier*2) WHERE `entry`= 35490;

-- CREATURES SPAWN TRIAL OF CHAMPION MAP 650
DELETE FROM `creature` WHERE `map`=650;
SET @GUID := 500000;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES 
(@GUID,36558,650,3,1,0,0,726.826,661.201,412.472,4.66003,86400,0,0,1,0,0,0),
(@GUID+1,36558,650,3,1,0,0,716.665,573.495,412.475,0.977384,86400,0,0,1,0,0,0),
(@GUID+2,36558,650,3,1,0,0,705.497,583.944,412.476,0.698132,86400,0,0,1,0,0,0),
(@GUID+3,36558,650,3,1,0,0,770.486,571.552,412.475,2.05949,86400,0,0,1,0,0,0),
(@GUID+4,36558,650,3,1,0,0,717.443,660.646,412.467,4.92183,86400,0,0,1,0,0,0),
(@GUID+5,36558,650,3,1,0,0,700.531,591.927,412.475,0.523599,86400,0,0,1,0,0,0),
(@GUID+6,36558,650,3,1,0,0,790.177,589.059,412.475,2.56563,86400,0,0,1,0,0,0),
(@GUID+7,36558,650,3,1,0,0,702.165,647.267,412.475,5.68977,86400,0,0,1,0,0,0),
(@GUID+8,36558,650,3,1,0,0,773.097,660.733,412.467,4.45059,86400,0,0,1,0,0,0),
(@GUID+9,36558,650,3,1,0,0,793.052,642.851,412.474,3.63029,86400,0,0,1,0,0,0),
(@GUID+10,36558,650,3,1,0,0,778.741,576.049,412.476,2.23402,86400,0,0,1,0,0,0),
(@GUID+11,36558,650,3,1,0,0,788.016,650.788,412.475,3.80482,86400,0,0,1,0,0,0),
(@GUID+12,35644,650,3,1,0,0,704.943,651.33,412.475,5.60251,86400,0,0,1,0,0,0),
(@GUID+13,35644,650,3,1,0,0,774.898,573.736,412.475,2.14675,86400,0,0,1,0,0,0),
(@GUID+14,35644,650,3,1,0,0,699.943,643.37,412.474,5.77704,86400,0,0,1,0,0,0),
(@GUID+15,35644,650,3,1,0,0,712.594,576.26,412.476,0.890118,86400,0,0,1,0,0,0),
(@GUID+16,35644,650,3,1,0,0,793.009,592.667,412.475,2.6529,86400,0,0,1,0,0,0),
(@GUID+17,35644,650,3,1,0,0,702.967,587.649,412.475,0.610865,86400,0,0,1,0,0,0),
(@GUID+18,35644,650,3,1,0,0,768.255,661.606,412.47,4.55531,86400,0,0,1,0,0,0),
(@GUID+19,35644,650,3,1,0,0,720.569,571.285,412.475,1.06465,86400,0,0,1,0,0,0),
(@GUID+20,35644,650,3,1,0,0,787.439,584.969,412.476,2.47837,86400,0,0,1,0,0,0),
(@GUID+21,35644,650,3,1,0,0,722.363,660.745,412.468,4.83456,86400,0,0,1,0,0,0),
(@GUID+22,35644,650,3,1,0,0,790.49,646.533,412.474,3.71755,86400,0,0,1,0,0,0),
(@GUID+23,35644,650,3,1,0,0,777.564,660.3,412.467,4.34587,86400,0,0,1,0,0,0),
(@GUID+24,35591,650,3,1,0,0,746.626,618.54,411.09,4.63158,86400,0,0,10635,0,0,0),
(@GUID+25,35016,650,3,1,0,0,702.274,638.76,412.47,0,120,0,0,1,0,0,0),
(@GUID+26,35016,650,3,1,0,0,697.285,618.253,412.476,0,120,0,0,1,0,0,0),
(@GUID+27,35016,650,3,1,0,0,714.486,581.722,412.476,0,120,0,0,1,0,0,0),
(@GUID+28,35016,650,3,1,0,0,703.884,596.601,412.474,0,120,0,0,1,0,0,0),
(@GUID+29,35016,650,3,1,0,0,712.413,653.931,412.474,0,120,0,0,1,0,0,0),
(@GUID+30,34977,650,3,1,0,0,733.809,545.215,442.075,1.41372,120,0,0,1,0,0,0),
(@GUID+31,34977,650,3,1,0,0,730.998,552.719,438.812,1.3439,120,0,0,1,0,0,0),
(@GUID+32,34977,650,3,1,0,0,734.411,560.158,435.501,1.37881,120,0,0,1,0,0,0),
(@GUID+33,34977,650,3,1,0,0,726.38,557.151,436.978,1.25664,120,0,0,1,0,0,0),
(@GUID+34,34979,650,3,1,0,0,709.576,570.106,435.504,0.942478,120,0,0,1,0,0,0),
(@GUID+35,34979,650,3,1,0,0,712.873,563.172,436.967,1.02974,120,0,0,1,0,0,0),
(@GUID+36,34979,650,3,1,0,0,714.34,553.708,440.223,1.11701,120,0,0,1,0,0,0),
(@GUID+37,34979,650,3,1,0,0,700.273,559.224,442.08,0.925025,120,0,0,1,0,0,0),
(@GUID+38,34966,650,3,1,0,0,718.917,564.078,435.504,1.11701,120,0,0,1,0,0,0),
(@GUID+39,34966,650,3,1,0,0,721.971,548.191,442.072,1.23918,120,0,0,1,0,0,0),
(@GUID+40,34966,650,3,1,0,0,718.405,555.92,438.803,1.15192,120,0,0,1,0,0,0),
(@GUID+41,34966,650,3,1,0,0,725.661,560.835,435.503,1.23918,120,0,0,1,0,0,0),
(@GUID+42,34858,650,3,1,0,0,697.241,583.858,435.504,0.628319,120,0,0,1,0,0,0),
(@GUID+43,34858,650,3,1,0,0,689.635,582.823,438.819,0.558505,120,0,0,1,0,0,0),
(@GUID+44,34858,650,3,1,0,0,696.26,577.507,436.966,0.698132,120,0,0,1,0,0,0),
(@GUID+45,34858,650,3,1,0,0,682.856,586.2,440.243,0.471239,120,0,0,1,0,0,0),
(@GUID+46,34858,650,3,1,0,0,688.012,573.852,442.074,0.663225,120,0,0,1,0,0,0),
(@GUID+47,34860,650,3,1,0,0,699.005,654.894,435.504,5.53269,120,0,0,1,0,0,0),
(@GUID+48,34860,650,3,1,0,0,693.635,654.892,436.963,5.60251,120,0,0,1,0,0,0),
(@GUID+49,34860,650,3,1,0,0,690.486,661.661,440.209,5.55015,120,0,0,1,0,0,0),
(@GUID+50,34860,650,3,1,0,0,684.069,656.681,442.074,5.68977,120,0,0,1,0,0,0),
(@GUID+52,34860,650,3,1,0,0,686.866,650.837,438.779,5.75959,120,0,0,1,0,0,0),
(@GUID+53,34861,650,3,1,0,0,677.17,640.74,442.069,6.00393,120,0,0,1,0,0,0),
(@GUID+54,34861,650,3,1,0,0,689.436,639.259,435.503,5.95157,120,0,0,1,0,0,0),
(@GUID+55,34861,650,3,1,0,0,679.981,648.878,440.198,5.86431,120,0,0,1,0,0,0),
(@GUID+56,34861,650,3,1,0,0,686.392,643.351,436.973,5.88176,120,0,0,1,0,0,0),
(@GUID+57,34861,650,3,1,0,0,692.406,644.87,435.504,5.8294,120,0,0,1,0,0,0),
(@GUID+58,34970,650,3,1,0,0,769.951,547.875,442.072,1.79769,120,0,0,1,0,0,0),
(@GUID+59,34970,650,3,1,0,0,761.217,549.142,440.246,1.58825,120,0,0,1,0,0,0),
(@GUID+60,34970,650,3,1,0,0,764.08,553.434,438.828,1.8675,120,0,0,1,0,0,0),
(@GUID+61,34857,650,3,1,0,0,675.281,589.988,442.081,0.383972,120,0,0,1,0,0,0),
(@GUID+62,34857,650,3,1,0,0,675.115,597.719,442.073,0.279253,120,0,0,1,0,0,0),
(@GUID+63,34857,650,3,1,0,0,692.854,590.632,435.504,0.471239,120,0,0,1,0,0,0),
(@GUID+64,34857,650,3,1,0,0,689.623,598.045,435.503,0.331613,120,0,0,1,0,0,0),
(@GUID+65,34857,650,3,1,0,0,684.964,591.017,438.848,0.418879,120,0,0,1,0,0,0),
(@GUID+66,34975,650,3,1,0,0,779.997,550.694,442.077,2.05949,120,0,0,1,0,0,0),
(@GUID+67,34975,650,3,1,0,0,773.502,555.516,438.825,1.95477,120,0,0,1,0,0,0),
(@GUID+68,34859,650,3,1,0,0,687.965,629.611,435.498,6.19592,120,0,0,1,0,0,0),
(@GUID+69,34859,650,3,1,0,0,688.731,604.689,435.501,0.20944,120,0,0,1,0,0,0),
(@GUID+70,34859,650,3,1,0,0,677.986,634.102,440.245,5.78437,120,0,0,1,0,0,0),
(@GUID+71,34859,650,3,1,0,0,680.599,603.986,438.794,0.191986,120,0,0,1,0,0,0),
(@GUID+72,34859,650,3,1,0,0,685.113,600.431,436.97,0.279253,120,0,0,1,0,0,0),
(@GUID+73,34859,650,3,1,0,0,685.118,634.405,436.976,6.0912,120,0,0,1,0,0,0),
(@GUID+74,34868,650,3,1,0,0,806.488,574.615,442.076,2.49582,120,0,0,1,0,0,0),
(@GUID+75,34868,650,3,1,0,0,799.194,575.25,438.801,2.37365,120,0,0,1,0,0,0),
(@GUID+76,34974,650,3,1,0,0,790.608,559.269,442.073,2.40855,120,0,0,1,0,0,0),
(@GUID+77,34869,650,3,1,0,0,813.502,644.877,440.254,3.49066,120,0,0,1,0,0,0),
(@GUID+78,34869,650,3,1,0,0,818.512,640.599,442.078,3.38594,120,0,0,1,0,0,0),
(@GUID+79,34869,650,3,1,0,0,813.3,650.717,442.073,3.49066,120,0,0,1,0,0,0),
(@GUID+80,34856,650,3,1,0,0,813.635,587.592,442.069,2.70526,120,0,0,1,0,0,0),
(@GUID+81,34856,650,3,1,0,0,814.332,597.781,440.261,2.89725,120,0,0,1,0,0,0),
(@GUID+82,34856,650,3,1,0,0,808.924,586.035,440.295,2.63545,120,0,0,1,0,0,0),
(@GUID+83,34870,650,3,1,0,0,818.163,607.13,440.209,2.94961,120,0,0,1,0,0,0),
(@GUID+84,34870,650,3,1,0,0,818.134,626.964,440.218,3.28122,120,0,0,1,0,0,0),
(@GUID+85,34871,650,3,1,0,0,810.608,659.83,442.086,3.68265,120,0,0,1,0,0,0),
(@GUID+86,34871,650,3,1,0,0,800.194,660.729,438.769,3.82227,120,0,0,1,0,0,0),
(@GUID+87,34871,650,3,1,0,0,805.472,648.721,436.927,3.50811,120,0,0,1,0,0,0),
(@GUID+88,34905,650,3,1,0,0,696.359,653.587,435.504,5.53252,120,0,0,1,0,0,0),
(@GUID+89,34903,650,3,1,0,0,697.116,583.052,435.504,0.628319,120,0,0,1,0,0,0),
(@GUID+90,34902,650,3,1,0,0,689.196,597,435.503,0.349066,120,0,0,1,0,0,0),
(@GUID+91,34883,650,3,1,0,0,687.83,617.649,435.493,1.58825,120,0,0,1,0,0,0),
(@GUID+92,34901,650,3,1,0,0,687.16,618.132,435.489,0,120,0,0,1,0,0,0),
(@GUID+93,34904,650,3,1,0,0,690.596,642,435.504,5.88176,120,0,0,1,0,0,0);


-- cajas que las spawnea el core
DELETE FROM `gameobject_template` WHERE `entry` IN (195709, 195374, 195323); -- modo normal
DELETE FROM `gameobject_template` WHERE `entry` IN (195710, 195375, 195324); -- modo heroico
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) VALUES 
('195323','3','9069','Confessor\'s Cache','','','','0','0','2','0','0','0','0','0','0','1634','27327','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','11723'),
('195324','3','9069','Confessor\'s Cache','','','','0','0','2','0','0','0','0','0','0','1634','27417','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','11723'),
('195374','3','9069','Eadric\'s Cache','','','','0','0','2','0','0','0','0','0','0','1634','27325','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','11723'),
('195375','3','9069','Eadric\'s Cache','','','','0','0','2','0','0','0','0','0','0','1634','27416','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','11723'),
('195709','3','9069','Champion\'s Cache','','','','0','0','2','0','0','0','0','0','0','1634','27321','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','11723'),
('195710','3','9069','Champion\'s Cache','','','','0','0','2','0','0','0','0','0','0','1634','27414','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','11723');

-- GAMEOBJECTS SPAWN TRIAL OF CHAMPION MAP 650
DELETE FROM `gameobject` WHERE `map`=650;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES 
('150063','196398','650','3','1','801.663','624.806','412.344','-1.3439','0','0','0','0','0','0','0'),
('150064','196398','650','3','1','784.533','660.238','412.389','-0.715585','0','0','0','0','0','0','0'),
('150065','196398','650','3','1','710.325','660.708','412.387','0.698132','0','0','0','0','0','0','0'),
('150066','196398','650','3','1','692.127','610.575','412.347','1.85005','0','0','0','0','0','0','0'),
('150067','195477','650','3','1','813.13','617.632','413.039','0','0','0','0','0','0','0','0'),
('150068','195486','650','3','1','813.12','617.59','413.031','0','0','0','0','0','0','0','0'),
('150069','195481','650','3','1','746.156','549.464','412.881','1.5708','0','0','0','0','0','0','0'),
('150070','195480','650','3','1','746.156','549.464','412.881','1.5708','0','0','0','0','0','0','0'),
('150071','195479','650','3','1','746.156','549.464','412.881','1.5708','0','0','0','0','0','0','0'),
('150072','195478','650','3','1','746.156','549.464','412.881','1.5708','0','0','0','0','0','0','0'),
('150075','195485','650','3','1','844.685','623.408','159.109','0','0','0','0','0','0','0','0'),
('150081','195647','650','3','1','746.698','677.469','412.339','1.5708','0','0','1','0','0','0','1'),
('150074','195649','650','3','65535','685.625','617.977','412.285','6.28137','0','0','0.000909718','-1','25','0','1'),
('150078','180723','650','3','1','779.951','655.656','421.818','-2.35619','0','0','0','0','0','0','0'),
('150079','180723','650','3','1','782.309','582.892','421.546','2.25147','0','0','0','0','0','0','0'),
('150073','195648','650','3','65535','746.561','557.002','412.393','1.57292','0','0','0.707856','0.706357','25','0','1'),
('150076','195650','650','3','65535','807.66','618.091','412.394','3.12015','0','0','0.999943','0.0107224','25','0','0'),
('150082','180708','650','3','1','712.521','655.648','424.593','-0.767944','0','0','0','0','0','0','0'),
('150083','180708','650','3','1','704.793','600.736','429.519','0.436332','0','0','0','0','0','0','0'),
('150084','180708','650','3','1','704.302','636.326','425.136','-0.418879','0','0','0','0','0','0','0'),
('150085','180703','650','3','1','712.521','655.648','424.593','-0.767944','0','0','0','0','0','0','0'),
('150086','180703','650','3','1','714.158','585.533','425.579','0.715585','0','0','0','0','0','0','0'),
('150087','180703','650','3','1','704.793','600.736','429.519','0.436332','0','0','0','0','0','0','0'),
('150088','180730','650','3','1','714.158','585.533','425.579','0.715585','0','0','0','0','0','0','0'),
('150089','180730','650','3','1','704.793','600.736','429.519','0.436332','0','0','0','0','0','0','0'),
('150090','180736','650','3','1','792.309','598.457','424.636','2.70526','0','0','0','0','0','0','0'),
('150091','180736','650','3','1','794.441','638.306','425.7','-2.77507','0','0','0','0','0','0','0'),
('150092','180736','650','3','1','779.951','655.656','421.818','-2.35619','0','0','0','0','0','0','0'),
('150093','180736','650','3','1','782.309','582.892','421.546','2.25147','0','0','0','0','0','0','0'),
('150094','180720','650','3','1','779.951','655.656','421.818','-2.35619','0','0','0','0','0','0','0'),
('150095','180720','650','3','1','782.309','582.892','421.546','2.25147','0','0','0','0','0','0','0'),
('150096','180738','650','3','1','794.441','638.306','425.7','-2.77507','0','0','0','0','0','0','0'),
('150097','180738','650','3','1','782.309','582.892','421.546','2.25147','0','0','0','0','0','0','0'),
('150098','180728','650','3','1','704.302','636.326','425.136','-0.418879','0','0','0','0','0','0','0'),
('150099','180728','650','3','1','714.158','585.533','425.579','0.715585','0','0','0','0','0','0','0'),
('150100','180728','650','3','1','712.521','655.648','424.593','-0.767944','0','0','0','0','0','0','0');
DELETE FROM `gameobject` WHERE `id` IN (195709, 195374, 195323, 195710, 195375, 195324); -- objetos spawneados en ctdb, no deberian estar

-- drop and conditions
DELETE FROM `conditions` WHERE `SourceGroup` IN (35451, 35490, 27327, 21417, 27325, 27416, 27321, 27414); 
INSERT INTO `conditions` VALUES
(1, 35451, 43228, 0, 1, 57940, 0, 0, 0,NULL),
(1, 35490, 43228, 0, 1, 57940, 0, 0, 0,NULL),
(4, 27327, 43228, 0, 1, 57940, 0, 0, 0,NULL),
(4, 21417, 43228, 0, 1, 57940, 0, 0, 0,NULL),
(4, 27325, 43228, 0, 1, 57940, 0, 0, 0,NULL),
(4, 27416, 43228, 0, 1, 57940, 0, 0, 0,NULL),
(4, 27321, 43228, 0, 1, 57940, 0, 0, 0,NULL),
(4, 27414, 43228, 0, 1, 57940, 0, 0, 0,NULL);

-- The Black Knight
-- http://www.wowhead.com/npc=35451/el-caballero-negro#drops:mode=normal:0+1-15
-- Normal
-- Fix drops rates
DELETE FROM `creature_loot_template` WHERE (`entry`=35451);
INSERT INTO `creature_loot_template` VALUES 
(35451, 47216, 16.666, 1, 2, 1, 1),
(35451, 47215, 16.666, 1, 2, 1, 1),
(35451, 47226, 16.666, 1, 2, 1, 1),
(35451, 47227, 16.666, 1, 2, 1, 1),
(35451, 47229, 16.666, 1, 2, 1, 1),
(35451, 47232, 16.666, 1, 2, 1, 1),
(35451, 47222, 16.666, 1, 1, 1, 1),
(35451, 47221, 16.666, 1, 1, 1, 1),
(35451, 47228, 16.666, 1, 1, 1, 1),
(35451, 47220, 16.666, 1, 1, 1, 1),
(35451, 47230, 16.666, 1, 1, 1, 1),
(35451, 47231, 16.666, 1, 1, 1, 1),
(35451, 43228, 28, 1, 0, 3, 3);

-- http://www.wowhead.com/npc=35451/el-caballero-negro#drops:mode=heroic:0+1-15
-- Hero
-- Fix rates and drops and some missing
DELETE FROM `creature_loot_template` WHERE (`entry`=35490);
INSERT INTO `creature_loot_template` VALUES 
(35490, 47565, 14.285, 1, 2, 1, 1),
(35490, 47568, 14.285, 1, 2, 1, 1),
(35490, 47569, 14.285, 1, 2, 1, 1),
(35490, 47564, 14.285, 1, 2, 1, 1),
(35490, 47567, 14.285, 1, 2, 1, 1),
(35490, 47560, 14.285, 1, 2, 1, 1),
(35490, 49682, 14.285, 1, 2, 1, 1),
(35490, 47566, 16.666, 1, 1, 1, 1),
(35490, 47562, 16.666, 1, 1, 1, 1),
(35490, 47529, 16.666, 1, 1, 1, 1),
(35490, 47561, 16.666, 1, 1, 1, 1),
(35490, 47563, 16.666, 1, 1, 1, 1),
(35490, 47527, 16.666, 1, 1, 1, 1),
(35490, 43228, 2, 1, 0, 4, 4),
(35490, 43102, 100, 1, 0, 1, 1),
(35490, 48418, -100, 1, 0, 1, 1),
(35490, 47241, 100, 1, 0, 1, 1),
(35490, 44990, 47, 1, 0, 1, 1),
(35490, 34057, 1.3, 1, 0, 1, 2);

-- Confessor's Cache
-- http://www.wowhead.com/object=195323#contains:mode=normal:0+1-15
-- Normal (Entry: 195323)
-- fix drops rates and groups
DELETE FROM `gameobject_loot_template` WHERE (`entry`=27327);
INSERT INTO `gameobject_loot_template` VALUES 
(27327, 43228, 100, 1, 0, 3, 3),
(27327, 47176, 8.333, 1, 1, 1, 1),
(27327, 47177, 8.333, 1, 1, 1, 1),
(27327, 47178, 8.333, 1, 1, 1, 1),
(27327, 47181, 8.333, 1, 1, 1, 1),
(27327, 47185, 8.333, 1, 1, 1, 1),
(27327, 47211, 8.333, 1, 1, 1, 1),
(27327, 47212, 8.333, 1, 1, 1, 1),
(27327, 47213, 8.333, 1, 1, 1, 1),
(27327, 47214, 8.333, 1, 1, 1, 1),
(27327, 47217, 8.333, 1, 1, 1, 1),
(27327, 47218, 8.333, 1, 1, 1, 1),
(27327, 47219, 8.333, 1, 1, 1, 1);

-- http://www.wowhead.com/object=195323#contains:mode=heroic:0+1-15
-- Heroic (Entry: 195324)
-- Fix rates and groups
UPDATE `gameobject_template` SET `data1`='21417' WHERE entry='195324';
DELETE FROM `gameobject_loot_template` WHERE (`entry`=21417);
INSERT INTO `gameobject_loot_template` VALUES 
(21417, 47514, 8.333, 1, 1, 1, 1),
(21417, 47512, 8.333, 1, 1, 1, 1),
(21417, 47511, 8.333, 1, 1, 1, 1),
(21417, 47510, 8.333, 1, 1, 1, 1),
(21417, 47500, 8.333, 1, 1, 1, 1),
(21417, 47245, 8.333, 1, 1, 1, 1),
(21417, 47522, 8.333, 1, 1, 1, 1),
(21417, 47498, 8.333, 1, 1, 1, 1),
(21417, 47497, 8.333, 1, 1, 1, 1),
(21417, 47496, 8.333, 1, 1, 1, 1),
(21417, 47495, 8.333, 1, 1, 1, 1),
(21417, 47494, 8.333, 1, 1, 1, 1),
(21417, 47241, 100, 1, 0, 1, 1),
(21417, 44990, 40, 1, 0, 1, 1),
(21417, 43228, 23, 1, 0, 4, 4),
(21417, 34057, 1.3, 1, 0, 1, 2);

-- Eadric's Cache
-- http://www.wowhead.com/object=195374#contains:mode=normal:0+1-15
-- Normal (entry: 195374)
-- Fix groups and drops
DELETE FROM `gameobject_loot_template` WHERE (`entry`=27325);
INSERT INTO `gameobject_loot_template` VALUES 
(27325, 47176, 8.333, 1, 1, 1, 1),
(27325, 47200, 8.333, 1, 1, 1, 1),
(27325, 47178, 8.333, 1, 1, 1, 1),
(27325, 47201, 8.333, 1, 1, 1, 1),
(27325, 47213, 8.333, 1, 1, 1, 1),
(27325, 47181, 8.333, 1, 1, 1, 1),
(27325, 47197, 8.333, 1, 1, 1, 1),
(27325, 47177, 8.333, 1, 1, 1, 1),
(27325, 47202, 8.333, 1, 1, 1, 1),
(27325, 47199, 8.333, 1, 1, 1, 1),
(27325, 47185, 8.333, 1, 1, 1, 1),
(27325, 43228, 21, 1, 0, 3, 3),
(27325, 47210, 8.333, 1, 1, 1, 1);

-- http://www.wowhead.com/object=195374#contains:mode=heroic:0+1-15
-- Hero (Entry: 195375)
-- Fix groups and rates
DELETE FROM `gameobject_loot_template` WHERE (`entry`=27416);
INSERT INTO `gameobject_loot_template` VALUES 
(27416, 47509, 8.333, 1, 1, 1, 1),
(27416, 47508, 8.333, 1, 1, 1, 1),
(27416, 47504, 8.333, 1, 1, 1, 1),
(27416, 47503, 8.333, 1, 1, 1, 1),
(27416, 47502, 8.333, 1, 1, 1, 1),
(27416, 47501, 8.333, 1, 1, 1, 1),
(27416, 47500, 8.333, 1, 1, 1, 1),
(27416, 47498, 8.333, 1, 1, 1, 1),
(27416, 47497, 8.333, 1, 1, 1, 1),
(27416, 47496, 8.333, 1, 1, 1, 1),
(27416, 47495, 8.333, 1, 1, 1, 1),
(27416, 47494, 8.333, 1, 1, 1, 1),
(27416, 47241, 100, 1, 0, 1, 1),
(27416, 44990, 40, 1, 0, 1, 1),
(27416, 43228, 23, 1, 0, 4, 4),
(27416, 34057, 1.3, 1, 0, 1, 2);

-- Champion's Cache
-- http://www.wowhead.com/object=195709#contains:mode=normal:0+1-15
-- Normal (Entry: 195709)
-- Fix rates
DELETE FROM `gameobject_loot_template` WHERE (`entry`=27321);
INSERT INTO `gameobject_loot_template` VALUES 
(27321, 43228, 24, 1, 0, 3, 3),
(27321, 47172, 16.666, 1, 1, 1, 1),
(27321, 47171, 16.666, 1, 1, 1, 1),
(27321, 47170, 16.666, 1, 1, 1, 1),
(27321, 47174, 16.666, 1, 1, 1, 1),
(27321, 47173, 16.666, 1, 1, 1, 1),
(27321, 47175, 16.666, 1, 1, 1, 1);

-- http://www.wowhead.com/object=195709#contains:mode=heroic:0+1-15
-- (Entry: 195710)
-- Fix rates
DELETE FROM `gameobject_loot_template` WHERE (`entry`=27414);
INSERT INTO `gameobject_loot_template` VALUES 
(27414, 44990, 43, 1, 0, 1, 1),
(27414, 47241, 100, 1, 0, 1, 1),
(27414, 34057, 1.3, 1, 0, 1, 1),
(27414, 43228, 24, 1, 0, 4, 4),
(27414, 47243, 16.666, 1, 1, 1, 1),
(27414, 47244, 16.666, 1, 1, 1, 1),
(27414, 47493, 16.666, 1, 1, 1, 1),
(27414, 47248, 16.666, 1, 1, 1, 1),
(27414, 47249, 16.666, 1, 1, 1, 1),
(27414, 47250, 16.666, 1, 1, 1, 1);


-- Acceso a la estancia
UPDATE `access_requirement` SET `level_min`=80, `heroic_level_min`=80 WHERE `id`= 5503;

UPDATE `instance_template` SET `script`='instance_trial_of_the_crussader' WHERE (`map`='649');

UPDATE `creature_template` SET `ScriptName`='npc_tcrus_announcer' WHERE (`entry`='34816');
UPDATE `creature_template` SET `ScriptName`='npc_tcrus_fizzlebang' WHERE (`entry`='35458');
UPDATE `creature_template` SET `ScriptName`='npc_tcrus_tirion' WHERE (`entry`='34996');
UPDATE `creature_template` SET `ScriptName`='npc_LichKing' WHERE (`entry`='35877');
UPDATE `creature_template` SET `ScriptName`='npc_Garrosh' WHERE (`entry`='34995');
UPDATE `creature_template` SET `ScriptName`='npc_KingVyrn' WHERE (`entry`='34990');

-- Faction Champions Horde
UPDATE `creature_template` SET `ScriptName`='boss_gorgrim_shadowcleave' WHERE (`entry`='34458');
UPDATE `creature_template` SET `ScriptName`='boss_birana_stormhoof' WHERE (`entry`='34451');
UPDATE `creature_template` SET `ScriptName`='boss_erin_misthoof' WHERE (`entry`='34459');
UPDATE `creature_template` SET `ScriptName`='boss_rujkah' WHERE (`entry`='34448');
UPDATE `creature_template` SET `ScriptName`='boss_ginselle_blightslinger' WHERE (`entry`='34449');
UPDATE `creature_template` SET `ScriptName`='boss_liandra_suncaller' WHERE (`entry`='34445');
UPDATE `creature_template` SET `ScriptName`='boss_malithas_brightblader' WHERE (`entry`='34456');
UPDATE `creature_template` SET `ScriptName`='boss_caiphus_the_stern' WHERE (`entry`='34447');
UPDATE `creature_template` SET `ScriptName`='boss_vivienne_blackwhisper' WHERE (`entry`='34441');
UPDATE `creature_template` SET `ScriptName`='boss_mazdinah' WHERE (`entry`='34454');
UPDATE `creature_template` SET `ScriptName`='boss_broln_stouthorn' WHERE (`entry`='34455');
UPDATE `creature_template` SET `ScriptName`='boss_thrakgar' WHERE (`entry`='34444');
UPDATE `creature_template` SET `ScriptName`='boss_harkzog' WHERE (`entry`='34450');
UPDATE `creature_template` SET `ScriptName`='boss_narrhok_steelbreaker' WHERE (`entry`='34453');

-- Faction Champions Alliance
UPDATE `creature_template` SET `ScriptName`='boss_tyrius_duskblade' WHERE (`entry`='34461');
UPDATE `creature_template` SET `ScriptName`='boss_kavina_grovesong' WHERE (`entry`='34460');
UPDATE `creature_template` SET `ScriptName`='boss_melador_valestrider' WHERE (`entry`='34469');
UPDATE `creature_template` SET `ScriptName`='boss_alyssia_moonstalker' WHERE (`entry`='34467');
UPDATE `creature_template` SET `ScriptName`='boss_noozle_whizzlestick' WHERE (`entry`='34468');
UPDATE `creature_template` SET `ScriptName`='boss_velanaa' WHERE (`entry`='34465');
UPDATE `creature_template` SET `ScriptName`='boss_baelnor_lightbearer' WHERE (`entry`='34471');
UPDATE `creature_template` SET `ScriptName`='boss_anthar_forgemender' WHERE (`entry`='34466');
UPDATE `creature_template` SET `ScriptName`='boss_brienna_nightfell' WHERE (`entry`='34473');
UPDATE `creature_template` SET `ScriptName`='boss_irieth_shadowstepe' WHERE (`entry`='34472');
UPDATE `creature_template` SET `ScriptName`='boss_shaabad' WHERE (`entry`='34463');
UPDATE `creature_template` SET `ScriptName`='boss_saamul' WHERE (`entry`='34470');
UPDATE `creature_template` SET `ScriptName`='boss_serissa_grimdabbler' WHERE (`entry`='34474');
UPDATE `creature_template` SET `ScriptName`='boss_shocuul' WHERE (`entry`='34475');

-- Spell DBC
INSERT INTO `spelldifficulty_dbc` VALUES ('6000', '66331', '67478', '67477', '67479'); -- Gormok Impale
INSERT INTO `spelldifficulty_dbc` VALUES ('6001', '66330', '67647', '67648', '67649'); -- Gormok Staggering Stomp
INSERT INTO `spelldifficulty_dbc` VALUES ('6002', '66689', '67650', '67651', '67652'); -- Icehowl Artic Breath
INSERT INTO `spelldifficulty_dbc` VALUES ('6003', '66683', '67660', '67660', '67662'); -- Icehowl Massic Crash
INSERT INTO `spelldifficulty_dbc` VALUES ('6004', '67345', '67663', '67663', '67665'); -- Icehowl Whirl
INSERT INTO `spelldifficulty_dbc` VALUES ('6005', '66770', '67655', '67654', '67656'); -- Icehowl Ferocious Butt
INSERT INTO `spelldifficulty_dbc` VALUES ('6006', '66879', '67624', '67625', '67626'); -- Dreadscale Burning Bite
INSERT INTO `spelldifficulty_dbc` VALUES ('6007', '66820', '67636', '67635', '67637'); -- Dreadscale Molten Spew
INSERT INTO `spelldifficulty_dbc` VALUES ('6020', '66237', '67049', '67050', '67051'); -- Jaraxxus Incinerate Flesh
INSERT INTO `spelldifficulty_dbc` VALUES ('6021', '66528', '67029', '67030', '67031'); -- Jaraxxus Fel Lighting
INSERT INTO `spelldifficulty_dbc` VALUES ('6022', '68124', '68126', '68127', '68128'); -- Jaraxxus Legion Flame
INSERT INTO `spelldifficulty_dbc` VALUES ('6023', '66532', '66963', '66964', '66965'); -- Jaraxxus Fel Fireball
INSERT INTO `spelldifficulty_dbc` VALUES ('6024', '66258', '66258', '67903', '67903'); -- Jaraxxus Summon Volcan
INSERT INTO `spelldifficulty_dbc` VALUES ('6025', '67103', '67103', '67104', '67105'); -- Portal Summon Guardian

UPDATE `creature_template` SET `ScriptName`='Boss_Jaraxxus' WHERE (`entry`='34780');
UPDATE `creature_template` SET `ScriptName`='Mob_Vulcan' WHERE `entry`=34813;
UPDATE `creature_template` SET `ScriptName`='Mob_FireTrigger' WHERE `entry`=34784;
UPDATE `creature_template` SET `ScriptName`='Mob_Netherportal' WHERE `entry`=34825;
UPDATE `creature_template` SET `scale`='2' WHERE `entry`=34825;
UPDATE `creature_template` SET `ScriptName`='Mob_MistressOfPain' WHERE `entry`=34826;
INSERT INTO `creature_template` VALUES ('41000', '0', '0', '0', '0', '0', '169', '11686', '169', '0', 'Wilfred Portal Trigger', '', '', '0', '1', '1', '0', '14', '14', '0', '1', '1', '0', '1', '2', '0', '0', '1', '2000', '2000', '1', '0', '0', '0', '0', '0', '0', '0', '1', '2', '0', '10', '1049600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '', '0', '3', '0.0238095', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '2', '', '', '11159');

-- Gormok
UPDATE `creature_template` SET `ScriptName`='boss_gormok_impaler' WHERE (`entry`='34796');
UPDATE `creature_template` SET `scale`='1.5', `faction_A`='16', `faction_H`='16', `ScriptName`='mob_firebomb_trigger' WHERE (`entry`='34854');

-- Acidmaw & Dreadscale
UPDATE `creature_template` SET `ScriptName`='boss_acidmaw' WHERE (`entry`='35144');
UPDATE `creature_template` SET `ScriptName`='boss_dreadscale' WHERE (`entry`='34799');

-- IceHowl
UPDATE `creature_template` SET `ScriptName`='boss_icehowl' WHERE (`entry`='34797');


UPDATE `creature_template` SET `AIName`='', `ScriptName`='boss_eydis' WHERE `entry`=34496;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='boss_fjola' WHERE `entry`=34497;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='mob_valkyr_orb' WHERE `entry` IN (34628, 34630);
UPDATE `creature_template` SET unit_flags= 33554434, faction_A =14, faction_H=14 WHERE `entry` IN (34628, 34630);
INSERT INTO `npc_spellclick_spells` VALUES (34567, 65684, 0, 0, 0, 1, 0, 0, 0), (34568, 65686, 0, 0, 0, 1, 0, 0, 0); -- dark/light "portals"
-- INSERT INTO `spell_script_target` VALUES (65875, 1, 34497), (65876, 1, 34496);

UPDATE `creature_template` SET `ScriptName`='Boss_Raid_Anubarak' WHERE (`entry`='34564');
UPDATE `creature_template` SET `ScriptName`='Mob_NerubianTrigger' WHERE (`entry`='34862');
UPDATE `creature_template` SET `ScriptName`='mob_swarm_scarab' WHERE (`entry`='34605');
UPDATE `creature_template` SET `ScriptName`='nerubian_burrower' WHERE (`entry`='34607');
UPDATE `creature_template` SET `ScriptName`='frost_sphere' WHERE (`entry`='34606');
UPDATE `creature_template` SET `ScriptName`='creature_impale' WHERE (`entry`='29184');

INSERT INTO `script_texts` VALUES ('0', '-1600205', 'Welcome champions, you have heard the call of the Argent Crusade, and you have boldly answered. It is here, in the Crusader\'s Coliseum, that you will face your greatest challenges. Those of you, who survive the rigors of the coliseum will join the Argent Crusade on it\'s march to Icecrown Citadel.', null, null, 'Willkommen, Champions! Ihr habt den Ruf des Argentumkreuzzugs vernommen und seid ihm mutig gefolgt! Hier, im Kolosseum der Kreuzfahrer, werdet Ihr auf Eure gr��ten Herausforderungen treffen.Die jenigen unter Euch, welche die Gefahren des Kolosseums �berleben, werden den Kreuzzug bei seinem Marsch auf die Eiskronenzitadelle begleiten.', null, null, null, null, null, '16036', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600206', 'Hailing from the deepest, darkest carverns of the storm peaks, Gormok the Impaler! Battle on, heroes!', null, null, 'Er kommt aus den tiefsten, dunkelsten H�hlen der Sturmgifpel - Gormok der Pf�hler! Voran, Helden!', null, null, null, null, null, '16038', '1', '0', '0', null);
REPLACE INTO `script_texts` VALUES ('0', '-1600207', 'Let the games begin!', '', null, 'Lasst die Spiele beginnen.', null, null, null, null, null, '16037', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600208', ' I have seen more worthy challenges in the ring of blood, you waste our time paladin!', null, null, 'Im Ring des Blutes habe ich w�rdigere K�mpfer gesehen. Ihr verschwendet unsere Zeit, Paladin!', null, null, null, null, null, '16026', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600209', 'Steel yourselves, heroes, for the twin terrors Acidmaw and Dreadscale. Enter the arena!', null, null, 'Stellt euch Helden, den die Zwillingsschrecken �tschlund und Schreckensmaul erscheinen in der Arena.', null, null, null, null, null, '16039', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600210', 'The air freezes with the introduction of our next combatant, Icehowl! Kill or be killed, champions!', null, null, 'Mit der Ank�ndigung unseres n�chsten K�mpers gefriert die Luft selbst: Eisheuler! T�tet oder werdet get�tet, Champions!', null, null, null, null, null, '16040', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600211', 'Grand Warlock Wilfred Fizzlebang will summon forth your next challenge. Stand by for his entry!', null, null, 'Gro�hexenmeister Wilfred Zischknall wird Eure n�chste Herausforderung beschw�ren. Harrt seiner Ankunft.', null, null, null, null, null, '16043', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600212', 'Thank you, Highlord! Now challengers, I will begin the ritual of summoning! When I am done, a fearsome Doomguard will appear!', null, null, 'Danke. Hochlord. Nun, Champions, werde ich mit dem Beschw�rungsritual beginnen. Sobald es beendet ist, wird eine f�rchterliche Verdammniswache erscheinen!', null, null, null, null, null, '16268', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600213', 'Prepare for oblivion!', null, null, 'Bereitet euch auf den Untergang vor!', null, null, null, null, null, '16269', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600214', 'Ah ha! Behold the absolute power of Wilfred Fizzlebang, master summoner! You are bound to ME, demon!', null, null, 'A-HA! Ich hab es vollbracht! Bestaunt die gerenzenlose Macht von Wilfred Zischknall, Meisterbeschw�rer! Du bist an mich gebunden, D�mon!', null, null, null, null, null, '16270', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600215', 'Trifling gnome, your arrogance will be your undoing!', null, null, 'Unbedeutener Gnom! Deine Arroganz wird dir zum Verh�ngnis!', null, null, null, null, null, '16143', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600216', 'But I\'m in charge her-', null, null, 'aber ich hab hier die Kontrolle ahh......', null, null, null, null, null, '16271', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600217', 'Quickly, heroes! Destroy the demon lord before it can open a portal to its twisted demonic realm!', null, null, 'Schnell, Helden, Zerst�rt den D�monenlord, bevor er ein Portal zu seiner verzerrten Welt �ffnen kann!', null, null, null, null, null, '16044', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600218', 'You face Jaraxxus, eredar lord of the Burning Legion!', null, null, null, null, null, null, null, null, '16144', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600219', 'FLESH FROM BONE!', null, null, null, null, null, null, null, null, '16149', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600220', 'Come forth, sister! Your master calls!', null, null, null, null, null, null, null, null, '16150', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600221', 'INFERNO!', null, null, null, null, null, null, null, null, '16151', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600222', 'Insignificant gnat!', null, null, null, null, null, null, null, null, '16145', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600223', 'Banished to the Nether!', null, null, null, null, null, null, null, null, '16146', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600224', 'Another will take my place. Your world is doomed.', null, null, null, null, null, null, null, null, '16147', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600229', 'The next battle will be against the Argent Crusade\'s most powerful knights! Only by defeating them will you be deemed worthy...', null, null, null, null, null, null, null, null, '0', '1', '0', '0', null);
-- 1600229 - 1600233 Todo Texte
INSERT INTO `script_texts` VALUES ('0', '-1600234', 'The next battle will be against the Argent Crusade\'s most powerful knights! Only by defeating them will you be deemed worthy...', null, null, null, null, null, null, null, null, '16047', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600235', 'Our honor has been besmirched! They make wild claims and false accusations against us. I demand justice! Allow my champions to fight in place of your knights, Tirion. We challenge the Horde!', null, null, null, null, null, null, null, null, '16066', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600236', 'Very well, I will allow it. Fight with honor!', null, null, null, null, null, null, null, null, '16048', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600237', 'Fight for the glory of the Alliance, heroes! Honor your king and your people!', null, null, null, null, null, null, null, null, '16065', '1', '0', '0', null);
-- 1600238 Horde Spawn
INSERT INTO `script_texts` VALUES ('0', '-1600239', 'Only by working together will you overcome the final challenge. From the depths of Icecrown come to of the Scourge\'s most powerful lieutenants: fearsome val\'kyr, winged harbingers of the Lich King!', null, null, null, null, null, null, null, null, '16050', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600240', 'A mighty blow has been dealt to the Lich King! You have proven yourselves able bodied champions of the Argent Crusade. Together we will strike at Icecrown Citadel and destroy what remains of the Scourge! There is no challenge that we cannot face united!', null, null, 'Dem Lichtk�nig wurde ein schwerer Schlag versetzt! Ihr habt Euch als w�rdige Champions erwiesen. Gemeinsam werden wir den Angriff auf die Eiskronenzitadelle durchf�hren und den Rest der Gei�el zerst�ren! Gemeinsam meistern wir alles!', null, null, null, null, null, '16051', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600241', 'You will have your challenge, Fordring.', null, null, 'Ihr werdet Eure Herausforderung bekommen, Fordring.', null, null, null, null, null, '16321', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600242', 'Arthas! You are hopelessly outnumbered! Lay down Frostmourne and I will grant you a just death.', null, null, 'Arthas! Wir sind Euch zahlenm��ig �berlegen! Legt Frostgram nieder und ich werde Euch einen gerechten Tod gew�hren.', null, null, null, null, null, '16052', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600243', 'The Nerubians built an empire beneath the frozen wastes of Northrend. An empire that you so foolishly built your structures upon. MY EMPIRE.', null, null, 'Die Neruber erbauten ein K�nigreich unter den gefrorenen Ein�den Nordens. Ein K�nigreich, auf dem Ihr so t�richt Euren Spielplatz aufgebaut habt, AUF MEINEM K�NIGREICH.', null, null, null, null, null, '16322', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600244', 'The souls of your fallen champions will be mine, Fordring.', null, null, 'Die Seelen Eurer gefallenen Champions werden mir geh�ren, Fordering.', null, null, null, null, null, '16323', '1', '0', '0', null);
-- 1600245 Anubarak Intro
INSERT INTO `script_texts` VALUES ('0', '-1600246', 'The loss of Wilfred Fizzlebang, while unfortunate, should be a lesson to those that dare dabble in dark magic. Alas, you are victorious and must now face the next challenge. ', null, null, 'Der Verlust von Wilfred Fizzlebang sollte jeden unter euch eine Lehre sein, die es wagen mit den dunklen k�nsten herumzuspielen. Jedoch ihr seid Siegreich und ihr m�sst nun die n�chste Herausforderung antreten.', null, null, null, null, null, '16045', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600247', 'Treacherous Alliance dogs! You summon a demon lord against warriors of the Horde!? Your deaths will be swift! ', null, null, 'Hinterh�ltige Allianz Hunde! Ihr beschw�rt einen D�monenlord gegen die Krieger der Horde! Ihr werdet einen schnellen Tot finden.', null, null, null, null, null, '16021', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600248', 'The Alliance doesn\'t need the help of a demon lord to deal with Horde filth. Come, pig! ', null, null, 'Die Allianz braucht keinen D�mon zur unterst�tzung gegen Hordendreck! Komm her Schwein!', null, null, null, null, null, '16064', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600249', 'Everyone, calm down! Compose yourselves! There is no conspiracy at play here. The warlock acted on his own volition - outside of influences from the Alliance. The tournament must go on! ', null, null, 'Ihr alle beruhigt euch. Hier ist keine Verschw�rung ingange der Hexenmeister handelte aus eigenen willen heraus unabh�ngig von der Allianz! Das Tunier muss weitergehen.', null, null, null, null, null, '16046', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600250', 'A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death.', null, null, null, null, null, null, null, null, '16049', '1', '0', '0', null);
-- -1600251 Northrend Beast Wipe
INSERT INTO `script_texts` VALUES ('0', '-1600252', 'In the name of our dark master. For the Lich King. You. Will. Die.', null, null, null, null, null, null, null, null, '16272', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600253', 'CHAOS!', null, null, null, null, null, null, null, null, '16274', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600254', 'The Scourge cannot be stopped...', null, null, null, null, null, null, null, null, '16275', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600255', 'UNWORTHY!', null, null, null, null, null, null, null, null, '16276', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600256', 'You have been measured, and found wanting!', null, null, null, null, null, null, null, null, '16277', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600257', 'Let the dark consume you!', null, null, null, null, null, null, null, null, '16278', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('0', '-1600258', 'Let the light consume you!', null, null, null, null, null, null, null, null, '16279', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('34564', '-1713554', 'Ahhh... Our guests arrived, just as the master promised.', null, null, null, null, null, null, null, null, '16235', '1', '0', '0', null);
INSERT INTO `script_texts` VALUES ('34564', '-1713555', 'This place will serve as your tomb!', null, null, null, null, null, null, null, null, '16234', '1', '0', '0', null);


-- Some cleanup
UPDATE `creature_template` SET `ScriptName`= '' WHERE `entry` IN (33365,33370,33312,33367,33686,33579,34275,33214);
UPDATE `gameobject_template` SET `ScriptName`= '' WHERE `entry` IN (194375,194371,194370,194377);
DELETE FROM `areatrigger_scripts` WHERE `entry` IN (5369,5423);
DELETE FROM `script_waypoint` WHERE `entry`=33370;

DELETE FROM areatrigger_scripts WHERE `entry`=4156;
INSERT INTO areatrigger_scripts VALUES (4156,'at_naxxramas_frostwyrm_wing');

UPDATE `instance_template` SET `script`='instance_ulduar' WHERE `map`=603;
UPDATE `creature_template` SET `ScriptName`='boss_auriaya' WHERE `entry`=33515;
UPDATE `creature_template` SET `ScriptName`='boss_flame_leviathan' WHERE `entry`=33113;
UPDATE `creature_template` SET `AIName`='TurretAI',`ScriptName`='' WHERE `entry`=33139;
UPDATE `creature_template` SET `ScriptName`='boss_flame_leviathan_seat' WHERE `entry`=33114;
UPDATE `creature_template` SET `ScriptName`='boss_flame_leviathan_defense_turret' WHERE `entry`=33142;
UPDATE `creature_template` SET `ScriptName`='boss_flame_leviathan_overload_device' WHERE `entry`=33143;
UPDATE `creature_template` SET `ScriptName`='spell_pool_of_tar' WHERE `entry`=33090;
UPDATE `creature_template` SET `ScriptName`='boss_ignis' WHERE `entry`=33118;
UPDATE `creature_template` SET `ScriptName`='boss_razorscale' WHERE `entry`=33186;
UPDATE `creature_template` SET `ScriptName`='boss_xt002' WHERE `entry`=33293;
UPDATE `creature_template` SET `ScriptName`='mob_xt002_heart' WHERE `entry`=33329;
UPDATE `creature_template` SET `ScriptName`='mob_scrapbot' WHERE `entry`=33343;
UPDATE `creature_template` SET `ScriptName`='mob_pummeller' WHERE `entry`=33344;
UPDATE `creature_template` SET `ScriptName`='mob_boombot' WHERE `entry`=33346;
UPDATE `creature_template` SET `ScriptName`='mob_void_zone' WHERE `entry`=34001;
UPDATE `creature_template` SET `ScriptName`='mob_life_spark' WHERE `entry`=34004;
UPDATE `creature_template` SET `ScriptName`='mob_rune_of_summoning' WHERE `entry`=33051;
UPDATE `creature_template` SET `ScriptName`='boss_algalon' WHERE `entry`=32871;
UPDATE `creature_template` SET `ScriptName`='mob_collapsing_star' WHERE `entry`=32955;
UPDATE `gameobject_template` SET `ScriptName`='ulduar_teleporter' WHERE `entry`=194569;
UPDATE `creature_template` SET `spell1`=62402 WHERE `entry`=33142;
UPDATE `creature_template` SET `spell1`=62402 WHERE `entry`=33139;
UPDATE `creature_template` SET `spell1`=62402 WHERE `entry`=34111;
UPDATE `creature_template` SET `spell1`=62402 WHERE `entry`=34224;

-- Leviathan Torret 33139
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=83,`exp`=2,`unit_class`=1 WHERE `entry` IN (33139, 34111);
-- Leviathan Torret 33142
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=83,`exp`=2,`unit_class`=1 WHERE `entry` IN (33142);

-- 7770_ignis_vehicleid
UPDATE `creature_template` SET `vehicleId` = 318 WHERE `entry` = 33118;

-- 7792
DELETE FROM `creature_template` WHERE `entry` IN (33119);
INSERT INTO `creature_template` VALUES
('33119','0','0','0','0','0','13069','0','0','0','Scorch trigger','',NULL,'0','83','83','2','16','16','0','2','2','85','3','0','0','0','0','0','0','0','8','34340934','0','0','0','0','0','0','0','0','0','7','0','0','0','0','0','0','0','0','0','0','62548','0','0','0','0','0','0','0','0','0','1305000','1595000','EventAI','0','3','310','30','1','0','0','0','0','0','0','0','169','1','0','617299803','1','trigger_periodic','0');

DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33119);
INSERT INTO `creature_ai_scripts` VALUES 
( 10033119, 33119, 0, 0, 100, 3, 1000, 1000, 1000, 1000, 11, 62548, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scorch Ground');

UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35, `unit_flags` = 33554434, `ScriptName` = 'mob_iron_construct', `flags_extra` = 0 WHERE `entry` = 33121;

-- 7796_xt002_vehicleid
UPDATE `creature_template` SET `vehicleId` = 332 WHERE `entry` = 33293;

-- 7930_leviathan_trigger
DELETE FROM `creature_template` WHERE `entry` IN (33115);
INSERT INTO `creature_template` VALUES
('33115','0','0','0','0','0','13069','0','0','0','Leviathan trigger','',NULL,'0','83','83','2','16','16','0','2','2','1','3','0','0','0','0','0','0','0','8','34340934','0','0','0','0','0','0','0','0','0','7','0','0','0','0','0','0','0','0','0','0','62548','0','0','0','0','0','0','0','0','0','1305000','1595000','','0','3','310','30','1','0','0','0','0','0','0','0','169','1','0','617299803','1','flame_leviathan_trigger','0');

DELETE FROM creature WHERE `id` IN (33115, 33060, 33062, 33109);
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES (33115,603,1,1,0,0,-784.969,-135.608,429.774,0.351076,480000,0,0,3458360,279750,0,0);

-- 8042_boss_leviathan
DELETE FROM `creature_template` WHERE `entry` IN (33240);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES('33240','33240','0','0','0','0','28517','0','0','0','Ulduar Colossus','','','0','80','80','2','1692','1692','0','1.2','1.14286','1','1','422','586','0','642','7.5','2000','0','1','32832','0','0','0','0','0','0','345','509','103','5','524352','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','125','1','1','0','0','0','0','0','0','0','124','1','0','0','0','mob_colossus','11403');
-- ubicaci�n Leviathan
DELETE FROM `creature` WHERE `id`=33113;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(94374, 33113, 603, 1, 1, 0, 0, 435.89, -8.417, 409.886, 3.12723, 480000, 0, 0, 23009250, 0, 0, 0);
-- Refuerzo orbital
UPDATE `creature_template` SET `unit_flags` = 33685510, `type_flags` = 0 WHERE `entry` = 34286;

-- 8047_ignis_scorchground
DELETE FROM `creature_template` WHERE `entry` IN (33119);
INSERT INTO `creature_template` VALUES
('33119','0','0','0','0','0','13069','0','0','0','Scorch trigger','','','0','80','80','2','16','16','0','1','1.14286','85','1','0','0','0','0','1','2000','0','1','0','0','0','0','0','0','0','0','0','0','4','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','4','1','1','0','0','0','0','0','0','0','94','1','0','0','0','mob_scorch_ground','11159');

DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33119);

-- 8086_razorscale_event
UPDATE `creature_template` SET `ScriptName` = 'mob_darkrune_watcher' WHERE `entry` = 33453;
UPDATE `creature_template` SET `ScriptName` = 'mob_darkrune_sentinel' WHERE `entry` = 33846;
UPDATE `creature_template` SET `ScriptName` = 'mob_darkrune_guardian' WHERE `entry` = 33388;
UPDATE `creature_template` SET `ScriptName` = 'mob_devouring_flame' WHERE `entry` = 34188;
UPDATE `creature_template` SET `ScriptName` = 'npc_expedition_commander_ulduar' WHERE `entry` = 33210;
UPDATE `creature_template` SET `ScriptName` = 'mole_machine_trigger' WHERE `entry` = 33282;
UPDATE `creature_template` SET `unit_flags` = 33685506 WHERE `entry` IN (33245,33233);
DELETE FROM `creature` WHERE `id`=33186;

-- 8093_razorscale_triggers
DELETE FROM `creature` WHERE `id`=33282;
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` IN (33233,33259);

-- 8098_kologarn_event
DELETE FROM `creature` WHERE `id` IN (33632, 33802);
UPDATE `creature_template` SET `unit_flags` = 33685510 WHERE `entry` = 33809;
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` = 33661;
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `ScriptName` = 'mob_focused_eyebeam' WHERE `entry` IN (33632, 33802);
UPDATE `creature_template` SET `ScriptName` = 'mob_left_arm' WHERE `entry` = 32933;
UPDATE `creature_template` SET `ScriptName` = 'mob_right_arm' WHERE `entry` = 32934;

/*
-- 8117_ignis_heat
DELETE FROM spell_script_target WHERE entry = 62343;
INSERT INTO spell_script_target VALUES (62343, 1, 33121);
*/
UPDATE `creature_template` SET `unit_flags` = 33947654 WHERE `entry` = 33121;

-- 8119_assembly_iron
UPDATE `creature_template` SET `ScriptName` = 'boss_steelbreaker' WHERE `entry` = 32867;
UPDATE `creature_template` SET `ScriptName` = 'boss_runemaster_molgeim' WHERE `entry` = 32927;
UPDATE `creature_template` SET `ScriptName` = 'boss_stormcaller_brundir' WHERE `entry` = 32857;

UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` IN (33051, 33691, 33689);
UPDATE creature_template SET faction_A=16, faction_H=16, scriptname='mob_rune_of_power' WHERE entry = 33705;
UPDATE creature_template SET faction_A=16, faction_H=16, scriptname='mob_lightning_elemental', difficulty_entry_1 = 33689 WHERE entry = 32958;

-- 8124_auriaya_event
DELETE FROM `creature` WHERE id = 34014;
UPDATE `creature_template` SET `unit_flags` = 0, `type_flags` = 0 WHERE `entry` = 33515;
UPDATE `creature_template` SET `equipment_id` = 2500 WHERE `entry` = 33515;

UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `ScriptName` = 'feral_defender_trigger' WHERE `entry` = 34096;
UPDATE `creature_template` SET `ScriptName` = 'mob_feral_defender' WHERE `entry` = 34035;
UPDATE `creature_template` SET `ScriptName` = 'mob_sanctum_sentry' WHERE `entry` = 34014;
UPDATE `creature_template` SET `ScriptName` = 'seeping_trigger' WHERE `entry` = 34098;

DELETE FROM `creature_equip_template` WHERE entry = 2500;
INSERT INTO `creature_equip_template` VALUES ('2500','45315','0','0');

DELETE FROM `creature_addon` WHERE guid = 137496;
INSERT INTO `creature_addon` VALUES ('137496','1033515','0','0','0','0','0');

DELETE FROM `waypoint_data` WHERE id = 1033515;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) VALUES
('1033515','1','1968.46','51.75','417.72','0','0','0','100','0'),
('1033515','2','1956.75','49.22','411.35','0','0','0','100','0'),
('1033515','3','1938.90','42.09','411.35','3000','0','0','100','0'),
('1033515','4','1956.75','49.22','411.35','0','0','0','100','0'),
('1033515','5','1968.46','51.75','417.72','0','0','0','100','0'),
('1033515','6','2011.43','44.91','417.72','0','0','0','100','0'),
('1033515','7','2022.65','37.74','411.36','0','0','0','100','0'),
('1033515','8','2046.65','9.61','411.36','0','0','0','100','0'),
('1033515','9','2053.4','-8.65','421.68','0','0','0','100','0'),
('1033515','10','2053.14','-39.8','421.66','0','0','0','100','0'),
('1033515','11','2046.26','-57.96','411.35','0','0','0','100','0'),
('1033515','12','2022.42','-86.39','411.35','0','0','0','100','0'),
('1033515','13','2011.26','-92.95','417.71','0','0','0','100','0'),
('1033515','14','1969.43','-100.02','417.72','0','0','0','100','0'),
('1033515','15','1956.66','-97.4','411.35','0','0','0','100','0'),
('1033515','16','1939.18','-90.90','411.35','3000','0','0','100','0'),
('1033515','17','1956.66','-97.4','411.35','0','0','0','100','0'),
('1033515','18','1969.43','-100.02','417.72','0','0','0','100','0'),
('1033515','19','2011.26','-92.95','417.71','0','0','0','100','0'),
('1033515','20','2022.42','-86.39','411.35','0','0','0','100','0'),
('1033515','21','2046.26','-57.96','411.35','0','0','0','100','0'),
('1033515','22','2053.14','-39.8','421.66','0','0','0','100','0'),
('1033515','23','2053.4','-8.65','421.68','0','0','0','100','0'),
('1033515','24','2046.65','9.61','411.36','0','0','0','100','0'),
('1033515','25','2022.65','37.74','411.36','0','0','0','100','0'),
('1033515','26','2011.43','44.91','417.72','0','0','0','100','0');

-- 9130_auriaya_fix
UPDATE `creature` SET `MovementType` = 2 WHERE `id` = 33515;

-- 8137_leviathan_vehiclesystem
UPDATE `creature_template` SET `unit_flags` = 0, `npcflag` = 1, `ScriptName` = 'npc_keeper_norgannon' WHERE `entry` = 33686;
DELETE FROM `creature_template` WHERE `entry`=33115;
DELETE FROM creature WHERE `id`=33115;

-- 8148_boss_hodir
UPDATE `creature_template` SET `unit_flags` = 0, `type_flags` = 0, `ScriptName` = 'boss_hodir' WHERE `entry` = 32845;

UPDATE `creature_template` SET `modelid1` = 11686, `modelid2` = 0 WHERE `entry` IN (34188, 33632, 33802, 34096, 34098);
UPDATE `creature_template` SET `modelid1` = 25865, `modelid2` = 0, `flags_extra` = 0, `ScriptName` = 'mob_flash_freeze' WHERE `entry` = 32938;
UPDATE `creature_template` SET `modelid1` = 28470, `modelid2` = 0, `ScriptName` = 'mob_icicle' WHERE `entry` = 33169;
UPDATE `creature_template` SET `modelid1` = 28470, `modelid2` = 0, `ScriptName` = 'mob_icicle_snowdrift' WHERE `entry` = 33173;
UPDATE `creature_template` SET `modelid1` = 15880, `modelid2` = 0 WHERE `entry` = 33174;
UPDATE `gameobject_template` SET `flags` = 4 WHERE `entry` = 194173;

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 61990;
INSERT INTO `spell_linked_spell` VALUES 
(61990, -62457, 2, "Ice Shards Immunity (Hodir)"),
(61990, -65370, 2, "Ice Shards Immunity (Hodir)");

UPDATE `creature_template` SET `unit_flags` = 33817094 WHERE `entry` = 33174;
UPDATE `creature_template` SET `mechanic_immune_mask` = 612581215 WHERE `entry` = 32938;
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` = 32941;
UPDATE `creature_template` SET `unit_flags` = 33686016, `flags_extra` = 2 WHERE `entry` = 30298;

DELETE FROM `creature` WHERE `id` = 32938;

-- 8153_razorscale_event
DELETE FROM `creature` WHERE `id`=33186;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(94373, 33186, 603, 1, 1, 0, 0, 587.073, -203.205, 441.237, 1.60532, 604800, 0, 0, 3555975, 0, 0, 0);

UPDATE `creature_template` SET `unit_flags` = 33554438 WHERE `entry` = 33184;

-- 8155_hodir_npcs
UPDATE `creature_template` SET `unit_flags` = 393220, `ScriptName` = '' WHERE `entry` = 32938;
UPDATE `creature_template` SET `unit_flags` = 33948166 WHERE `entry` = 33174;

DELETE FROM `creature` WHERE `id` IN (32941, 33333, 33332, 32950, 33331, 32946, 32948, 33330);

UPDATE `creature_template` SET `faction_A` = 1665, `faction_H` = 1665, `unit_flags` = 32768 WHERE `entry` IN (33325, 32901, 33328, 32901, 32893, 33327, 32897, 33326, 32941, 33333, 33332, 32950, 33331, 32946, 32948, 33330);
UPDATE `creature_template` SET `ScriptName` = 'mob_hodir_priest' WHERE `entry` IN (32897, 33326, 32948, 33330);
UPDATE `creature_template` SET `ScriptName` = 'mob_hodir_shaman' WHERE `entry` IN (33328, 32901, 33332, 32950);
UPDATE `creature_template` SET `ScriptName` = 'mob_hodir_druid' WHERE `entry` IN (33325, 32900, 32941, 33333);
UPDATE `creature_template` SET `ScriptName` = 'mob_hodir_mage' WHERE `entry` IN (32893, 33327, 33331, 32946);
UPDATE `creature_template` SET `modelid1` = 15880, `modelid2` = 0, `ScriptName` = 'toasty_fire' WHERE `entry` = 33342;

-- 8164_ulduar_immunities
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235 WHERE `entry` IN (33113, 33118, 33186, 33293, 32867, 32927, 32930, 33515, 32906, 32845, 33350, 32865, 33271, 33288, 32871);
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299547 WHERE `entry` = 32857;

UPDATE `script_texts` SET `content_default` = "Welcome, champions! All of our attempts at grounding her have failed. We could use a hand in bring her down with these harpoon guns.", `type` = 0  WHERE `entry` = -1603260;
UPDATE `script_texts` SET `content_default` = "Move! Quickly! She won�t remain grounded for long.", `type` = 1  WHERE `entry` = -1603261;
UPDATE `script_texts` SET `type` = 2  WHERE `entry` = -1603053;
UPDATE `script_texts` SET `type` = 2  WHERE `entry` = -1603214;

-- 8166_hodir_flashfreeze
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (61990, -61990);
INSERT INTO `spell_linked_spell` VALUES 
(61990, 7940, 2, "Hodir Flash Freeze immunity");

-- 8172_freya_elders
UPDATE `creature_template` SET `ScriptName` = 'boss_elder_brightleaf' WHERE `entry` =32915;
UPDATE `creature_template` SET `ScriptName` = 'boss_elder_ironbranch' WHERE `entry` =32913;
UPDATE `creature_template` SET `ScriptName` = 'boss_elder_stonebark' WHERE `entry` =32914;
UPDATE `creature_template` SET `ScriptName` = 'creature_sun_beam', `unit_flags` = 33685510, `modelid1` = 11686, `modelid2` = 0 WHERE `entry` =33170;
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `unit_flags` = 393220, `ScriptName` = 'creature_iron_roots' WHERE `entry` = 33168;

DELETE FROM `spell_linked_spell` WHERE `spell_effect` = -62243;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(62217, -62243, 1, 'cancels the effects of Unstable Sun Beam'),
(62922, -62243, 1, 'cancels the effects of Unstable Sun Beam');

-- 8178_boss_freya
UPDATE `creature_template` SET `ScriptName` = 'boss_freya' WHERE `entry` =32906;
UPDATE `creature_template` SET `unit_flags` = 393220, `ScriptName` = 'creature_eonars_gift' WHERE `entry` =33228;
UPDATE `creature_template` SET `modelid1` = 11686, `modelid2` = 0, `unit_flags` = 33685508, `ScriptName` = 'creature_nature_bomb' WHERE `entry` =34129;
UPDATE `creature_template` SET `unit_class` = 2, `ScriptName` = 'creature_detonating_lasher' WHERE `entry` =32918;
UPDATE `creature_template` SET `ScriptName` = 'creature_ancient_conservator' WHERE `entry` =33203;
UPDATE `creature_template` SET `unit_flags` = 33686022, `ScriptName` = 'creature_healthy_spore' WHERE `entry` =33215;
UPDATE `creature_template` SET `ScriptName` = 'creature_storm_lasher' WHERE `entry` =32919;
UPDATE `creature_template` SET `ScriptName` = 'creature_snaplasher' WHERE `entry` =32916;
UPDATE `creature_template` SET `ScriptName` = 'creature_ancient_water_spirit' WHERE `entry` =33202;

DELETE FROM `creature` WHERE `guid` = 136607;

DELETE FROM `spell_linked_spell` WHERE `spell_effect` = -62532;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(64321, -62532, 1, 'Potent Pheromones ward off the Conservator''s Grip'),
(62619, -62532, 1, 'Pheromones ward off the Conservator''s Grip');

-- 8195_freya_event
UPDATE `creature_template` SET `modelid1` = 11686, `modelid2` = 0, `unit_flags` = 33686022, `ScriptName` = 'creature_unstable_sun_beam' WHERE `entry` = 33050;

-- 8199_ulduar_cleanup
DELETE FROM `gameobject` WHERE `id` = '194905';
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
('270000','194905','603','1','1','401.308','-13.8236','409.524','3.14159','0','0','0','1','180','255','0');

UPDATE `creature_template` SET `speed_walk` = 0.5 WHERE `entry` = 33113;
UPDATE `creature_template` SET `unit_flags` = 0, `type_flags` = 8, `ScriptName` = 'boss_thorim' WHERE `entry` = 32865;

-- 8228_ignis_scorch
UPDATE `creature_template` SET `modelid1` = 16925, `modelid2` = 0, `ScriptName` = 'mob_scorch_ground' WHERE `entry` = 33221;
DELETE FROM `creature_template` WHERE `entry` = 33119;

-- 8241_thorim_gate
DELETE FROM `gameobject_scripts` WHERE `id`=55194;
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES 
(55194, 0, 11, 34155, 15, '0', 0, 0, 0, 0);

UPDATE `gameobject` SET `id` = 101855, `rotation2` = 1, `rotation3` = 0, `spawntimesecs` = 7200, `animprogress` = 100 WHERE `guid` = 55194;

-- 8252_boss_thorim
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `ScriptName` = 'mob_pre_phase' WHERE `entry` IN (32882, 32908, 32885, 33110);
UPDATE `creature_template` SET `unit_flags` = 0, `faction_A` = 14, `faction_H` = 14, `ScriptName` = 'mob_arena_phase' WHERE `entry` IN (32876, 32904, 32878, 32877, 32874, 32875);

UPDATE `creature` SET `spawndist` = 0 WHERE `id` = 32865;
UPDATE `creature` SET `position_x` = 2135.078, `position_y` = -298.758, `orientation` = 1.61 WHERE `id` = 32865;

DELETE FROM `creature` WHERE `id` IN (32882, 32908, 32885, 32879, 33140, 33141);

UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` IN (32892, 32879, 32780, 33140, 33141);

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=62042;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
('62042','62470','1','Thorim: Deafening Thunder');

UPDATE `creature_template` SET `unit_flags` = 33686020 WHERE `entry` = 33378;

DELETE FROM `creature` WHERE `id` IN (33378, 32892);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(131835, 33378, 603, 1, 1, 16925, 0, 2104.99, -233.484, 433.573, 5.49779, 604800, 0, 0, 12600, 0, 0, 1),
(131836, 33378, 603, 1, 1, 16925, 0, 2092.64, -262.594, 433.576, 6.26573, 604800, 0, 0, 12600, 0, 0, 1),
(131837, 33378, 603, 1, 1, 16925, 0, 2104.76, -292.719, 433.181, 0.785398, 604800, 0, 0, 12600, 0, 0, 1),
(131839, 33378, 603, 1, 1, 16925, 0, 2164.97, -293.375, 433.526, 2.35619, 604800, 0, 0, 12600, 0, 0, 1),
(131840, 33378, 603, 1, 1, 16925, 0, 2164.58, -233.333, 433.892, 3.90954, 604800, 0, 0, 12600, 0, 0, 1),
(131841, 33378, 603, 1, 1, 16925, 0, 2145.8, -222.196, 433.293, 4.45059, 604800, 0, 0, 12600, 0, 0, 1),
(131842, 33378, 603, 1, 1, 16925, 0, 2123.91, -222.443, 433.375, 4.97419, 604800, 0, 0, 12600, 0, 0, 1);

/*
DELETE FROM `spell_script_target` WHERE `entry`=62016;
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`) VALUES('62016','1','33378');
*/
UPDATE `creature_template` SET `unit_flags` = 0, `ScriptName` = 'mob_runic_colossus' WHERE `entry` = 32872;
UPDATE `creature_template` SET `unit_flags` = 0, `ScriptName` = 'mob_rune_giant' WHERE `entry` = 32873;
UPDATE `creature_template` SET `modelid1` = 16925, `modelid2` = 0, `ScriptName` = 'thorim_trap_bunny' WHERE `entry` IN (33725, 33282);
UPDATE `creature_template` SET `flags_extra` = 0, `ScriptName` = 'thorim_energy_source' WHERE `entry` = 32892;
UPDATE `creature_template` SET `ScriptName` = 'boss_thorim' WHERE `entry` = 32865;

-- 8262_thorim_event
DELETE FROM `creature` WHERE `id` IN (33378, 32892);
UPDATE `creature_template` SET `modelid1` = 16925, `modelid2` = 0 WHERE `entry`IN (33378, 32892);

DELETE FROM `creature` WHERE `id` IN (32922, 32923, 32925);
SET @GUID := 200400;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) values 
(@GUID,32922,603,1,1,25984,0,2110.24,-213.923,436.857,5.16617,604800,0,0,80886,0,0,0),
(@GUID+1,32922,603,1,1,25984,0,2095.97,-213.634,445.036,5.37561,604800,0,0,80886,0,0,0),
(@GUID+2,32922,603,1,1,25984,0,2076.95,-244.528,442.998,5.96903,604800,0,0,80886,0,0,0),
(@GUID+3,32922,603,1,1,25984,0,2077.98,-272.724,438.925,0.191986,604800,0,0,80886,0,0,0),
(@GUID+4,32922,603,1,1,25984,0,2087.4,-301.326,443.005,0.698132,604800,0,0,80886,0,0,0),
(@GUID+5,32922,603,1,1,25984,0,2091.17,-286.804,430.781,0.523599,604800,0,0,80886,0,0,0),
(@GUID+6,32922,603,1,1,25984,0,2177.83,-295.005,434.846,2.35619,604800,0,0,80886,0,0,0),
(@GUID+7,32922,603,1,1,25984,0,2189.87,-278.583,438.928,2.87979,604800,0,0,80886,0,0,0),
(@GUID+8,32922,603,1,1,25984,0,2197.19,-256.436,445.037,3.24631,604800,0,0,80886,0,0,0),
(@GUID+9,32922,603,1,1,25984,0,2185.87,-254.436,432.798,3.29867,604800,0,0,80886,0,0,0),
(@GUID+10,32922,603,1,1,25984,0,2179.62,-227.25,442.009,3.89208,604800,0,0,80886,0,0,0),
(@GUID+11,32922,603,1,1,25984,0,2161.18,-218.451,432.811,4.17134,604800,0,0,80886,0,0,0),
(@GUID+12,32923,603,1,1,28580,0,2193.75,-292.545,449.069,3.21141,180,0,0,18900,0,0,0),
(@GUID+13,32923,603,1,1,28580,0,2178.55,-286.8,430.795,2.51327,180,0,0,18900,0,0,0),
(@GUID+14,32923,603,1,1,28580,0,2178.61,-299.455,438.917,2.30383,180,0,0,18900,0,0,0),
(@GUID+15,32923,603,1,1,28580,0,2186.39,-292.184,440.98,2.51327,180,0,0,18900,0,0,0),
(@GUID+16,32923,603,1,1,28580,0,2184.1,-304.141,447.037,2.32129,180,0,0,18900,0,0,0),
(@GUID+17,32923,603,1,1,28580,0,2185.45,-274.37,432.804,2.93215,180,0,0,18900,0,0,0),
(@GUID+18,32923,603,1,1,28580,0,2189.09,-274.368,436.838,2.94961,180,0,0,18900,0,0,0),
(@GUID+19,32923,603,1,1,28580,0,2193.43,-266.823,440.96,3.08923,180,0,0,18900,0,0,0),
(@GUID+20,32923,603,1,1,28580,0,2192.18,-282.637,442.998,2.82743,180,0,0,18900,0,0,0),
(@GUID+21,32923,603,1,1,28580,0,2199.59,-279.142,449.1,2.9147,180,0,0,18900,0,0,0),
(@GUID+22,32923,603,1,1,28580,0,2199.07,-267.828,447.077,3.07178,180,0,0,18900,0,0,0),
(@GUID+23,32923,603,1,1,28580,0,2184.24,-269.38,430.788,3.01942,180,0,0,18900,0,0,0),
(@GUID+24,32923,603,1,1,28580,0,2185.79,-278.182,434.833,2.86234,180,0,0,18900,0,0,0),
(@GUID+25,32923,603,1,1,28580,0,2191.54,-269.729,438.919,3.03687,180,0,0,18900,0,0,0),
(@GUID+26,32923,603,1,1,28580,0,2194.43,-276.351,442.961,2.93215,180,0,0,18900,0,0,0),
(@GUID+27,32923,603,1,1,28580,0,2196.2,-281.951,447.042,2.86234,180,0,0,18900,0,0,0),
(@GUID+28,32923,603,1,1,28580,0,2200.95,-267.306,449.114,3.08923,180,0,0,18900,0,0,0),
(@GUID+29,32923,603,1,1,28580,0,2181.97,-248.535,430.753,3.4383,180,0,0,18900,0,0,0),
(@GUID+30,32923,603,1,1,28580,0,2185.63,-247.405,434.837,3.4383,180,0,0,18900,0,0,0),
(@GUID+31,32923,603,1,1,28580,0,2189.51,-258.295,436.863,3.22886,180,0,0,18900,0,0,0),
(@GUID+32,32923,603,1,1,28580,0,2200.71,-251.84,449.088,3.29867,180,0,0,18900,0,0,0),
(@GUID+33,32923,603,1,1,28580,0,2194.08,-243.276,445.031,3.45575,180,0,0,18900,0,0,0),
(@GUID+34,32923,603,1,1,28580,0,2195.15,-251.153,442.98,3.33358,180,0,0,18900,0,0,0),
(@GUID+35,32923,603,1,1,28580,0,2178.26,-234.068,439.581,3.49066,180,0,0,18900,0,0,0),
(@GUID+36,32923,603,1,1,28580,0,2181.94,-238.58,434.834,3.61283,180,0,0,18900,0,0,0),
(@GUID+37,32923,603,1,1,28580,0,2182.5,-234.925,445.771,3.66519,180,0,0,18900,0,0,0),
(@GUID+38,32923,603,1,1,28580,0,2187.5,-232.918,456.92,3.38594,180,0,0,18900,0,0,0),
(@GUID+39,32923,603,1,1,28580,0,2184.62,-222.366,457.92,4.2237,180,0,0,18900,0,0,0),
(@GUID+40,32923,603,1,1,28580,0,2191.95,-229.319,468.174,3.54302,180,0,0,18900,0,0,0),
(@GUID+41,32923,603,1,1,28580,0,2161.32,-222.722,428.718,4.24115,180,0,0,18900,0,0,0),
(@GUID+42,32923,603,1,1,28580,0,2165.7,-216.552,437.482,4.11898,180,0,0,18900,0,0,0),
(@GUID+43,32923,603,1,1,28580,0,2172.48,-215.681,446.296,4.03171,180,0,0,18900,0,0,0),
(@GUID+44,32923,603,1,1,28580,0,2170.81,-208.646,447.254,4.11898,180,0,0,18900,0,0,0),
(@GUID+45,32923,603,1,1,28580,0,2164.44,-204.417,449.036,4.2237,180,0,0,18900,0,0,0),
(@GUID+46,32923,603,1,1,28580,0,2109.83,-216.211,434.81,5.20108,180,0,0,18900,0,0,0),
(@GUID+47,32923,603,1,1,28580,0,2100.14,-217.783,438.879,5.35816,180,0,0,18900,0,0,0),
(@GUID+48,32923,603,1,1,28580,0,2101.65,-211.524,442.959,5.2709,180,0,0,18900,0,0,0),
(@GUID+49,32923,603,1,1,28580,0,2105.1,-204.009,449.074,5.16617,180,0,0,18900,0,0,0),
(@GUID+50,32923,603,1,1,28580,0,2105.72,-213.887,438.883,5.23599,180,0,0,18900,0,0,0),
(@GUID+51,32923,603,1,1,28580,0,2093.1,-235.128,430.762,5.70723,180,0,0,18900,0,0,0),
(@GUID+52,32923,603,1,1,28580,0,2086.43,-236.845,436.861,5.79449,180,0,0,18900,0,0,0),
(@GUID+53,32923,603,1,1,28580,0,2090.16,-227.646,438.9,5.61996,180,0,0,18900,0,0,0),
(@GUID+54,32923,603,1,1,28580,0,2083.78,-233.255,440.947,5.75959,180,0,0,18900,0,0,0),
(@GUID+55,32923,603,1,1,28580,0,2082.41,-227.753,444.991,5.68977,180,0,0,18900,0,0,0),
(@GUID+56,32923,603,1,1,28580,0,2083.46,-220.87,449.11,5.32325,180,0,0,18900,0,0,0),
(@GUID+57,32923,603,1,1,28580,0,2085.77,-278.108,432.796,0.314159,180,0,0,18900,0,0,0),
(@GUID+58,32923,603,1,1,28580,0,2082.43,-279.181,436.843,0.314159,180,0,0,18900,0,0,0),
(@GUID+59,32923,603,1,1,28580,0,2080.09,-268.561,436.861,0.122173,180,0,0,18900,0,0,0),
(@GUID+60,32923,603,1,1,28580,0,2076.67,-281.238,443.013,0.314159,180,0,0,18900,0,0,0),
(@GUID+61,32923,603,1,1,28580,0,2070.95,-275.786,447.029,0.314159,180,0,0,18900,0,0,0),
(@GUID+62,32923,603,1,1,28580,0,2073.01,-269.083,444.984,0.10472,180,0,0,18900,0,0,0),
(@GUID+63,32923,603,1,1,28580,0,2085.04,-249.688,432.797,6.02139,180,0,0,18900,0,0,0),
(@GUID+64,32923,603,1,1,28580,0,2081.76,-248.184,436.858,6.00393,180,0,0,18900,0,0,0),
(@GUID+65,32923,603,1,1,28580,0,2076.05,-253.313,440.97,6.10865,180,0,0,18900,0,0,0),
(@GUID+66,32923,603,1,1,28580,0,2072.73,-250.245,445.018,6.07375,180,0,0,18900,0,0,0),
(@GUID+67,32923,603,1,1,28580,0,2071.74,-242.53,449.109,5.98648,180,0,0,18900,0,0,0),
(@GUID+68,32923,603,1,1,28580,0,2086.54,-289.927,436.879,0.523599,180,0,0,18900,0,0,0),
(@GUID+69,32923,603,1,1,28580,0,2096.15,-293.986,430.76,0.698132,180,0,0,18900,0,0,0),
(@GUID+70,32923,603,1,1,28580,0,2090.54,-299.068,438.92,0.698132,180,0,0,18900,0,0,0),
(@GUID+71,32923,603,1,1,28580,0,2082.36,-289.917,440.969,0.488692,180,0,0,18900,0,0,0),
(@GUID+72,32923,603,1,1,28580,0,2091.47,-291.981,432.8,0.610865,180,0,0,18900,0,0,0),
(@GUID+73,32923,603,1,1,28580,0,2081.7,-300.628,447.058,0.628319,180,0,0,18900,0,0,0),
(@GUID+74,32925,603,1,1,28581,0,2187.69,-270.488,434.832,3.01942,604800,0,0,40443,4169,0,0),
(@GUID+75,32925,603,1,1,28581,0,2193.33,-257.943,440.949,3.22886,604800,0,0,40443,4169,0,0),
(@GUID+76,32925,603,1,1,28581,0,2191.72,-247.573,440.946,3.40339,604800,0,0,40443,4169,0,0),
(@GUID+77,32925,603,1,1,28581,0,2181.61,-224.316,447.512,3.82227,604800,0,0,40443,4169,0,0),
(@GUID+78,32925,603,1,1,28581,0,2178.52,-240.156,430.756,3.61283,604800,0,0,40443,4169,0,0),
(@GUID+79,32925,603,1,1,28581,0,2162.94,-207.222,445.019,4.24115,604800,0,0,40443,4169,0,0),
(@GUID+80,32925,603,1,1,28581,0,2169.97,-218.059,441.236,4.03171,604800,0,0,40443,4169,0,0),
(@GUID+81,32925,603,1,1,28581,0,2108.07,-208.596,442.986,5.16617,604800,0,0,40443,4169,0,0),
(@GUID+82,32925,603,1,1,28581,0,2102.01,-220.66,434.848,5.35816,604800,0,0,40443,4169,0,0),
(@GUID+83,32925,603,1,1,28581,0,2077.76,-232.818,447.073,5.79449,604800,0,0,40443,4169,0,0),
(@GUID+84,32925,603,1,1,28581,0,2089.41,-225.486,440.96,5.67232,604800,0,0,40443,4169,0,0),
(@GUID+85,32925,603,1,1,28581,0,2089.53,-238.313,432.82,5.79449,604800,0,0,40443,4169,0,0),
(@GUID+86,32925,603,1,1,28581,0,2079.95,-256.325,436.876,6.16101,604800,0,0,40443,4169,0,0),
(@GUID+87,32925,603,1,1,28581,0,2070.53,-254.7,447.074,0.436332,604800,0,0,40443,4169,0,0),
(@GUID+88,32925,603,1,1,28581,0,2068.65,-270.917,449.112,0.226893,604800,0,0,40443,4169,0,0),
(@GUID+89,32925,603,1,1,28581,0,2079.16,-291.637,445.029,0.488692,604800,0,0,40443,4169,0,0),
(@GUID+90,32925,603,1,1,28581,0,2093.31,-296.653,434.853,0.698132,604800,0,0,40443,4169,0,0),
(@GUID+91,32925,603,1,1,28581,0,2188.81,-295.889,445.046,2.49582,604800,0,0,40443,4169,0,0),
(@GUID+92,32925,603,1,1,28581,0,2197.29,-272.726,445.048,3.00197,604800,0,0,40443,4169,0,0);

DELETE FROM `gameobject_template` WHERE `entry`=194265;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) VALUES
('194265','1','295','Lever','','','','0','16','3','0','0','0','0','0','0','0','0','6000','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','11403');
DELETE FROM `gameobject` WHERE `id`=194265;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(2002365, 194265, 603, 1, 64, 2173.24, -252.985, 420.146, 5.27078, 0, 0, 1, 0, 7200, 100, 1);

UPDATE `gameobject` SET `id` = 194265, `rotation2` = 1, `rotation3` = 0, `spawntimesecs` = 7200, `animprogress` = 100 WHERE `guid` = 2002365;

DELETE FROM `creature` WHERE `guid`=131934;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
('131934','33725','603','1','1','16925','0','2134.93','-339.696','437.311','0','604800','0','0','12600','0','0','0');

UPDATE `creature_template` SET `ScriptName` = '' WHERE `entry` = 33725;
UPDATE `creature_template` SET `flags_extra` = 2, `ScriptName` = 'thorim_phase_trigger' WHERE `entry` = 32892;

DELETE FROM `creature_addon` WHERE `guid`IN (131817, 131934);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
('131817','0','0','0','1','0','40775 0'),
('131934','0','0','0','1','0','40775 0');

-- 8264_thorim_preadds
UPDATE `creature_template` SET `mindmg` = 488, `maxdmg` = 642, `attackpower` = 682, `dmg_multiplier` = 7.5, `equipment_id` = 1852 WHERE `entry` = 32908;
UPDATE `creature_template` SET `mindmg` = 488, `maxdmg` = 642, `attackpower` = 482, `dmg_multiplier` = 7.5, `equipment_id` = 1847 WHERE `entry` = 32885;
UPDATE `creature_template` SET `ScriptName` = 'mob_pre_phase' WHERE `entry` IN (32907, 32883);

-- 8265_thorim_chest
DELETE FROM `gameobject` WHERE `id`=194314;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(7143, 194314, 603, 1, 1, 2134.58, -286.908, 419.495, 1.55988, 0, 0, 0.703237, 0.710955, -604800, 0, 1);

-- 8266_thorim_hardmode
DELETE FROM creature_template WHERE `entry` IN (33196, 33234);
INSERT INTO `creature_template`  values
('33196','33234','0','0','0','0','28488','0','0','0','Sif','','','0','83','83','2','16','16','0','1','1.14286','1','3','370','531','4','343','35','2000','0','8','33587202','8','0','0','0','0','0','365','542','84','7','4','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','350','1','1','0','0','0','0','0','0','0','0','1','850','0','0','npc_sif','11159'),
('33234','0','0','0','0','0','28488','0','0','0','Sif (1)','','','0','83','83','2','35','35','0','1','1.14286','1','3','370','531','0','343','70','2000','0','8','0','8','0','0','0','0','0','365','542','84','7','4','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','350','1','1','0','0','0','0','0','0','0','0','1','0','0','0','','1');

-- 8270_razorscale_triggers
UPDATE `creature_template` SET `modelid1` = 16925, `modelid2` = 0, `flags_extra` = 2, `ScriptName` = 'mole_machine_trigger' WHERE `entry` = 33282;

-- 8274_thorim_tram
UPDATE `gameobject_template` SET `flags` = 32, `data2` = 3000, `ScriptName` = 'go_call_tram' WHERE `entry` IN (194914, 194912, 194437);
DELETE FROM gameobject WHERE id = '194437';
INSERT INTO `gameobject` (`guid`,`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(' 270010','194437','603','1','1','2306.87','274.237','424.288','1.52255','0','0','0.689847','0.723956','300','0','1');

-- 8275_tram_packets
DELETE FROM gameobject_template WHERE entry = '194438';
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) VALUES
('194438','1','8504','Activate Tram','','','','0','32','1','0','0','0','0','0','0','0','0','3000','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','go_call_tram','11159');
DELETE FROM gameobject WHERE id = '194438';
INSERT INTO `gameobject` (`guid`,`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(270011, 194438, 603, 1,1,2306.99, 2589.35, 424.382, 4.71676, 0, 0, 0.705559, -0.708651, 300, 0, 1);

-- 8277_ignis_vehicle
UPDATE `creature_template` SET `vehicleid` = 342 WHERE `entry` = 33118;

-- 8281_xt002_adds
UPDATE `creature_template` SET `vehicleid` = 353 WHERE `entry` = 33293;
UPDATE `creature_template` SET `speed_walk` = 0.5, `speed_run` = 0.5, `faction_A` = 16, `faction_H` = 16 WHERE `entry` IN (33343, 33346);
UPDATE `creature_template` SET `modelid1` = 19139, `modelid2` = 0, `modelid3` = 0, `dmg_multiplier` = 35 WHERE `entry` = 33346;

-- 8282_razorscale_event
UPDATE `creature_template` SET `modelid1` = 11686, `modelid2` = 0, `flags_extra` = 2, `ScriptName` = 'mole_machine_trigger' WHERE `entry` = 33245;
UPDATE `creature_template` SET `ScriptName` = '' WHERE `entry` = 33282;

-- 8289_kologarn_arms
DELETE FROM `creature_model_info` WHERE `modelid` IN (28638, 28821, 28822);
INSERT INTO `creature_model_info` (`modelid`, `bounding_radius`, `combat_reach`, `gender`, `modelid_other_gender`) VALUES
(28638, 0.15, 20, 2, 0),
(28821, 0.35, 20, 2, 0),
(28822, 0.35, 20, 2, 0);

-- 8291_hodir_adds_resistance
UPDATE `creature_template` SET `resistance4` = 1000 WHERE `entry` IN (33325, 32901, 33328, 32900, 32893, 33327, 32897, 33326, 32941, 33333, 33332, 32950, 33331, 32946, 32948, 33330);

-- 8297_mimiron_phase1
UPDATE `creature_template` SET `vehicleId` = 336 WHERE `entry` = 33432; -- Leviathan Mk II
DELETE FROM creature WHERE id = 34071;
DELETE FROM vehicle_accessory WHERE entry = 33432;
INSERT INTO vehicle_accessory VALUE (33432, 34071, 7, 1, 'Leviathan Mk II turret');
UPDATE creature_template SET ScriptName = 'boss_mimiron' WHERE entry = 33350;
UPDATE creature_template SET ScriptName = 'boss_leviathan_mk' WHERE entry = 33432;
UPDATE creature_template SET ScriptName = 'boss_leviathan_mk_turret' WHERE entry = 34071;
UPDATE creature_template SET ScriptName = 'mob_proximity_mine' WHERE entry = 34362;
DELETE FROM `creature_model_info` WHERE `modelid`=28831;
INSERT INTO `creature_model_info` (`modelid`, `bounding_radius`, `combat_reach`, `gender`, `modelid_other_gender`) VALUES
(28831, 0.5, 7, 2, 0);

-- 8320 mimiron_encounter
DELETE FROM `creature_model_info` WHERE `modelid`=28831;
INSERT INTO `creature_model_info` (`modelid`, `bounding_radius`, `combat_reach`, `gender`, `modelid_other_gender`) VALUES
(28831, 0, 0, 2, 0);
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` IN (33856, 34143, 34050);
UPDATE `creature_template` SET `unit_flags` = 33686018 WHERE `entry` = 34050;
UPDATE `creature` SET `position_x` = 2736.92, `position_y` = 2572.30, `orientation` = 5.723 WHERE `guid` = 137630;
UPDATE `creature_template` SET `ScriptName` = 'boss_vx_001', `unit_flags` = 0, `vehicleid` = 371, `Health_mod` = 375 WHERE `entry` = 33651;
UPDATE `creature_template` SET `ScriptName` = 'boss_aerial_unit', `unit_flags` = 0, `vehicleid` = 388, `Health_mod` = 250 WHERE `entry` = 33670;
UPDATE `creature_template` SET `vehicleid` = 370, `Health_mod` = 156.185 WHERE `entry` = 33432;
UPDATE `creature_template` SET `Health_mod` = 156.185 WHERE `entry` = 34071;

DELETE FROM vehicle_accessory WHERE entry = 33432;
INSERT INTO vehicle_accessory VALUE (33432, 34071, 3, 1, 'Leviathan Mk II turret');
UPDATE `creature_template` SET `modelid1` = 17188, `modelid2` = 0 WHERE `entry` = 25171;
UPDATE `creature_template` SET `speed_walk` = 0.5, `speed_run` = 0.5, `ScriptName` = 'mob_boom_bot' WHERE `entry` = 33836;

DELETE FROM `creature` WHERE `id`=33651;
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(33651, 603, 1, 1, 28841, 0, 2744.65, 2569.46, 364.397, 3.14159, 604800, 0, 0, 1742400, 0, 0, 0);
UPDATE `creature_template` SET `unit_flags` = 33686020, `flags_extra` = 2, `ScriptName` = 'rocket_strike' WHERE `entry` = 34047;

DELETE FROM `creature` WHERE `id`=33670;
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(33670, 603, 1, 1, 28979, 0, 2744.65, 2569.46, 380.040, 3.14159, 604800, 0, 0, 1742400, 0, 0, 0);

UPDATE `creature_template` SET `unit_flags` = 33686020, `type_flags` = 0, `flags_extra` = 2, `ScriptName` = 'magnetic_core' WHERE `entry` = 34068;
-- 8334_mimiron_chest
UPDATE `gameobject_template` SET `size` = 1.5 WHERE `entry` = 194956;
DELETE FROM `gameobject` WHERE `id`=194956;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(5868, 194956, 603, 1, 1, 2744.65, 2569.46, 364.397, 3.14159, 0, 0, 0.703237, 0.710955, -604800, 0, 1);

UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 1 WHERE `entry` IN (33432, 33651, 33670);

-- 8338_ulduar_teleports
DELETE FROM `gameobject` WHERE `id`=194569;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(21679, 194569, 603, 1, 1, 2086.26, -23.9948, 421.316, 0, 0, 0, 0, 1, 180, 255, 0),
(21684, 194569, 603, 1, 1, 1498.05, -24.3509, 420.966, 0, 0, 0, 0, 1, 180, 255, 0),
(49422, 194569, 603, 1, 1, 1859.65, -24.9121, 448.811, 0, 0, 0, 0, 1, 180, 255, 0),
(49423, 194569, 603, 1, 1, 2518.16, 2569.03, 412.299, 0, 0, 0, 0, 1, 180, 255, 0),
(49424, 194569, 603, 1, 1, 1854.82, -11.5608, 334.175, 0, 0, 0, 0, 1, 180, 255, 0),
(73286, 194569, 603, 1, 1, -706.122, -92.6024, 429.876, 0, 0, 0, 0, 1, 180, 255, 0),
(73327, 194569, 603, 1, 1, 553.233, -12.3247, 409.679, 0, 0, 0, 0, 1, 180, 255, 0),
(73322, 194569, 603, 1, 1, 131.248, -35.3802, 409.804, 0, 0, 0, 0, 1, 180, 255, 0),
(73340, 194569, 603, 1, 1, 926.292, -11.4635, 418.595, 0, 0, 0, 0, 1, 180, 255, 0);
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` = 33184;

-- 8353_ulduar_evenai
-- Runeforged Sentry
UPDATE `creature_template` SET `spell1` = 64852, `spell2` = 64870, `spell3` = 64847, `AIName` = 'EventAI' WHERE `entry` = 34234;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34234);
INSERT INTO `creature_ai_scripts` VALUES 
(3423401, 34234, 0, 0, 100, 3, 2000, 2000, 10000, 10000, 11, 64852, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Runeforged Sentry - Cast Flaming Rune 10'),
(3423402, 34234, 0, 0, 100, 5, 2000, 2000, 10000, 10000, 11, 64852, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Runeforged Sentry - Cast Flaming Rune 25'),
(3423403, 34234, 0, 0, 100, 3, 3000, 5000, 5000, 7000, 11, 64870, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Runeforged Sentry - Cast Lava Burst 10'),
(3423404, 34234, 0, 0, 100, 5, 3000, 5000, 5000, 7000, 11, 64870, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Runeforged Sentry - Cast Lava Burst 25'),
(3423405, 34234, 0, 0, 100, 3, 2500, 3000, 12000, 15000, 11, 64847, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Runeforged Sentry - Cast Runed Flame Jets 10'),
(3423406, 34234, 0, 0, 100, 5, 2500, 3000, 12000, 15000, 11, 64847, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Runeforged Sentry - Cast Runed Flame Jets 25');

-- Steelforged Defender
UPDATE `creature_template` SET `spell1` = 62845, `spell2` = 57780, `spell3` = 50370, `AIName` = 'EventAI' WHERE `entry` = 33236;
UPDATE `creature` SET `spawntimesecs` = 604800 WHERE `id` IN (33236, 33838);
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33236);
INSERT INTO `creature_ai_scripts` VALUES 
(3323601, 33236, 0, 0, 100, 3, 4000, 6000, 15000, 20000, 11, 62845, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Steelforged Defender - Cast Hamstring 10'),
(3323602, 33236, 0, 0, 100, 5, 4000, 6000, 15000, 20000, 11, 62845, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Steelforged Defender - Cast Hamstring 25'),
(3323603, 33236, 0, 0, 100, 3, 0, 4000, 6000, 8000, 11, 57780, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Steelforged Defender - Cast Lightning Bolt 10'),
(3323604, 33236, 0, 0, 100, 5, 0, 4000, 6000, 8000, 11, 57780, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Steelforged Defender - Cast Lightning Bolt 25'),
(3323605, 33236, 0, 0, 100, 3, 5000, 6000, 4000, 6000, 11, 50370, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Steelforged Defender - Cast Sunder Armor 10'),
(3323606, 33236, 0, 0, 100, 5, 5000, 6000, 4000, 6000, 11, 50370, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Steelforged Defender - Cast Sunder Armor 25');

-- Mechagnome Battletank
UPDATE `creature_template` SET `spell1` = 64693, `spell2` = 64953, `mindmg` = 417, `maxdmg` = 582, `attackpower` = 968, `minrangedmg` = 341, `maxrangedmg` = 506, `AIName` = 'EventAI' WHERE `entry` = 34164;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34164);
INSERT INTO `creature_ai_scripts` VALUES 
(3416401, 34164, 0, 0, 100, 3, 3000, 4000, 6000, 8000, 11, 64693, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechagnome Battletank - Cast Flame Cannon 10'),
(3416402, 34164, 0, 0, 100, 5, 3000, 4000, 6000, 8000, 11, 64693, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechagnome Battletank - Cast Flame Cannon 25'),
(3416403, 34164, 0, 0, 100, 3, 10000, 10000, 15000, 20000, 11, 64953, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechagnome Battletank - Cast Jump Attack 10'),
(3416404, 34164, 0, 0, 100, 5, 10000, 10000, 15000, 20000, 11, 64953, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechagnome Battletank - Cast Jump Attack 25');

-- Ulduar Colossus
UPDATE `creature_template` SET `spell1` = 62625, `attackpower` = 987, `AIName` = 'EventAI' WHERE `entry` = 33237;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33237);
INSERT INTO `creature_ai_scripts` VALUES 
(3323701, 33237, 0, 0, 100, 3, 8000, 10000, 20000, 25000, 11, 62625, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ulduar Colossus - Cast Ground Slam 10'),
(3323702, 33237, 0, 0, 100, 5, 8000, 10000, 20000, 25000, 11, 62625, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ulduar Colossus - Cast Ground Slam 25');

-- invisible triggers
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` IN (33377, 33742, 34286, 33500);

-- Molten Colossus
UPDATE `creature_template` SET `spell1` = 64697, `spell2` = 64698, `attackpower` = 982, `dmg_multiplier` = 30, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 34069;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34069);
INSERT INTO `creature_ai_scripts` VALUES 
(3406901, 34069, 0, 0, 100, 3, 6000, 10000, 10000, 12000, 11, 64697, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Molten Colossus - Cast Earthquake 10'),
(3406902, 34069, 0, 0, 100, 5, 6000, 10000, 10000, 12000, 11, 64697, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Molten Colossus - Cast Earthquake 25'),
(3406903, 34069, 0, 0, 100, 3, 2000, 4000, 6000, 9000, 11, 64698, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Molten Colossus - Cast Pyroblast 10'),
(3406904, 34069, 0, 0, 100, 5, 2000, 4000, 6000, 9000, 11, 64698, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Molten Colossus - Cast Pyroblast 25');

-- Magma Rager
UPDATE `creature_template` SET `spell1` = 64773, `spell2` = 64746, `dmg_multiplier` = 20, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 34086;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34086);
INSERT INTO `creature_ai_scripts` VALUES 
(3408601, 34086, 0, 0, 100, 3, 2000, 40000, 6000, 8000, 11, 64773, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Magma Rager - Cast Fire Blast 10'),
(3408602, 34086, 0, 0, 100, 5, 2000, 40000, 6000, 8000, 11, 64773, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Magma Rager - Cast Fire Blast 25'),
(3408603, 34086, 0, 0, 100, 3, 8000, 16000, 15000, 25000, 11, 64746, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Magma Rager - Cast Superheated winds 10'),
(3408604, 34086, 0, 0, 100, 5, 8000, 16000, 15000, 25000, 11, 64746, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Magma Rager - Cast Superheated winds 25');
UPDATE `creature_template` SET `unit_flags` = 33718790, modelid1 = 11686, modelid2 = 0, `spell1` = 64724, `AIName` = 'EventAI' WHERE `entry` = 34194;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34194);
INSERT INTO `creature_ai_scripts` VALUES 
(3419401, 34194, 0, 0, 100, 3, 0, 0, 10000, 10000, 11, 64724, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Superheated Winds'),
(3419402, 34194, 0, 0, 100, 5, 0, 0, 10000, 10000, 11, 64724, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Superheated Winds');

-- Forge Construct
UPDATE `creature_template` SET `spell1` = 64719, `spell2` = 64720, `dmg_multiplier` = 20, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 34085;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34085);
INSERT INTO `creature_ai_scripts` VALUES 
(3408501, 34085, 0, 0, 100, 3, 8000, 12000, 10000, 15000, 11, 64719, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Forge Construct - Cast Charge 10'),
(3408502, 34085, 0, 0, 100, 5, 8000, 12000, 10000, 15000, 11, 64719, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Forge Construct - Cast Charge 25'),
(3408503, 34085, 0, 0, 100, 3, 2000, 6000, 6000, 9000, 11, 64720, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Forge Construct - Cast Flame Emission 10'),
(3408504, 34085, 0, 0, 100, 5, 2000, 6000, 6000, 9000, 11, 64721, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Forge Construct - Cast Flame Emission 25');

-- XB-488 Disposalbot
UPDATE `creature_template` SET `spell1` = 65080, `spell2` = 65084, `dmg_multiplier` = 20, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 34273;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34273);
INSERT INTO `creature_ai_scripts` VALUES 
(3427301, 34273, 2, 0, 100, 3, 30, 20, 0, 0, 11, 65084, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'XB-488 Disposalbot - Cast Self Destruct 10'),
(3427302, 34273, 2, 0, 100, 5, 30, 20, 0, 0, 11, 65084, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'XB-488 Disposalbot - Cast Self Destruct 25'),
(3427303, 34273, 0, 0, 100, 3, 2000, 6000, 10000, 15000, 11, 65080, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'XB-488 Disposalbot - Cast Cut Scrap Metal 10'),
(3427304, 34273, 0, 0, 100, 5, 2000, 6000, 10000, 15000, 11, 65104, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'XB-488 Disposalbot - Cast Cut Scrap Metal 25');

-- Parts Recovery Technician
UPDATE `creature_template` SET `spell1` = 65071, `spell2` = 65070, `dmg_multiplier` = 15, `mingold` = 7100, `maxgold` = 7600, `mechanic_immune_mask` = 33554432, `AIName` = 'EventAI' WHERE `entry` = 34267;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34267);
INSERT INTO `creature_ai_scripts` VALUES 
(3426701, 34267, 0, 0, 100, 3, 8000, 12000, 10000, 15000, 11, 65071, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Parts Recovery Technician - Cast Mechano Kick 10'),
(3426702, 34267, 0, 0, 100, 5, 8000, 12000, 10000, 15000, 11, 65071, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Parts Recovery Technician - Cast Mechano Kick 25'),
(3426703, 34267, 0, 0, 100, 3, 6000, 8000, 25000, 30000, 11, 65070, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Parts Recovery Technician - Cast Defense Matrix 10'),
(3426704, 34267, 0, 0, 100, 5, 6000, 8000, 25000, 30000, 11, 65070, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Parts Recovery Technician - Cast Defense Matrix 25');

-- XD-175 Compactobot
UPDATE `creature_template` SET `spell1` = 65073, `spell2` = 65106, `dmg_multiplier` = 20, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 34271;
UPDATE `creature_template` SET `dmg_multiplier` = 20, `mingold` = 7100, `maxgold` = 7600 WHERE `entry` = 34269;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34271);
INSERT INTO `creature_ai_scripts` VALUES 
(3427101, 34271, 0, 0, 100, 3, 8000, 12000, 15000, 20000, 11, 65073, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'XD-175 Compactobot - Cast Trash Compactor 10'),
(3427102, 34271, 0, 0, 100, 5, 8000, 12000, 15000, 20000, 11, 65106, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'XD-175 Compactobot - Cast Trash Compactor 25');

-- Lightning Charged Iron Dwarf
UPDATE `creature_template` SET `spell1` = 64889, `spell2` = 64975, `dmg_multiplier` = 20, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 34199;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34199);
INSERT INTO `creature_ai_scripts` VALUES 
(3419901, 34199, 0, 0, 100, 3, 0, 0, 10000, 15000, 11, 64889, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Lightning Charged Iron Dwarf - Cast Lightning Charged 10'),
(3419902, 34199, 0, 0, 100, 5, 0, 0, 10000, 15000, 11, 64975, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Lightning Charged Iron Dwarf - Cast Lightning Charged 25');

-- Hardened Iron Golem
UPDATE `creature_template` SET `spell1` = 64877, `spell2` = 64874, `dmg_multiplier` = 25, `mingold` = 7100, `maxgold` = 7600, `mechanic_immune_mask` = 33554496, `AIName` = 'EventAI' WHERE `entry` = 34190;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34190);
INSERT INTO `creature_ai_scripts` VALUES 
(3419001, 34190, 0, 0, 100, 3, 4000, 8000, 25000, 30000, 11, 64877, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hardened Iron Golem - Cast Harden Fists 10'),
(3419002, 34190, 0, 0, 100, 5, 4000, 8000, 25000, 30000, 11, 64877, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hardened Iron Golem - Cast Harden Fists 25'),
(3419003, 34190, 0, 0, 100, 3, 5000, 7000, 20000, 30000, 11, 64874, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hardened Iron Golem - Cast Rune Punch 10'),
(3419004, 34190, 0, 0, 100, 5, 5000, 7000, 20000, 30000, 11, 64967, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hardened Iron Golem - Cast Rune Punch 25');

-- Iron Mender
UPDATE `creature_template` SET `spell1` = 64918, `spell2` = 64903, `spell3` = 64897, `dmg_multiplier` = 25, `mechanic_immune_mask` = 33554496, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 34198;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34198);
INSERT INTO `creature_ai_scripts` VALUES 
(3419801, 34198, 0, 0, 100, 3, 2000, 4000, 4000, 6000, 11, 64918, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Mender - Cast Electro Shock 10'),
(3419802, 34198, 0, 0, 100, 5, 2000, 4000, 4000, 6000, 11, 64971, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Mender - Cast Electro Shock 25'),
(3419803, 34198, 0, 0, 100, 3, 3000, 6000, 10000, 15000, 11, 64903, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Mender - Cast Fuse Lightning 10'),
(3419804, 34198, 0, 0, 100, 5, 3000, 6000, 10000, 15000, 11, 64970, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Mender - Cast Fuse Lightning 25'),
(3419805, 34198, 0, 0, 100, 3, 10000, 25000, 30000, 45000, 11, 64897, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Mender - Cast Fuse Metal 10'),
(3419806, 34198, 0, 0, 100, 5, 10000, 25000, 30000, 45000, 11, 64968, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Mender - Cast Fuse Metal 25');

-- Rune Etched Sentry
UPDATE `creature_template` SET `spell1` = 64852, `spell2` = 64870, `spell3` = 64847, `mechanic_immune_mask` = 33554496, `dmg_multiplier` = 20, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 34196;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34196);
INSERT INTO `creature_ai_scripts` VALUES 
(3419601, 34196, 0, 0, 100, 3, 2000, 2000, 10000, 10000, 11, 64852, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Rune Etched Sentry - Cast Flaming Rune 10'),
(3419602, 34196, 0, 0, 100, 5, 2000, 2000, 10000, 10000, 11, 64852, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Rune Etched Sentry - Cast Flaming Rune 25'),
(3419603, 34196, 0, 0, 100, 3, 3000, 5000, 5000, 7000, 11, 64870, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Rune Etched Sentry - Cast Lava Burst 10'),
(3419604, 34196, 0, 0, 100, 5, 3000, 5000, 5000, 7000, 11, 64870, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Rune Etched Sentry - Cast Lava Burst 25'),
(3419605, 34196, 0, 0, 100, 3, 2500, 3000, 12000, 15000, 11, 64847, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Rune Etched Sentry - Cast Runed Flame Jets 10'),
(3419606, 34196, 0, 0, 100, 5, 2500, 3000, 12000, 15000, 11, 64847, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Rune Etched Sentry - Cast Runed Flame Jets 25');

-- Chamber Overseer
UPDATE `creature_template` SET `spell1` = 64820, `spell2` = 64825, `dmg_multiplier` = 55, `mingold` = 7100, `maxgold` = 7600, `mechanic_immune_mask` = 33554496, `AIName` = 'EventAI' WHERE `entry` = 34197;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34197);
INSERT INTO `creature_ai_scripts` VALUES 
(3419701, 34197, 0, 0, 100, 3, 4000, 8000, 6000, 9000, 11, 64820, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Chamber Overseer - Cast Devastating Leap 10'),
(3419702, 34197, 0, 0, 100, 5, 4000, 8000, 6000, 9000, 11, 64943, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Chamber Overseer - Cast Devastating Leap 25'),
(3419703, 34197, 0, 0, 100, 3, 10000, 12000, 8000, 12000, 11, 64825, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Chamber Overseer - Cast Staggering Roar 10'),
(3419704, 34197, 0, 0, 100, 5, 10000, 12000, 8000, 12000, 11, 64944, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Chamber Overseer - Cast Staggering Roar 25');

-- Storm Tempered Keeper
UPDATE `creature_template` SET `spell1` = 63541, `spell2` = 63630, `dmg_multiplier` = 45, `mingold` = 7100, `maxgold` = 7600, `mechanic_immune_mask` = 33554496, `AIName` = 'EventAI' WHERE `entry` = 33722;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33722);
INSERT INTO `creature_ai_scripts` VALUES 
(3372201, 33722, 0, 0, 100, 3, 120000, 120000, 120000, 150000, 11, 63630, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Storm Tempered Keeper - Cast Vengeful Surge 10'),
(3372202, 33722, 0, 0, 100, 5, 120000, 120000, 120000, 150000, 11, 63630, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Storm Tempered Keeper - Cast Vengeful Surge 25'),
(3372203, 33722, 0, 0, 100, 3, 3000, 6000, 10000, 15000, 11, 63541, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Storm Tempered Keeper - Cast Forked Lightning 10'),
(3372204, 33722, 0, 0, 100, 5, 3000, 6000, 10000, 15000, 11, 63541, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Storm Tempered Keeper - Cast Forked Lightning 25');

-- Storm Tempered Keeper
UPDATE `creature_template` SET `spell1` = 63541, `spell2` = 63630, `dmg_multiplier` = 45, `mingold` = 7100, `maxgold` = 7600, `mechanic_immune_mask` = 33554496, `AIName` = 'EventAI' WHERE `entry` = 33699;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33699);
INSERT INTO `creature_ai_scripts` VALUES 
(3369901, 33699, 0, 0, 100, 3, 120000, 120000, 120000, 150000, 11, 63630, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Storm Tempered Keeper - Cast Vengeful Surge 10'),
(3369902, 33699, 0, 0, 100, 5, 120000, 120000, 120000, 150000, 11, 63630, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Storm Tempered Keeper - Cast Vengeful Surge 25'),
(3369903, 33699, 0, 0, 100, 3, 3000, 6000, 10000, 15000, 11, 63541, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Storm Tempered Keeper - Cast Forked Lightning 10'),
(3369904, 33699, 0, 0, 100, 5, 3000, 6000, 10000, 15000, 11, 63541, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Storm Tempered Keeper - Cast Forked Lightning 25');

-- Champion of Hodir
UPDATE `creature_template` SET `spell1` = 64639, `dmg_multiplier` = 55, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 34133;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34133);
INSERT INTO `creature_ai_scripts` VALUES 
(3413301, 34133, 0, 0, 100, 3, 3000, 6000, 12000, 16000, 11, 64639, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Champion of Hodir - Cast Stomp 10'),
(3413302, 34133, 0, 0, 100, 5, 3000, 6000, 12000, 16000, 11, 64652, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Champion of Hodir - Cast Stomp 25');
DELETE FROM `creature` WHERE `guid` IN (136293, 136294, 136295, 136292, 136313, 136314, 136312, 136321, 136319, 136320, 136322, 136346, 136343, 136536, 136533, 137563);

-- Winter Jormungar
UPDATE `creature_template` SET `spell1` = 64638, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 34137;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34137);
INSERT INTO `creature_ai_scripts` VALUES 
(3413701, 34137, 0, 0, 100, 3, 3000, 6000, 6000, 9000, 11, 64638, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Winter Jormungar - Cast Acidic Bite 10'),
(3413702, 34137, 0, 0, 100, 5, 3000, 6000, 6000, 9000, 11, 64638, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Winter Jormungar - Cast Acidic Bite 25');
UPDATE `creature` SET `spawndist` = 2 WHERE `id` = 34137;

-- Winter Revenant
UPDATE `creature_template` SET `spell1` = 64642, `spell2` = 64643, `spell3` = 64644, `mechanic_immune_mask` = 33554496, `dmg_multiplier` = 25, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 34134;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34134);
INSERT INTO `creature_ai_scripts` VALUES 
(3413401, 34134, 0, 0, 100, 3, 8000, 12000, 15000, 20000, 11, 64642, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Winter Revenant - Cast Blizzard 10'),
(3413402, 34134, 0, 0, 100, 5, 8000, 12000, 15000, 20000, 11, 64653, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Winter Revenant - Cast Blizzard 25'),
(3413403, 34134, 0, 0, 100, 3, 3000, 5000, 10000, 12000, 11, 64643, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Winter Revenant - Cast Whirling Strike 10'),
(3413404, 34134, 0, 0, 100, 5, 3000, 5000, 10000, 12000, 11, 64643, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Winter Revenant - Cast Whirling Strike 25'),
(3413405, 34134, 0, 0, 100, 3, 15000, 20000, 60000, 75000, 11, 64644, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Winter Revenant - Cast Shield of the Winter Revenant 10'),
(3413406, 34134, 0, 0, 100, 5, 15000, 20000, 60000, 75000, 11, 64644, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Winter Revenant - Cast Shield of the Winter Revenant 25');

-- Winter Rumbler
UPDATE `creature_template` SET `spell1` = 64645, `spell2` = 64647, `dmg_multiplier` = 15, `mingold` = 7100, `maxgold` = 7600, `mechanic_immune_mask` = 33554496, `AIName` = 'EventAI' WHERE `entry` = 34135;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34135);
INSERT INTO `creature_ai_scripts` VALUES 
(3413501, 34135, 0, 0, 100, 3, 6000, 12000, 10000, 16000, 11, 64645, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Winter Rumbler - Cast Cone of Cold 10'),
(3413502, 34135, 0, 0, 100, 5, 6000, 12000, 10000, 16000, 11, 64655, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Winter Rumbler - Cast Cone of Cold 25'),
(3413503, 34135, 0, 0, 100, 3, 3000, 6000, 8000, 12000, 11, 64647, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Winter Rumbler - Cast Snow Blindness 10'),
(3413504, 34135, 0, 0, 100, 5, 3000, 6000, 8000, 12000, 11, 64654, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Winter Rumbler - Cast Snow Blindness 25');

-- Guardian Lasher
UPDATE `creature_template` SET `spell1` = 63007, `spell2` = 63047, `dmg_multiplier` = 25, `mingold` = 7100, `maxgold` = 7600, `mechanic_immune_mask` = 33554496, `AIName` = 'EventAI' WHERE `entry` = 33430;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33430);
INSERT INTO `creature_ai_scripts` VALUES 
(3343001, 33430, 4, 0, 100, 3, 0, 0, 0, 0, 11, 63007, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Guardian Lasher - Cast Guardian Pheromones 10'),
(3343002, 33430, 4, 0, 100, 5, 0, 0, 0, 0, 11, 63007, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Guardian Lasher - Cast Guardian Pheromones 25'),
(3343003, 33430, 0, 0, 100, 3, 3000, 6000, 10000, 14000, 11, 63047, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Guardian Lasher - Cast Guardian''s Lash 10'),
(3343004, 33430, 0, 0, 100, 5, 3000, 6000, 10000, 14000, 11, 63550, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Guardian Lasher - Cast Guardian''s Lash 25');

-- Forest Swarmer
UPDATE `creature_template` SET `spell1` = 63059, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 33431;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33431);
INSERT INTO `creature_ai_scripts` VALUES 
(3343101, 33431, 0, 0, 100, 3, 3000, 9000, 10000, 20000, 11, 63059, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Forest Swarmer - Cast Pollinate 10'),
(3343102, 33431, 0, 0, 100, 5, 3000, 9000, 10000, 20000, 11, 63059, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Forest Swarmer - Cast Pollinate 25');
/*
DELETE FROM `spell_script_target` WHERE `entry`=63059;
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`) VALUES('63059','1','33430');
*/

-- Guardian of Life
UPDATE `creature_template` SET `spell1` = 63226, `mingold` = 7100, `maxgold` = 7600, `dmg_multiplier` = 15, `AIName` = 'EventAI' WHERE `entry` = 33528;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33528);
INSERT INTO `creature_ai_scripts` VALUES 
(3352801, 33528, 0, 0, 100, 3, 3000, 9000, 15000, 20000, 11, 63226, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Guardian of Life - Cast Poison Breath 10'),
(3352802, 33528, 0, 0, 100, 5, 3000, 9000, 15000, 20000, 11, 63551, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Guardian of Life - Cast Poison Breath 25');

-- Nature's Blade
UPDATE `creature_template` SET `spell1` = 63247, `mingold` = 7100, `maxgold` = 7600, `dmg_multiplier` = 25, `AIName` = 'EventAI' WHERE `entry` = 33527;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33527);

-- Ironroot Lasher
UPDATE `creature_template` SET `spell1` = 63240, `mingold` = 7100, `maxgold` = 7600, `dmg_multiplier` = 15, `AIName` = 'EventAI' WHERE `entry` = 33526;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33526);
INSERT INTO `creature_ai_scripts` VALUES 
(3352601, 33526, 0, 0, 100, 3, 3000, 8000, 12000, 16000, 11, 63240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironroot Lasher - Cast Ironroot Thorns 10'),
(3352602, 33526, 0, 0, 100, 5, 3000, 8000, 12000, 16000, 11, 63553, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironroot Lasher - Cast Ironroot Thorns 25');

-- Mangrove Ent
UPDATE `creature_template` SET `spell1` = 63272, `spell2` = 63242, `spell3` = 63241, `dmg_multiplier` = 15, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 33525;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33525);
INSERT INTO `creature_ai_scripts` VALUES 
(3352501, 33525, 0, 0, 100, 3, 8000, 12000, 25000, 30000, 11, 63272, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mangrove Ent - Cast Hurricane 10'),
(3352502, 33525, 0, 0, 100, 5, 8000, 12000, 25000, 30000, 11, 63272, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mangrove Ent - Cast Hurricane 25'),
(3352503, 33525, 0, 0, 100, 3, 12000, 16000, 12000, 16000, 11, 63242, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mangrove Ent - Cast Nourish 10'),
(3352504, 33525, 0, 0, 100, 5, 12000, 16000, 12000, 16000, 11, 63556, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mangrove Ent - Cast Nourish 25'),
(3352505, 33525, 0, 0, 100, 3, 25000, 30000, 25000, 30000, 11, 63241, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mangrove Ent - Cast Tranquility 10'),
(3352506, 33525, 0, 0, 100, 5, 25000, 30000, 25000, 30000, 11, 63554, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mangrove Ent - Cast Tranquility 25');

-- Misguided Nymph
UPDATE `creature_template` SET `spell1` = 63082, `spell2` = 63111, `spell3` = 63136, `dmg_multiplier` = 15, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 33355;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33355);
INSERT INTO `creature_ai_scripts` VALUES 
(3335501, 33355, 0, 0, 100, 3, 8000, 12000, 25000, 30000, 11, 63082, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Misguided Nymph - Cast Bind Life 10'),
(3335502, 33355, 0, 0, 100, 5, 8000, 12000, 25000, 30000, 11, 63559, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Misguided Nymph - Cast Bind Life 25'),
(3335503, 33355, 0, 0, 100, 3, 4000, 6000, 12000, 16000, 11, 63111, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Misguided Nymph - Cast Frost Spear 10'),
(3335504, 33355, 0, 0, 100, 5, 4000, 6000, 12000, 16000, 11, 63562, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Misguided Nymph - Cast Frost Spear 25'),
(3335505, 33355, 0, 0, 100, 3, 15000, 20000, 15000, 20000, 11, 63136, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Misguided Nymph - Cast Winter''s Embrace 10'),
(3335506, 33355, 0, 0, 100, 5, 15000, 20000, 15000, 20000, 11, 63564, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Misguided Nymph - Cast Winter''s Embrace 25');

-- Corrupted Servitor
UPDATE `creature_template` SET `spell1` = 63169, `spell2` = 63149, `dmg_multiplier` = 25, `mingold` = 7100, `maxgold` = 7600, `mechanic_immune_mask` = 33554496, `AIName` = 'EventAI' WHERE `entry` = 33354;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33354);
INSERT INTO `creature_ai_scripts` VALUES 
(3335401, 33354, 0, 0, 100, 3, 2000, 4000, 20000, 25000, 11, 63169, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Servitor - Cast Petrify Joints 10'),
(3335402, 33354, 0, 0, 100, 5, 2000, 4000, 20000, 25000, 11, 63549, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Servitor - Cast Petrify Joints 25'),
(3335403, 33354, 0, 0, 100, 3, 6000, 8000, 12000, 16000, 11, 63149, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Servitor - Cast Violent Earth 10'),
(3335404, 33354, 0, 0, 100, 5, 6000, 8000, 12000, 16000, 11, 63149, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Servitor - Cast Violent Earth 25');

-- Dark Rune
UPDATE `creature_template` SET `dmg_multiplier` = 55, `mingold` = 7100, `maxgold` = 7600 WHERE `entry` IN (33754, 33755);

-- Freya's Elders
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` IN (33406, 33575);
UPDATE `creature_template` SET `dmg_multiplier` = 45, `mechanic_immune_mask` = 650854235 WHERE `entry` IN (32913, 32915, 32914);

-- Arachnopod Destroyer
UPDATE `creature_template` SET `spell1` = 64717, `spell2` = 64776, `dmg_multiplier` = 30, `mingold` = 7100, `maxgold` = 7600, `mechanic_immune_mask` = 33554496, `AIName` = 'EventAI' WHERE `entry` = 34183;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34183);
INSERT INTO `creature_ai_scripts` VALUES 
(3418301, 34183, 0, 0, 100, 3, 2000, 4000, 12000, 16000, 11, 64717, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Arachnopod Destroyer - Cast Flame Spray 10'),
(3418302, 34183, 0, 0, 100, 5, 2000, 4000, 12000, 16000, 11, 64717, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Arachnopod Destroyer - Cast Flame Spray 25'),
(3418303, 34183, 0, 0, 100, 3, 8000, 10000, 12000, 16000, 11, 64776, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Arachnopod Destroyer - Cast Machine Gun 10'),
(3418304, 34183, 0, 0, 100, 5, 8000, 10000, 12000, 16000, 11, 64776, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Arachnopod Destroyer - Cast Machine Gun 25');

-- Clockwork Mechanic
UPDATE `creature_template` SET `dmg_multiplier` = 20, `mingold` = 1720000, `maxgold` = 1760000 WHERE `entry` = 34184;

-- Trash
UPDATE `creature_template` SET `dmg_multiplier` = 10 WHERE `entry` = 34191;

-- Boomer XP-500
UPDATE `creature_template` SET `spell1` = 55714, `dmg_multiplier` = 15, `AIName` = 'EventAI' WHERE `entry` = 34192;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34192);
INSERT INTO `creature_ai_scripts` VALUES 
(3419201, 34192, 9, 0, 100, 3, 0, 3, 0, 0, 11, 55714, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 - Explode 10'),
(3419202, 34192, 9, 0, 100, 5, 0, 3, 0, 0, 11, 55714, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 - Explode 25');

-- Clockwork Sapper
UPDATE `creature_template` SET `spell1` = 64740, `mindmg` = 464, `maxdmg` = 604, `attackpower` = 708, `dmg_multiplier` = 20, `minrangedmg` = 353, `maxrangedmg` = 512, `rangedattackpower` = 112, `mingold` = 7100, `maxgold` = 7600, `mechanic_immune_mask` = 33554496, `AIName` = 'EventAI' WHERE `entry` = 34193;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34193);
INSERT INTO `creature_ai_scripts` VALUES 
(3419301, 34193, 0, 0, 100, 3, 2000, 6000, 12000, 16000, 11, 64740, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Clockwork Sapper - Cast Energy Sap 10'),
(3419302, 34193, 0, 0, 100, 5, 2000, 6000, 12000, 16000, 11, 64740, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Clockwork Sapper - Cast Energy Sap 25');

-- Twilight Adherent
UPDATE `creature_template` SET `spell1` = 64663, `spell2` = 63760, `spell3` = 13704, `equipment_id` = 1848, `mechanic_immune_mask` = 33554513, `unit_class` = 2, `dmg_multiplier` = 20, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 33818;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33818);
INSERT INTO `creature_ai_scripts` VALUES 
(3381801, 33818, 0, 0, 100, 3, 10000, 16000, 20000, 25000, 11, 64663, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Adherent - Cast Arcane Burst 10'),
(3381802, 33818, 0, 0, 100, 5, 10000, 16000, 20000, 25000, 11, 64663, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Adherent - Cast Arcane Burst 25'),
(3381803, 33818, 0, 0, 100, 3, 18000, 24000, 20000, 24000, 11, 63760, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Adherent - Cast Greater Heal 10'),
(3381804, 33818, 0, 0, 100, 5, 18000, 24000, 20000, 24000, 11, 63760, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Adherent - Cast Greater Heal 25'),
(3381805, 33818, 0, 0, 100, 3, 2000, 4000, 10000, 16000, 11, 13704, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Adherent - Cast Psychic Scream 10'),
(3381806, 33818, 0, 0, 100, 5, 2000, 4000, 10000, 16000, 11, 13704, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Adherent - Cast Psychic Scream 25');

-- Twilight Guardian
UPDATE `creature_template` SET `spell1` = 52719, `spell2` = 62317, `spell3` = 63757, `mechanic_immune_mask` = 33554513, `equipment_id` = 1852, `dmg_multiplier` = 40, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 33822;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33822);
INSERT INTO `creature_ai_scripts` VALUES 
(3382201, 33822, 0, 0, 100, 3, 6000, 10000, 8000, 10000, 11, 52719, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Guardian - Cast Concussion Blow 10'),
(3382202, 33822, 0, 0, 100, 5, 6000, 10000, 8000, 10000, 11, 52719, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Guardian - Cast Concussion Blow 25'),
(3382203, 33822, 0, 0, 100, 3, 2000, 3000, 3000, 6000, 11, 62317, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Guardian - Cast Devastate 10'),
(3382204, 33822, 0, 0, 100, 5, 2000, 3000, 3000, 6000, 11, 62317, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Guardian - Cast Devastate 25'),
(3382205, 33822, 0, 0, 100, 3, 16000, 18000, 14000, 16000, 11, 63757, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Guardian - Cast Thunderclap 10'),
(3382206, 33822, 0, 0, 100, 5, 16000, 18000, 14000, 16000, 11, 63757, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Guardian - Cast Thunderclap 25');

-- Twilight Shadowblade
UPDATE `creature_template` SET `spell1` = 63753, `mechanic_immune_mask` = 33554513,  `equipment_id` = 1862, `dmg_multiplier` = 25, `baseattacktime` = 1000, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 33824;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33824);
INSERT INTO `creature_ai_scripts` VALUES 
(3382401, 33824, 0, 0, 100, 3, 6000, 8000, 14000, 16000, 11, 63753, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Shadowblade - Cast Fan of Knives 10'),
(3382402, 33824, 0, 0, 100, 5, 6000, 8000, 14000, 16000, 11, 63753, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Shadowblade - Cast Fan of Knives 25');

-- Twilight Slayer
UPDATE `creature_template` SET `spell1` = 63784, `spell2` = 35054, `mechanic_immune_mask` = 33554513, `equipment_id` = 1847, `dmg_multiplier` = 50, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 33823;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33823);
INSERT INTO `creature_ai_scripts` VALUES 
(3382301, 33823, 0, 0, 100, 3, 3000, 5000, 16000, 20000, 11, 35054, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Slayer - Cast Mortal Strike 10'),
(3382302, 33823, 0, 0, 100, 5, 3000, 5000, 8000, 10000, 11, 35054, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Slayer - Cast Mortal Strike 25'),
(3382303, 33823, 0, 0, 100, 3, 9000, 12000, 28000, 34000, 11, 63784, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Slayer - Cast Bladestorm 10'),
(3382304, 33823, 0, 0, 100, 5, 9000, 12000, 28000, 34000, 11, 63784, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Slayer - Cast Bladestorm 25');

UPDATE `creature_template` SET `mindmg` = 464, `maxdmg` = 604, `attackpower` = 708, `minrangedmg` = 353, `maxrangedmg` = 512, `rangedattackpower` = 112 WHERE `entry` IN (33818, 33822, 33823, 33824, 33772, 33819, 33820, 33838);
UPDATE `creature_template` SET `equipment_id` = 1849 WHERE `entry` = 32885;
UPDATE `creature_template` SET `equipment_id` = 1850 WHERE `entry` = 32908;

-- Faceless Horror
UPDATE `creature_template` SET `spell1` = 64429, `spell2` = 63722, `spell3` = 63710, `spell4` = 63703, `mechanic_immune_mask` = 33554513, `dmg_multiplier` = 65, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 33772;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33772);
INSERT INTO `creature_ai_scripts` VALUES 
(3377201, 33772, 0, 0, 100, 3, 18000, 22000, 15000, 20000, 11, 64429, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Faceless Horror - Cast Death Grip 10'),
(3377202, 33772, 0, 0, 100, 5, 18000, 22000, 15000, 20000, 11, 64429, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Faceless Horror - Cast Death Grip 25'),
(3377203, 33772, 0, 0, 100, 3, 2000, 4000, 10000, 12000, 11, 63722, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Faceless Horror - Cast Shadow Crash 10'),
(3377204, 33772, 0, 0, 100, 5, 2000, 4000, 10000, 12000, 11, 63722, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Faceless Horror - Cast Shadow Crash 25'),
(3377205, 33772, 4, 0, 100, 3, 0, 0, 0, 0, 11, 63703, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Faceless Horror - Cast Void Wave 10'),
(3377206, 33772, 4, 0, 100, 5, 0, 0, 0, 0, 11, 63703, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Faceless Horror - Cast Void Wave 25');

-- Twilight Frost Mage
UPDATE `creature_template` SET `spell1` = 64663, `spell2` = 63758, `spell3` = 63912, `spell4` = 63913, `equipment_id` = 1849, `mechanic_immune_mask` = 33554513, `unit_class` = 2, `dmg_multiplier` = 20, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 33819;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33819);
INSERT INTO `creature_ai_scripts` VALUES 
(3381901, 33819, 0, 0, 100, 3, 10000, 16000, 20000, 25000, 11, 64663, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Frost Mage - Cast Arcane Burst 10'),
(3381902, 33819, 0, 0, 100, 5, 10000, 16000, 20000, 25000, 11, 64663, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Frost Mage - Cast Arcane Burst 25'),
(3381903, 33819, 0, 0, 100, 3, 1000, 2000, 6000, 8000, 11, 63913, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Frost Mage - Cast Frostbolt 10'),
(3381904, 33819, 0, 0, 100, 5, 1000, 2000, 6000, 8000, 11, 63913, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Frost Mage - Cast Frostbolt 25'),
(3381905, 33819, 0, 0, 100, 3, 2000, 4000, 10000, 16000, 11, 63758, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Frost Mage - Cast Frost Bolt Volley 10'),
(3381906, 33819, 0, 0, 100, 5, 2000, 4000, 10000, 16000, 11, 63758, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Frost Mage - Cast Frost Bolt Volley 25'),
(3381907, 33819, 0, 0, 100, 3, 8000, 10000, 12000, 16000, 11, 63912, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Frost Mage - Cast Frost Nova 10'),
(3381908, 33819, 0, 0, 100, 5, 8000, 10000, 12000, 16000, 11, 63912, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Frost Mage - Cast Frost Nova 25');

-- Twilight Pyromancer
UPDATE `creature_template` SET `spell1` = 64663, `spell2` = 63789, `spell3` = 63775, `equipment_id` = 1848, `mechanic_immune_mask` = 33554513, `unit_class` = 2, `dmg_multiplier` = 20, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 33820;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33820);
INSERT INTO `creature_ai_scripts` VALUES 
(3382001, 33820, 0, 0, 100, 3, 10000, 16000, 20000, 25000, 11, 64663, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Pyromancer - Cast Arcane Burst 10'),
(3382002, 33820, 0, 0, 100, 5, 10000, 16000, 20000, 25000, 11, 64663, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Pyromancer - Cast Arcane Burst 25'),
(3382003, 33820, 0, 0, 100, 3, 1000, 2000, 6000, 8000, 11, 63789, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Pyromancer - Cast Fireball 10'),
(3382004, 33820, 0, 0, 100, 5, 1000, 2000, 6000, 8000, 11, 63789, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Pyromancer - Cast Fireball 25'),
(3382005, 33820, 0, 0, 100, 3, 2000, 4000, 10000, 16000, 11, 63775, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Pyromancer - Cast Flamestrike 10'),
(3382006, 33820, 0, 0, 100, 5, 2000, 4000, 10000, 16000, 11, 63775, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Pyromancer - Cast Flamestrike 25');

-- Enslaved Fire Elemental
UPDATE `creature_template` SET `spell1` = 38064, `spell2` = 63778, `mechanic_immune_mask` = 33554513, `dmg_multiplier` = 15, `mingold` = 7100, `maxgold` = 7600, `AIName` = 'EventAI' WHERE `entry` = 33838;
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=33838);
INSERT INTO `creature_ai_scripts` VALUES 
(3383801, 33838, 0, 0, 100, 3, 4000, 8000, 12000, 14000, 11, 38064, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Fire Elemental - Cast Blast Wave 10'),
(3383802, 33838, 0, 0, 100, 5, 4000, 8000, 12000, 14000, 11, 38064, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Fire Elemental - Cast Blast Wave 25'),
(3383803, 33838, 4, 0, 100, 3, 0, 0, 0, 0, 11, 63778, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Fire Elemental - Cast Fire Shield 10'),
(3383804, 33838, 4, 0, 100, 5, 0, 0, 0, 0, 11, 63778, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Fire Elemental - Cast Fire Shield 25');



-- Flame Leviathan
UPDATE `creature_template` SET `dmg_multiplier` = 40, `mingold` = 1720000, `maxgold` = 1760000 WHERE `entry` = 33118;

-- Ignis
UPDATE `creature_template` SET `dmg_multiplier` = 45, `mingold` = 1720000, `maxgold` = 1760000 WHERE `entry` = 33118;
UPDATE `creature_template` SET `dmg_multiplier` = 21 WHERE `entry` = 33121;

-- Razorscale
UPDATE `creature_template` SET `dmg_multiplier` = 45, `mingold` = 1720000, `maxgold` = 1760000 WHERE `entry` = 33186;
UPDATE `creature_template` SET `dmg_multiplier` = 15 WHERE `entry` IN (33453, 33388);
UPDATE `creature_template` SET `dmg_multiplier` = 23 WHERE `entry` = 33846;

-- XT-002
UPDATE `creature_template` SET `dmg_multiplier` = 80, `mingold` = 1720000, `maxgold` = 1760000 WHERE `entry` = 33293;

-- Assembly of Iron
UPDATE `creature_template` SET `dmg_multiplier` = 95, `AIName` = '' WHERE `entry` = 32867;
UPDATE `creature_template` SET `dmg_multiplier` = 60, `AIName` = '' WHERE `entry` = 32927;
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 32857;

-- Kologarn
UPDATE `creature_template` SET `dmg_multiplier` = 65 WHERE `entry` = 32930;

-- Hodir
UPDATE `creature_template` SET `dmg_multiplier` = 60 WHERE `entry` = 32845;

-- Auriaya
UPDATE `creature_template` SET `dmg_multiplier` = 65, `unit_class` = 1, `mingold` = 1720000, `maxgold` = 1760000, `mechanic_immune_mask` = 617299803 WHERE `entry` = 33515;
UPDATE `creature_template` SET `speed_walk` = 2, `speed_run` = 2, `dmg_multiplier` = 3 WHERE `entry` = 34035;

-- Freya
UPDATE `creature_template` SET `dmg_multiplier` = 50 WHERE `entry` = 32906;
UPDATE `creature_template` SET `mindmg` = 464, `maxdmg` = 604, `attackpower` = 708, `dmg_multiplier` = 7.5, `minrangedmg` = 353, `maxrangedmg` = 512, `rangedattackpower` = 112 WHERE `entry` = 32918;
UPDATE `creature_template` SET `mindmg` = 464, `maxdmg` = 604, `attackpower` = 708, `dmg_multiplier` = 40, `minrangedmg` = 353, `maxrangedmg` = 512, `rangedattackpower` = 112, `mechanic_immune_mask` = 650854235 WHERE `entry` = 33203;
UPDATE `creature_template` SET `mindmg` = 464, `maxdmg` = 604, `attackpower` = 708, `dmg_multiplier` = 25, `minrangedmg` = 353, `maxrangedmg` = 512, `rangedattackpower` = 112 WHERE `entry` = 33202;
UPDATE `creature_template` SET `mindmg` = 464, `maxdmg` = 604, `attackpower` = 708, `dmg_multiplier` = 10, `minrangedmg` = 353, `maxrangedmg` = 512, `rangedattackpower` = 112 WHERE `entry` = 32919;
UPDATE `creature_template` SET `mindmg` = 464, `maxdmg` = 604, `attackpower` = 708, `dmg_multiplier` = 45, `minrangedmg` = 353, `maxrangedmg` = 512, `rangedattackpower` = 112 WHERE `entry` = 32916;

-- Thorim
UPDATE `creature_template` SET `dmg_multiplier` = 60 WHERE `entry` = 32865;
UPDATE `creature_template` SET `dmg_multiplier` = 35 WHERE `entry` IN (32882, 32872, 32873);
UPDATE `creature_template` SET `dmg_multiplier` = 20 WHERE `entry` IN (32908, 32876, 32877, 32874, 33125);
UPDATE `creature_template` SET `dmg_multiplier` = 15 WHERE `entry` IN (32885, 33110, 32878);
UPDATE `creature_template` SET `dmg_multiplier` = 10 WHERE `entry` = 32904;

-- Mimiron
UPDATE `creature_template` SET `mindmg` = 464, `maxdmg` = 604, `attackpower` = 708, `dmg_multiplier` = 75, `minrangedmg` = 353, `maxrangedmg` = 512, `rangedattackpower` = 112 WHERE `entry` = 33432;

-- Vezax
UPDATE `creature_template` SET `dmg_multiplier` = 65, `mingold` = 1720000, `maxgold` = 1760000 WHERE `entry` = 33271;

-- 8362_boss_vezax
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299803, `flags_extra` = 257, `ScriptName` = 'boss_general_vezax' WHERE `entry` = 33271;
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `mechanic_immune_mask` = 650854235, `ScriptName` = 'mob_saronite_vapors' WHERE `entry` = 33488;
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `mechanic_immune_mask` = 650854235, `ScriptName` = 'mob_saronite_animus' WHERE `entry` = 33524;

-- 8378_ulduar_modelid
-- XT-002
UPDATE `creature_model_info` SET `bounding_radius` = 0.465, `combat_reach` = 10 WHERE `modelid` = 28611;
UPDATE `creature_template` SET `dmg_multiplier` = 70 WHERE `entry` = 33293;
-- Assembly of Iron
UPDATE `creature_model_info` SET `bounding_radius` = 0.45, `combat_reach` = 25 WHERE `modelid` = 28313;
UPDATE `creature_model_info` SET `bounding_radius` = 0.45, `combat_reach` = 6 WHERE `modelid` = 28344;
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299547 WHERE `entry` = 32857;
UPDATE `creature_template` SET `dmg_multiplier` = 60 WHERE `entry` = 32867;
UPDATE `creature_template` SET `dmg_multiplier` = 45 WHERE `entry` = 32927;
-- Kologarn
UPDATE `creature_model_info` SET `bounding_radius` = 0.465, `combat_reach` = 15 WHERE `modelid` = 28638;
UPDATE `creature_model_info` SET `bounding_radius` = 0.35, `combat_reach` = 15 WHERE `modelid` = 28821;
UPDATE `creature_model_info` SET `bounding_radius` = 0.35, `combat_reach` = 15 WHERE `modelid` = 28822;
UPDATE `creature_template` SET `baseattacktime` = 1800 WHERE `entry` = 32930;
-- Auriaya
UPDATE `creature_model_info` SET `bounding_radius` = 0.775, `combat_reach` = 5 WHERE `modelid` = 28651;
UPDATE `creature_template` SET `dmg_multiplier` = 60 WHERE `entry` = 33515;
-- Freya
UPDATE `creature_template` SET `baseattacktime` = 1500 WHERE `entry` = 32906;
-- Mimiron
UPDATE `creature_model_info` SET `bounding_radius` = 0.775, `combat_reach` = 7 WHERE `modelid` = 28831;
UPDATE `creature_model_info` SET `bounding_radius` = 0.775, `combat_reach` = 5 WHERE `modelid` = 28841;
UPDATE `creature_model_info` SET `bounding_radius` = 0.775, `combat_reach` = 4 WHERE `modelid` = 28979;
-- Genaral Vezax
UPDATE `creature_template` SET `baseattacktime` = 1800, `dmg_multiplier` = 45 WHERE `entry` = 33271;
UPDATE `creature_model_info` SET `bounding_radius` = 0.62, `combat_reach` = 12 WHERE `modelid` = 28548;
UPDATE `creature` SET `spawntimesecs` = 604800 WHERE `id` = 33838;

-- 8406_emalon
UPDATE creature_template SET lootid = 33993, mindmg = 509, maxdmg = 683, attackpower = 805, dmg_multiplier = 35 WHERE entry = 33993;
UPDATE creature_template SET lootid = 33994, mindmg = 509, maxdmg = 683, attackpower = 805, dmg_multiplier = 70 WHERE entry = 33994;

-- 8407_voa&emalon
UPDATE creature SET spawnMask = 1 WHERE id = 33993;
UPDATE creature_template SET faction_A = 16, faction_H = 16 WHERE entry = 33994;
UPDATE creature_template SET mindmg = 422, maxdmg = 586, attackpower = 642, dmg_multiplier = 7.5, minrangedmg = 345, maxrangedmg = 509, rangedattackpower = 103 WHERE entry = 33998;

-- 8422 ulduar_loots_hardmode
UPDATE `creature_template` SET `unit_flags` = 2 WHERE `entry` = 33686;
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` = 33779;
DELETE FROM `creature_template` WHERE entry = 33115;
DELETE FROM creature WHERE id = 33115;

-- Emblem of Valor
UPDATE creature_loot_template SET item = 40753 WHERE entry IN (33113, 33186, 33118, 33293, 32927, 32857, 33515, 33271) AND item = 45624;
UPDATE gameobject_loot_template SET item = 40753 WHERE entry IN (27061, 26963, 27078, 27081, 26955, 26946, 27068) AND item = 40752;

-- Flame Leviathan
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299803 WHERE `entry` = 33113;

-- XT-002 Hardmode loot

DELETE FROM `creature_loot_template` WHERE `entry`=33293;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('33293','40753','100','1','0','1','1'),
('33293','1','100','1','0','-34121','2'),
('33293','45867','0','2','2','1','1'),
('33293','45868','0','2','2','1','1'),
('33293','45869','0','2','2','1','1'),
('33293','45870','0','2','2','1','1'),
('33293','45871','0','2','2','1','1');

DELETE FROM `reference_loot_template` WHERE `entry`=34121;
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('34121','45675','0','1','1','1','1'),
('34121','45676','0','1','1','1','1'),
('34121','45677','0','1','1','1','1'),
('34121','45679','0','1','1','1','1'),
('34121','45680','0','1','1','1','1'),
('34121','45682','0','1','1','1','1'),
('34121','45685','0','1','1','1','1'),
('34121','45686','0','1','1','1','1'),
('34121','45687','0','1','1','1','1'),
('34121','45694','0','1','1','1','1');

-- Assembly of Iron Hardmode loot

DELETE FROM `creature_loot_template` WHERE `entry` IN (32857, 32927, 32867);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('32857','40753','100','1','0','1','1'),
('32857','1','100','1','0','-34122','2'),
('32927','40753','100','1','0','2','2'),
('32927','1','100','1','0','-34122','3'),
('32867','45624','100','1','0','1','1'),
('32867','1','100','1','0','-34122','2'),
('32867','45447','0','2','2','1','1'),
('32867','45448','0','2','2','1','1'),
('32867','45449','0','2','2','1','1'),
('32867','45455','0','2','2','1','1'),
('32867','45456','0','2','2','1','1');

DELETE FROM `reference_loot_template` WHERE `entry`=34122;
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('34122','45322','0','1','1','1','1'),
('34122','45324','0','1','1','1','1'),
('34122','45329','0','1','1','1','1'),
('34122','45330','0','1','1','1','1'),
('34122','45331','0','1','1','1','1'),
('34122','45332','0','1','1','1','1'),
('34122','45333','0','1','1','1','1'),
('34122','45378','0','1','1','1','1'),
('34122','45418','0','1','1','1','1'),
('34122','45423','0','1','1','1','1');

-- Freya Hardmode loot

UPDATE `creature_template` SET `mechanic_immune_mask` = 650853979  WHERE `entry` = 33203;
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` = 33215;
DELETE FROM `gameobject_loot_template` WHERE `entry` IN (27078, 27079, 27080, 27081);
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('27078','1','100','1','0','-34125','1'),
('27078','2','100','1','0','-34105','1'),
('27078','40753','100','1','0','1','1'),
('27078','45087','100','1','0','1','1'),
('27078','45644','0','1','1','1','1'),
('27078','45645','0','1','1','1','1'),
('27078','45646','0','1','1','1','1'),
('27078','46110','100','1','0','1','1'),
('27079','1','100','1','0','-34125','2'),
('27079','2','100','1','0','-34105','1'),
('27079','40753','100','1','0','1','1'),
('27079','45087','100','1','0','1','1'),
('27079','45644','0','1','1','1','1'),
('27079','45645','0','1','1','1','1'),
('27079','45646','0','1','1','1','1'),
('27079','46110','100','1','0','1','1'),
('27080','1','100','1','0','-34125','2'),
('27080','2','100','1','0','-34105','1'),
('27080','40753','100','1','0','2','2'),
('27080','45087','100','1','0','1','1'),
('27080','45644','0','1','1','1','1'),
('27080','45645','0','1','1','1','1'),
('27080','45646','0','1','1','1','1'),
('27080','46110','100','1','0','1','1'),
('27081','1','100','1','0','-34125','1'),
('27081','2','100','1','0','-34105','1'),
('27081','45943','0','1','2','1','1'),
('27081','45945','0','1','2','1','1'),
('27081','45946','0','1','2','1','1'),
('27081','45294','0','1','2','1','1'),
('27081','45947','0','1','2','1','1'),
('27081','45624','100','1','0','1','1'),
('27081','45087','100','1','0','1','1'),
('27081','45644','0','1','1','1','1'),
('27081','45645','0','1','1','1','1'),
('27081','45646','0','1','1','1','1'),
('27081','45788','-100','1','0','1','1'),
('27081','46110','100','1','0','1','1');

DELETE FROM `gameobject_template` WHERE entry = 194326;
INSERT INTO `gameobject_template` VALUES('194326','3','8628','Freya\'s Gift','','','','0','0','2','0','0','0','0','0','0','1634','27080','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','11159');

DELETE FROM `reference_loot_template` WHERE `entry`=34125;
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('34125','45934','0','1','1','1','1'),
('34125','45935','0','1','1','1','1'),
('34125','45936','0','1','1','1','1'),
('34125','45940','0','1','1','1','1'),
('34125','45941','0','1','1','1','1');

-- Hodir Harmode loot

UPDATE script_texts SET `type` = 2 WHERE entry = -1603218;
DELETE FROM `gameobject` WHERE `id`=194200;
INSERT INTO `gameobject` (`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(194200, 603, 1, 1, 2038.29, -200.702, 432.687, 3.12232, 0, 0, 1, 0, 300, 0, 1);

DELETE FROM `gameobject_loot_template` WHERE entry=27069;
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('27069','45624','100','1','0','1','1'),
('27069','45888','0','1','1','1','1'),
('27069','45886','0','1','1','1','1'),
('27069','45887','0','1','1','1','1'),
('27069','45877','0','1','1','1','1'),
('27069','45876','0','1','1','1','1'),
('27069','45786','-100','1','0','1','1');

-- Thorim Hardmode loot

DELETE FROM `gameobject` WHERE `id`=194314;
UPDATE `gameobject_template` SET `faction` = 0, `flags` = 0 WHERE `entry` IN (194312, 194313);

DELETE FROM `gameobject_loot_template` WHERE entry IN (27073, 27074);
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('27073','40753','100','1','0','1','1'),
('27073','1','100','1','0','-34130','1'),
('27073','45659','0','1','1','1','1'),
('27073','45660','0','1','1','1','1'),
('27073','45661','0','1','1','1','1'),
('27074','45624','100','1','0','1','1'),
('27074','1','100','1','0','-34130','1'),
('27074','45928','0','1','2','1','1'),
('27074','45929','0','1','2','1','1'),
('27074','45930','0','1','2','1','1'),
('27074','45931','0','1','2','1','1'),
('27074','45933','0','1','2','1','1'),
('27074','45659','0','1','1','1','1'),
('27074','45660','0','1','1','1','1'),
('27074','45661','0','1','1','1','1'),
('27074','45784','-100','3','0','1','1');

DELETE FROM `reference_loot_template` WHERE entry = 34130;
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('34130','45892','0','1','1','1','1'),
('34130','45893','0','1','1','1','1'),
('34130','45894','0','1','1','1','1'),
('34130','45895','0','1','1','1','1'),
('34130','45927','0','1','1','1','1');

-- Mimiron Hardmode loot

DELETE FROM `gameobject` WHERE `id`=194956;
DELETE FROM `gameobject_template` WHERE entry = 194790;
INSERT INTO `gameobject_template` VALUES ('194790','3','8686','Cache of Innovation','','','','0','0','1.5','0','0','0','0','0','0','1634','27086','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','11159');

DELETE FROM `gameobject_loot_template` WHERE entry IN (27085, 27086);
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('27085','40753','100','1','0','1','1'),
('27085','1','100','1','0','-34129','1'),
('27085','45647','0','1','1','1','1'),
('27085','45648','0','1','1','1','1'),
('27085','45649','0','1','1','1','1'),
('27086','45624','100','1','0','1','1'),
('27086','1','100','1','0','-34129','1'),
('27086','45982','0','1','2','1','1'),
('27086','45988','0','1','2','1','1'),
('27086','45989','0','1','2','1','1'),
('27086','45990','0','1','2','1','1'),
('27086','45993','0','1','2','1','1'),
('27086','45647','0','1','1','1','1'),
('27086','45648','0','1','1','1','1'),
('27086','45649','0','1','1','1','1'),
('27086','45787','-100','1','0','1','1');

DELETE FROM `reference_loot_template` WHERE entry = 34129;
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('34129','45972','0','1','1','1','1'),
('34129','45973','0','1','1','1','1'),
('34129','45974','0','1','1','1','1'),
('34129','45975','0','1','1','1','1'),
('34129','45976','0','1','1','1','1');

-- General Vezax Hardmode loot

DELETE FROM `creature_loot_template` WHERE entry = 33271;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('33271','40753','100','1','0','1','1'),
('33271','1','100','1','0','-34131','2'),
('33271','46032','0','2','2','1','1'),
('33271','46033','0','2','2','1','1'),
('33271','46034','0','2','2','1','1'),
('33271','46035','0','2','2','1','1'),
('33271','46036','0','2','2','1','1');

DELETE FROM `reference_loot_template` WHERE entry = 34131;
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('34131','45996','0','1','1','1','1'),
('34131','45997','0','1','1','1','1'),
('34131','46008','0','1','1','1','1'),
('34131','46009','0','1','1','1','1'),
('34131','46010','0','1','1','1','1'),
('34131','46011','0','1','1','1','1'),
('34131','46012','0','1','1','1','1'),
('34131','46013','0','1','1','1','1'),
('34131','46014','0','1','1','1','1'),
('34131','46015','0','1','1','1','1');

-- 8410_vezax_animus
UPDATE `creature_template` SET `mindmg` = 464, `maxdmg` = 604, `attackpower` = 708, `dmg_multiplier` = 25, `minrangedmg` = 353, `maxrangedmg` = 512, `rangedattackpower` = 112 WHERE `entry` = 33524;
UPDATE `creature_model_info` SET `bounding_radius` = 0.62, `combat_reach` = 10 WHERE `modelid` = 28992;

-- mimiron_hardmode
UPDATE `gameobject_template` SET `type` = 1, `flags` = 32, `ScriptName` = 'not_push_button' WHERE `entry` = 194739;
UPDATE `creature_template` SET `unit_flags` = 33554946, `speed_walk` = 0.15, `speed_run` = 0.15, `ScriptName` = 'mob_mimiron_flame' WHERE `entry` = 34363;
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `ScriptName` = 'mob_frost_bomb' WHERE `entry` = 34149;
UPDATE `creature_template` SET `mindmg` = 464, `maxdmg` = 604, `attackpower` = 708, `dmg_multiplier` = 7.5, `minrangedmg` = 353, `maxrangedmg` = 512, `rangedattackpower` = 112, `ScriptName` = 'mob_junk_bot' WHERE `entry` = 33855;
UPDATE `creature_template` SET `mindmg` = 464, `maxdmg` = 604, `attackpower` = 708, `dmg_multiplier` = 15, `minrangedmg` = 353, `maxrangedmg` = 512, `rangedattackpower` = 112, `ScriptName` = 'mob_assault_bot' WHERE `entry` = 34057;
UPDATE `creature_template` SET `mindmg` = 464, `maxdmg` = 604, `attackpower` = 708, `dmg_multiplier` = 10, `minrangedmg` = 353, `maxrangedmg` = 512, `rangedattackpower` = 112, `ScriptName` = 'mob_boom_bot' WHERE `entry` = 33836;
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `ScriptName` = 'mob_emergency_bot' WHERE `entry` = 34147;

-- 8407_emalon
UPDATE creature SET spawnMask = 1 WHERE id = 33993;
UPDATE creature_template SET faction_A = 16, faction_H = 16 WHERE entry = 33994;
UPDATE creature_template SET mindmg = 422, maxdmg = 586, attackpower = 642, dmg_multiplier = 7.5, minrangedmg = 345, maxrangedmg = 509, rangedattackpower = 103 WHERE entry = 33998;

-- 8429_leviathan_encounter
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=62475;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
('62475','9032','2','System Shutdown');

DELETE FROM areatrigger_scripts WHERE entry IN (5369, 5423);
INSERT INTO areatrigger_scripts VALUES
(5369,'at_RX_214_repair_o_matic_station'),
(5423,'at_RX_214_repair_o_matic_station');

-- 8436_dalaran_teleporter
UPDATE `gameobject_template` SET `type` = 22, `data0` = 53141, `data2` = 1, `data3` = 1 WHERE `entry` = 194481;

-- 8440_achievement_antechamber
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10578, 10579, 10580, 10581);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES
(10578, 12, 0, 0),
(10580, 12, 0, 0),
(10579, 12, 1, 0),
(10581, 12, 1, 0);

-- 8441_bind
UPDATE `creature_template` SET Health_mod = 50 WHERE `entry` = 33109;
UPDATE `creature_template` SET Health_mod = 90 WHERE `entry` = 33060;
UPDATE `creature_template` SET Health_mod = 40 WHERE `entry` = 33062;

UPDATE `creature_template` SET `dmg_multiplier` = 55, `flags_extra` = 9 WHERE `entry` = 33118;
UPDATE `creature_template` SET `dmg_multiplier` = 50, flags_extra = 1 WHERE `entry` = 33186;
UPDATE `creature_template` SET `dmg_multiplier` = 75, flags_extra = 1 WHERE `entry` = 33293;
UPDATE `creature_template` SET flags_extra = 257 WHERE entry IN (33113, 33271); 
UPDATE `creature_template` SET flags_extra = 1 WHERE entry IN (32867, 32927, 32857, 32930, 33515, 32906, 32845, 33350, 33432, 33651, 33670, 32865, 33288);

-- 8441_achievement_keepers
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10598, 10599, 10559, 10444, 10563, 10455, 10558, 10438, 10561, 10454, 10408, 10560, 10453, 10562);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES
-- Freya
(10559, 12, 0, 0),
(10444, 12, 0, 0),
(10563, 12, 1, 0),
(10455, 12, 1, 0),
-- Thorim
(10558, 12, 0, 0),
(10438, 12, 0, 0),
(10561, 12, 1, 0),
(10454, 12, 1, 0),
-- Hodir
(10408, 12, 0, 0),
(10560, 12, 0, 0),
(10453, 12, 1, 0),
(10562, 12, 1, 0);

-- 8447
-- dalaran portal
UPDATE `gameobject_template` SET `faction` = 2007, `data0` = 53141, `data2` = 0 WHERE `entry` = 194481;

-- 8444_ulduar_bind
UPDATE `creature_template` SET Health_mod = 50 WHERE `entry` = 33109;
UPDATE `creature_template` SET Health_mod = 90 WHERE `entry` = 33060;
UPDATE `creature_template` SET Health_mod = 40 WHERE `entry` = 33062;

UPDATE `creature_template` SET `dmg_multiplier` = 55, `flags_extra` = 9 WHERE `entry` = 33118;
UPDATE `creature_template` SET `dmg_multiplier` = 50, flags_extra = 1 WHERE `entry` = 33186;
UPDATE `creature_template` SET `dmg_multiplier` = 75, flags_extra = 1 WHERE `entry` = 33293;
UPDATE `creature_template` SET flags_extra = 257 WHERE entry IN (33113, 33271); 
UPDATE `creature_template` SET flags_extra = 1 WHERE entry IN (32867, 32927, 32857, 32930, 33515, 32906, 32845, 33350, 33432, 33651, 33670, 32865, 33288);

-- 8451_vehicle_regen
-- Ulduar vehicle regen and Freya's Healthy Spores
UPDATE `creature_template` SET `flags_extra` = 0 WHERE `entry` = 33215;
UPDATE `creature_template` SET `RegenHealth` = 0 WHERE `entry` IN (33060, 33062, 33109);

-- 8452_keepers_images
-- Ulduar Keepers Images
DELETE FROM `creature` WHERE `id` IN (33213, 33241, 33242, 33244);
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(33241, 603, 1, 1, 0, 0, 2057.81, -24.0768, 421.532, 3.12904, 604800, 0, 0, 14433075, 0, 0, 0),
(33242, 603, 1, 1, 0, 0, 2036.81, -73.7053, 411.353, 2.43575, 604800, 0, 0, 14433075, 0, 0, 0),
(33244, 603, 1, 1, 0, 0, 2036.74, 25.4642, 411.357, 3.81412, 604800, 0, 0, 14433075, 0, 0, 0),
(33213, 603, 1, 1, 0, 0, 1939.29, -90.6994, 411.357, 1.02595, 604800, 0, 0, 14433075, 0, 0, 0);

UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35, `npcflag` = 1, `flags_extra` = 2, `ScriptName` = 'npc_keeper_image' WHERE `entry` IN (33213, 33241, 33242, 33244);

-- 8453_razorscale_yell
-- razorscale yell fix
UPDATE `script_texts` SET `content_default` = "Move! Quickly! She won't remain grounded for long.", `type` = 1  WHERE `entry` = -1603261;

-- script names faltantes
UPDATE `creature_template` SET `ScriptName` = 'boss_elder_ironbranch' WHERE `entry` =32913;
UPDATE `creature_template` SET `ScriptName` = 'boss_elder_stonebark' WHERE `entry` =32914;
UPDATE `creature_template` SET `ScriptName` = 'boss_elder_brightleaf' WHERE `entry` =32195;
UPDATE `creature_template` SET `ScriptName` = 'creature_iron_roots' WHERE `entry` =33088;
UPDATE `creature_template` SET `ScriptName` = 'creature_sun_beam' WHERE `entry` =33170;

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `player_factionchange_reputations`
-- ----------------------------
DROP TABLE IF EXISTS `player_factionchange_reputations`;
CREATE TABLE `player_factionchange_reputations` (
  `alliance_id` int(8) NOT NULL,
  `horde_id` int(8) NOT NULL,
  PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of player_factionchange_reputations
-- ----------------------------

-- ----------------------------
-- Table structure for `player_factionchange_spells`
-- ----------------------------
DROP TABLE IF EXISTS `player_factionchange_spells`;
CREATE TABLE `player_factionchange_spells` (
  `alliance_id` int(8) NOT NULL,
  `horde_id` int(8) NOT NULL,
  PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of player_factionchange_spells
-- ----------------------------

-- ----------------------------
-- Table structure for `player_factionchange_items`
-- ----------------------------
DROP TABLE IF EXISTS `player_factionchange_items`;
CREATE TABLE `player_factionchange_items` (
  `alliance_id` int(8) NOT NULL,
  `horde_id` int(8) NOT NULL,
  PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of player_factionchange_items
-- ----------------------------

-- ----------------------------
-- Table structure for `player_factionchange_achievements`
-- ----------------------------
DROP TABLE IF EXISTS `player_factionchange_achievements`;
CREATE TABLE `player_factionchange_achievements` (
  `alliance_id` int(8) NOT NULL,
  `horde_id` int(8) NOT NULL,
  PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of player_factionchange_achievements
-- ----------------------------

ALTER TABLE db_version CHANGE COLUMN required_31_world_db_version required_2_world_fixes bit;

-- IcecrownCitadel
DELETE FROM `gameobject_scripts` WHERE id= 201584;

-- EyeOfEternity
DELETE FROM achievement_criteria_data WHERE criteria_id = 1400;
UPDATE `creature_template` SET `difficulty_entry_1` = '0' WHERE `creature_template`.`entry` =28859 LIMIT 1 ;

-- TheOculus
UPDATE `creature` SET `phaseMask` = '1' WHERE `creature`.`guid` =86828 LIMIT 1;
UPDATE `creature` SET `phaseMask` = '1' WHERE `creature`.`guid` =86829 LIMIT 1;
UPDATE `creature` SET `phaseMask` = '1' WHERE `creature`.`guid` =86830 LIMIT 1;
UPDATE `creature` SET `phaseMask` = '1' WHERE `creature`.`guid` =86831 LIMIT 1;
UPDATE `creature` SET `phaseMask` = '1' WHERE `creature`.`guid` =86832 LIMIT 1;
UPDATE `creature` SET `phaseMask` = '1' WHERE `creature`.`guid` =86833 LIMIT 1;
UPDATE `creature` SET `phaseMask` = '1' WHERE `creature`.`guid` =86834 LIMIT 1;
UPDATE `creature` SET `phaseMask` = '1' WHERE `creature`.`guid` =86835 LIMIT 1;
DELETE FROM `creature_questrelation` WHERE `id` = 27658; 
DELETE FROM `creature_involvedrelation` WHERE `id` = 27658; 

-- ObsidianSanctum
UPDATE `creature` SET `MovementType` = '0' WHERE `creature`.`guid` =123400 LIMIT 1;
UPDATE `creature` SET `MovementType` = '0' WHERE `creature`.`guid` =123401 LIMIT 1;
UPDATE `creature` SET `MovementType` = '0' WHERE `creature`.`guid` =123402 LIMIT 1;
UPDATE `creature` SET `MovementType` = '0' WHERE `creature`.`guid` =123403 LIMIT 1;
UPDATE `creature` SET `MovementType` = '0' WHERE `creature`.`guid` =123404 LIMIT 1;
UPDATE `creature_template` SET `difficulty_entry_1` = '0' WHERE `creature_template`.`entry` =31214 LIMIT 1 ;
UPDATE `creature_template` SET `difficulty_entry_1` = '0' WHERE `creature_template`.`entry` =30890 LIMIT 1 ;

-- RubySanctum
UPDATE `creature_template` SET `difficulty_entry_2` = '0' WHERE `creature_template`.`entry` =39751 LIMIT 1 ;
UPDATE `gameobject` SET `spawnMask` = '1' WHERE `gameobject`.`guid` =750008 LIMIT 1;
UPDATE `gameobject` SET `spawnMask` = '1' WHERE `gameobject`.`guid` =750007 LIMIT 1;
UPDATE `gameobject` SET `spawnMask` = '1' WHERE `gameobject`.`guid` =750006 LIMIT 1;
UPDATE `gameobject` SET `spawnMask` = '1' WHERE `gameobject`.`guid` =750005 LIMIT 1;

-- TrialOfTheChampion
-- need add fix loot

-- TrialOfTheCrusader
UPDATE `creature_template` SET `unit_class` = '1',
`type` = '0',
`MovementType` = '1',
`InhabitType` = '1' WHERE `creature_template`.`entry` =41000 LIMIT 1;

-- Ulduar
UPDATE `creature_addon` SET `auras` = NULL WHERE `creature_addon`.`guid` =137496 LIMIT 1;
UPDATE `creature_template` SET `difficulty_entry_1` = '0' WHERE `creature_template`.`entry` =33240 LIMIT 1 ;
UPDATE `creature_template` SET `unit_class` = '2' WHERE `creature_template`.`entry` =33515 LIMIT 1;
UPDATE `creature_template` SET `unit_class` = '1' WHERE `creature_template`.`entry` =32918 LIMIT 1;
UPDATE `creature_template` SET `unit_class` = '1' WHERE `creature_template`.`entry` =33399 LIMIT 1;
UPDATE `creature_template` SET `unit_class` = '2' WHERE `creature_template`.`entry` =34175 LIMIT 1;
update gameobject_scripts set `command`=11 where `id`=55194;  

ALTER TABLE db_version CHANGE COLUMN required_2_world_fixes required_3_world_icecrown_citadel bit;

REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES (37672, 0, 38285, 0, 0, 0, 31008, 0, 31008, 0, 'Mutated Abomination', '', 'vehichleCursor', 0, 80, 80, 2, 35, 35, 0, 1, 1, 422, 586, 0, 642, 7.5, 2000, 2000, 1, 16384, 0, 0, 0, 0, 0, 0, 345, 509, 103, 6, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 72508, 72527, 70539, 70542, 0, 0, 0, 0, 0, 336, 0, 0, '', 0, 3, 108.471, 1, 0, 0, 0, 0, 0, 0, 0, 170, 1, 0, 609320197, 0, 'npc_abomination');

INSERT INTO spell_linked_spell VALUES (70157, 71665, 1, 'Sindragosa: Frost Tomb => Asphyxiation');
INSERT INTO spell_linked_spell VALUES (70117, 70122, 1, 'Sindragosa: Icy Grip Trigger => Icy Grip');
INSERT INTO spell_linked_spell VALUES (-71224, 69706, 0, 'Rotface: Mutated Infection => Little Ooze');
INSERT INTO spell_linked_spell VALUES (-69783, 69785, 0, 'Rotface: Flood => Flood1');
INSERT INTO spell_linked_spell VALUES (69785, 69788, 2, 'Rotface: Flood1 => Flood2');
INSERT INTO spell_linked_spell VALUES (71340, 71341, 2, 'Lanathel: Darkfallen1 => Darkfallen2');
INSERT INTO spell_linked_spell VALUES (-70308, 70311, 0, 'Abomination Transformation');

UPDATE creature_template SET ScriptName='boss_blood_council' WHERE entry=37970;
UPDATE creature_template SET ScriptName='boss_blood_elf_taldaram_icc' WHERE entry=37973;
UPDATE creature_template SET ScriptName='boss_blood_elf_keleset_icc' WHERE entry=37972;
UPDATE creature_template SET ScriptName='npc_nucleus_icc' WHERE entry=38369;
UPDATE creature_template SET ScriptName='npc_fireball_icc' WHERE entry=38332;
UPDATE creature_template SET ScriptName='npc_bomb_icc' WHERE entry=38454;
UPDATE creature_template SET ScriptName='npc_vortex_icc' WHERE entry=38422;
UPDATE creature_template SET ScriptName='npc_empfireball_icc' WHERE entry=38451; 

UPDATE `creature_template` SET `ScriptName` = 'boss_sindragosa' WHERE `entry` = '36853';
UPDATE `creature_template` SET `ScriptName` = 'npc_rimefang' WHERE `entry` = '37533';
UPDATE `creature_template` SET `ScriptName` = 'npc_spinestalker' WHERE `entry` = '37534';
UPDATE `creature_template` SET `ScriptName` = 'npc_ice_tomb' WHERE `entry` = '36980';
UPDATE `creature_template` SET `ScriptName` = 'npc_frost_bomb' WHERE `entry` = '37186';
UPDATE `creature_template` SET `ScriptName` = 'lanathel_intro' WHERE `entry` = '38004';
UPDATE `creature_template` SET `ScriptName` = 'Boss_Raid_Anubarak' WHERE `entry`='34564';
UPDATE `creature_template` SET `ScriptName` = 'Mob_NerubianTrigger' WHERE `entry`='34862';
UPDATE `creature_template` SET `ScriptName` = 'mob_swarm_scarab' WHERE `entry`='34605';
UPDATE `creature_template` SET `ScriptName` = 'nerubian_burrower' WHERE `entry`='34607';
UPDATE `creature_template` SET `ScriptName` = 'frost_sphere' WHERE `entry`='34606';
UPDATE `creature_template` SET `ScriptName` = 'creature_impale' WHERE `entry`='29184';
UPDATE `creature_template` SET `ScriptName` = 'cr_dark_essence' WHERE `entry`= '34567';
UPDATE `creature_template` SET `ScriptName` = 'cr_light_essence' WHERE `entry`= '34568';
UPDATE `creature_template` SET `ScriptName` = 'npc_puddle_ooze' WHERE `entry` = '37690';
UPDATE `creature_template` SET `ScriptName` = 'npc_malleable_goo' WHERE `entry` = '38556';
UPDATE `creature_template` SET `ScriptName` = 'npc_abomination' WHERE `entry` = '37672';

DELETE FROM `gameobject_scripts` WHERE `id`=201584;
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`) VALUES
(201584, 0, 15, 70308, 0, 'Transformation'),
(201584, 5000, 15, 70311, 0, 'Transformation End'),
(201584, 5000, 13, 201584, 0, 'Spawn');

REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES (34606, 0, 0, 0, 0, 0, 25144, 25144, 25144, 25144, 'Frost Sphere', '', '', 0, 80, 80, 2, 15, 15, 0, 1, 0, 420, 630, 0, 157, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 8, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66193, 67855, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 0.238095, 1, 0, 0, 0, 0, 0, 0, 0, 721, 1, 0, 536961024, 0, 'frost_sphere');

DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=34606);
INSERT INTO `creature_ai_scripts` VALUES 
(270000, 34606, 6, 0, 100, 7, 0, 0, 0, 0, 11, 66193, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Force Cast');

REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES (37672, 0, 38285, 0, 0, 0, 31008, 0, 31008, 0, 'Mutated Abomination', '', 'vehichleCursor', 0, 80, 80, 2, 35, 35, 0, 1, 1, 422, 586, 0, 642, 7.5, 2000, 2000, 1, 16384, 0, 0, 0, 0, 0, 0, 345, 509, 103, 6, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 72508, 72527, 70539, 70542, 0, 0, 0, 0, 0, 340, 0, 0, '', 0, 3, 108.471, 1, 0, 0, 0, 0, 0, 0, 0, 170, 1, 0, 609320197, 0, 'npc_abomination');

REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES (38159, 0, 0, 0, 0, 0, 27823, 27823, 27823, 0, 'Choking Gas Bomb', '', '', 0, 80, 80, 2, 2068, 2068, 0, 1, 0, 422, 586, 0, 642, 1.4, 2000, 2000, 1, 0, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 16778240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'EventAI', 0, 3, 4.71733, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 118429499, 0, 'npc_choke_bomb');

-- 10 Normal
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (11684,11685,11686,11687,11688,12281,12280,11804,11803,12258,11778,12116,11838,11861,11802,11779);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES
-- Call of the Crusade (10 player)
(11684,12,0,0),
(11685,12,0,0),
(11686,12,0,0),
(11687,12,0,0),
(11688,12,0,0),
-- Not One, But Two Jormungars (10 player)
(12281,12,0,0),
(12280,12,0,0),
-- Resilience Will Fix It (10 player)
(11804,12,0,0),
(11803,12,0,0),
-- Salt and Pepper (10 player)
(12258,12,0,0),
(11778,12,0,0),
-- The Traitor King (10 player)
(12116,12,0,0),
-- Three Sixty Pain Spike (10 player)
(11838,12,0,0),
(11861,12,0,0),
-- Upper Back Pain (10 player)
(11802,12,0,0),
(11779,12,0,0);

-- 10 Hero
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (11690,11689,11682,11693,11691,12345,12346,12344,12347,12348,12349,12360);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES
-- Call of the Grand Crusade (10 player)
(11690,12,2,0),
(11689,12,2,0),
(11682,12,2,0),
(11693,12,2,0),
(11691,12,2,0),
-- A Tribute to Skill (10 player)
(12345,12,2,0),
(12346,12,2,0),
(12344,12,2,0),
-- A Tribute to Mad Skill (10 player)
(12347,12,2,0),
(12348,12,2,0),
-- A Tribute to Insanity (10 player)
(12349,12,2,0),
-- A Tribute to Dedicated Insanity
(12360,12,2,0);

-- 25 normal
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (11679,11683,11680,11682,11681,12278,12279,11800,11799,11860,11818,12198,11839,11862,11801,11780);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES
-- Call of the Crusade (25 player)
(11679,12,1,0),
(11683,12,1,0),
(11680,12,1,0),
(11682,12,1,0),
(11681,12,1,0),
-- Not One, But Two Jormungars (25 player)
(12278,12,1,0),
(12279,12,1,0),
-- Resilience Will Fix It (25 player)
(11800,12,1,0),
(11799,12,1,0),
-- Salt and Pepper (25 player)
(11860,12,1,0),
(11818,12,1,0),
-- The Traitor King (25 player)
(12198,12,1,0),
-- Three Sixty Pain Spike (25 player)
(11839,12,1,0),
(11862,12,1,0),
-- Upper Back Pain (25 player)
(11801,12,1,0),
(11780,12,1,0);

-- 25 Hero
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (11542,11546,11547,11549,11678,12340,12338,12339,12342,12341,12343,12359,12358,12350);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES
-- Call of the Grand Crusade (25 player)
(11542,12,3,0),
(11546,12,3,0),
(11547,12,3,0),
(11549,12,3,0),
(11678,12,3,0),
-- A Tribute to Skill (25 player)
(12340,12,3,0),
(12338,12,3,0),
(12339,12,3,0),
-- A Tribute to Mad Skill (25 player)
(12342,12,3,0),
(12341,12,3,0),
-- A Tribute to Insanity (25 player)
(12343,12,3,0),
-- A Tribute to Immortality
(12359,12,3,0),
-- A Tribute to Immortality
(12358,12,3,0),
-- Realm First! Grand Crusader
(12350,12,3,0);

ALTER TABLE db_version CHANGE COLUMN required_3_world_icecrown_citadel required_27_world_command bit;

DELETE FROM `command` WHERE `name` IN ('achievementadd');
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('achievementadd', '3', 'Syntax: .achievementadd #id');

ALTER TABLE db_version CHANGE COLUMN required_27_world_command required_54_thorim_disarm bit;

-- Thorim immunity on disarm
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854239 WHERE `entry` = 32865;

ALTER TABLE db_version CHANGE COLUMN required_54_thorim_disarm required_91_ys_keepers bit;

-- Keepers (Yogg Saron Encounter)
DELETE FROM `creature` WHERE `id` IN (33410, 33411, 33412, 33413);
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(33410, 603, 1, 1, 0, 0, 2036.739, 25.464, 338.296, 3.814, 604800, 0, 0, 14433075, 0, 0, 0),
(33411, 603, 1, 1, 0, 0, 1939.094, -90.699, 338.296, 1.026, 604800, 0, 0, 14433075, 0, 0, 0),
(33412, 603, 1, 1, 0, 0, 1939.094, 42.534, 338.296, 5.321, 604800, 0, 0, 14433075, 0, 0, 0),
(33413, 603, 1, 1, 0, 0, 2036.739, -73.705, 338.296, 2.435, 604800, 0, 0, 14433075, 0, 0, 0);

UPDATE `creature_template` SET `ScriptName` = 'npc_ys_freya' WHERE `entry` = 33410;
UPDATE `creature_template` SET `ScriptName` = 'npc_ys_hodir' WHERE `entry` = 33411;
UPDATE `creature_template` SET `ScriptName` = 'npc_ys_mimiron' WHERE `entry` = 33412;
UPDATE `creature_template` SET `ScriptName` = 'npc_ys_thorim' WHERE `entry` = 33413;

UPDATE `creature_template` SET `modelid1` = 11686, `modelid2` = 0, `minlevel` = 80, `maxlevel` = 80, `unit_flags` = 33686018, `type_flags` = 0, `ScriptName` = 'npc_sanity_well' WHERE `entry` = 33991;

ALTER TABLE db_version CHANGE COLUMN required_91_ys_keepers required_117_proto_drake_path bit;

-- Path time-lost protodrake
DELETE FROM `creature` WHERE `id`=32491;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES 
(5491004, 32491, 571, 1, 1, 0, 0, 7537.36, -854.089, 982.299, 3.19715, 86400, 0, 0, 18900, 0, 0, 2); -- respawn 24h

UPDATE `creature_template` SET `speed_walk`=2, `speed_run`=2 where `entry`=32491;

DELETE FROM `creature_addon` WHERE `guid`=5491004;
INSERT INTO `creature_addon` (`guid`,`path_id`) VALUES (5491004,54910040);

DELETE FROM `waypoint_data` WHERE `id`=54910040; 
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) VALUES 
(54910040, 4, 7327.08, -942.896, 974.397, 0, 0, 0, 100, 0),
(54910040, 3, 7385.49, -878.718, 980.648, 0, 0, 0, 100, 0),
(54910040, 2, 7474.28, -857.317, 977.674, 0, 0, 0, 100, 0),
(54910040, 1, 7503.86, -856.766, 974.458, 0, 0, 0, 100, 0),
(54910040, 5, 7304.96, -1048.66, 986.581, 0, 0, 0, 100, 0),
(54910040, 6, 7320.79, -1137.46, 977.352, 0, 0, 0, 100, 0),
(54910040, 7, 7325.62, -1190.25, 966.615, 0, 0, 0, 100, 0),
(54910040, 8, 7308.36, -1240.42, 966.731, 0, 0, 0, 100, 0),
(54910040, 9, 7264.87, -1299.48, 956.037, 0, 0, 0, 100, 0),
(54910040, 10, 7228.44, -1360.63, 953.079, 0, 0, 0, 100, 0),
(54910040, 11, 7200.34, -1419.23, 956.566, 0, 0, 0, 100, 0),
(54910040, 12, 7176.4, -1470.62, 953.531, 0, 0, 0, 100, 0),
(54910040, 13, 7205.6, -1503.5, 959.704, 0, 0, 0, 100, 0),
(54910040, 14, 7268.69, -1537.84, 981.537, 0, 0, 0, 100, 0),
(54910040, 15, 7328.43, -1506.58, 978.2, 0, 0, 0, 100, 0),
(54910040, 16, 7418.04, -1460.2, 975.591, 0, 0, 0, 100, 0),
(54910040, 17, 7485.83, -1440.65, 993.714, 0, 0, 0, 100, 0),
(54910040, 18, 7558.21, -1390.25, 1005.14, 0, 0, 0, 100, 0),
(54910040, 19, 7594.67, -1330.07, 1001.81, 0, 0, 0, 100, 0),
(54910040, 20, 7636.35, -1254.23, 1004.71, 0, 0, 0, 100, 0),
(54910040, 21, 7666.21, -1210.42, 1002.2, 0, 0, 0, 100, 0),
(54910040, 22, 7717.33, -1139.02, 998.005, 0, 0, 0, 100, 0),
(54910040, 23, 7758.72, -1099.12, 1003.15, 0, 0, 0, 100, 0),
(54910040, 24, 7853.67, -1055.75, 1065.35, 0, 0, 0, 100, 0),
(54910040, 25, 7905.68, -1031.95, 1083.13, 0, 0, 0, 100, 0),
(54910040, 26, 7964.63, -1001.05, 1089.97, 0, 0, 0, 100, 0),
(54910040, 27, 8016.11, -981.888, 1052.66, 0, 0, 0, 100, 0),
(54910040, 28, 8063.91, -983.353, 1015.5, 0, 0, 0, 100, 0),
(54910040, 29, 8171.07, -934.563, 995.578, 0, 0, 0, 100, 0),
(54910040, 30, 8199.97, -850.786, 999.696, 0, 0, 0, 100, 0),
(54910040, 31, 8220.44, -782.61, 996.339, 0, 0, 0, 100, 0),
(54910040, 32, 8198.35, -729.709, 993.536, 0, 0, 0, 100, 0),
(54910040, 33, 8164.23, -678.373, 990.623, 0, 0, 0, 100, 0),
(54910040, 34, 8116.52, -620.548, 987.072, 0, 0, 0, 100, 0),
(54910040, 35, 8080.91, -590.318, 961.444, 0, 0, 0, 100, 0),
(54910040, 36, 8025.32, -559.044, 958.409, 0, 0, 0, 100, 0),
(54910040, 37, 7934.42, -513.857, 953.61, 0, 0, 0, 100, 0),
(54910040, 38, 7874.06, -433.282, 948.766, 0, 0, 0, 100, 0),
(54910040, 39, 7821.26, -285.08, 941.347, 0, 0, 0, 100, 0),
(54910040, 40, 7773.6, -208.615, 925.122, 0, 0, 0, 100, 0),
(54910040, 41, 7718.75, -158.632, 910.074, 0, 0, 0, 100, 0),
(54910040, 42, 7665.72, -134.088, 893.788, 0, 0, 0, 100, 0),
(54910040, 43, 7589.5, -98.6794, 884.648, 0, 0, 0, 100, 0),
(54910040, 44, 7492.43, -87.6879, 865.72, 0, 0, 0, 100, 0),
(54910040, 45, 7388.29, -95.9055, 844.498, 0, 0, 0, 100, 0),
(54910040, 46, 7240.53, -132.912, 852.502, 0, 0, 0, 100, 0),
(54910040, 47, 7179.48, -170.757, 849.114, 0, 0, 0, 100, 0),
(54910040, 48, 7128.93, -221.296, 845.666, 0, 0, 0, 100, 0),
(54910040, 49, 7110.42, -260.984, 843.577, 0, 0, 0, 100, 0),
(54910040, 50, 7101.34, -312.384, 841.101, 0, 0, 0, 100, 0),
(54910040, 51, 7089.43, -377.234, 826.201, 0, 0, 0, 100, 0),
(54910040, 52, 7084.02, -443.643, 792.785, 0, 0, 0, 100, 0),
(54910040, 53, 7083.03, -489.624, 783.07, 0, 0, 0, 100, 0),
(54910040, 54, 7080.87, -590.638, 764.014, 0, 0, 0, 100, 0),
(54910040, 55, 7065.05, -676.21, 760.991, 0, 0, 0, 100, 0),
(54910040, 56, 6978.95, -757.706, 759.465, 0, 0, 0, 100, 0),
(54910040, 57, 6926.67, -765.875, 756.956, 0, 0, 0, 100, 0),
(54910040, 58, 6861.22, -771.22, 757.357, 0, 0, 0, 100, 0),
(54910040, 59, 6807.58, -775.6, 760.469, 0, 0, 0, 100, 0),
(54910040, 60, 6743.8, -785.868, 757.409, 0, 0, 0, 100, 0),
(54910040, 61, 6687.89, -795.147, 751.151, 0, 0, 0, 100, 0),
(54910040, 62, 6639.95, -813.165, 725.154, 0, 0, 0, 100, 0),
(54910040, 63, 6605.2, -826.225, 688.031, 0, 0, 0, 100, 0),
(54910040, 64, 6512.56, -861.041, 628.843, 0, 0, 0, 100, 0),
(54910040, 65, 6451.99, -883.808, 605.176, 0, 0, 0, 100, 0),
(54910040, 66, 6415.95, -915.482, 547.719, 0, 0, 0, 100, 0),
(54910040, 67, 6420.17, -963.738, 511.286, 0, 0, 0, 100, 0),
(54910040, 68, 6414.8, -1034.58, 493.634, 0, 0, 0, 100, 0),
(54910040, 69, 6408.01, -1143.4, 484.109, 0, 0, 0, 100, 0),
(54910040, 70, 6393.39, -1257.52, 478.683, 0, 0, 0, 100, 0),
(54910040, 71, 6387.67, -1387.35, 517.509, 0, 0, 0, 100, 0),
(54910040, 72, 6411, -1395.61, 542.258, 0, 0, 0, 100, 0),
(54910040, 73, 6564.67, -1450.02, 676.977, 0, 0, 0, 100, 0),
(54910040, 74, 6594.86, -1460.71, 701.616, 0, 0, 0, 100, 0),
(54910040, 75, 6640.73, -1476.95, 738.558, 0, 0, 0, 100, 0),
(54910040, 76, 6682.87, -1491.87, 775.246, 0, 0, 0, 100, 0),
(54910040, 77, 6741.23, -1509.22, 814.133, 0, 0, 0, 100, 0),
(54910040, 78, 6788.69, -1526.15, 854.279, 0, 0, 0, 100, 0),
(54910040, 79, 6813.13, -1534.87, 875.291, 0, 0, 0, 100, 0),
(54910040, 80, 6908.43, -1568.86, 870.519, 0, 0, 0, 100, 0),
(54910040, 81, 6940.94, -1580.46, 897.684, 0, 0, 0, 100, 0),
(54910040, 82, 6990.34, -1598.08, 895.211, 0, 0, 0, 100, 0),
(54910040, 83, 7053.23, -1590.21, 923.16, 0, 0, 0, 100, 0),
(54910040, 84, 7083.66, -1561.51, 944.018, 0, 0, 0, 100, 0),
(54910040, 85, 7103.84, -1542.48, 961.914, 0, 0, 0, 100, 0),
(54910040, 86, 7151.78, -1497.26, 958.806, 0, 0, 0, 100, 0),
(54910040, 87, 7199, -1452.73, 949.402, 0, 0, 0, 100, 0),
(54910040, 88, 7248.36, -1406.18, 950.141, 0, 0, 0, 100, 0),
(54910040, 89, 7293.73, -1363.39, 947.2, 0, 0, 0, 100, 0),
(54910040, 90, 7368.66, -1355.03, 949.293, 0, 0, 0, 100, 0),
(54910040, 91, 7475.82, -1325.68, 951.012, 0, 0, 0, 100, 0),
(54910040, 92, 7584.79, -1275.39, 968.346, 0, 0, 0, 100, 0),
(54910040, 93, 7618.68, -1210.81, 964.907, 0, 0, 0, 100, 0),
(54910040, 94, 7651.48, -1148.31, 961.578, 0, 0, 0, 100, 0),
(54910040, 95, 7675.21, -1088.75, 947.033, 0, 0, 0, 100, 0),
(54910040, 96, 7684.79, -1006.75, 943.092, 0, 0, 0, 100, 0);

ALTER TABLE db_version CHANGE COLUMN required_117_proto_drake_path required_183_world_wintergrasp bit;

DELETE FROM `trinity_string` WHERE entry IN (756,757,758,759,760,761,762,763,764,765,766,767,768,769,770,771,772,780,781,782,783);
INSERT INTO `trinity_string` VALUES ('756', 'Battle begins!', '', '', '', '', '', '', '', 'Битва началась');
INSERT INTO `trinity_string` VALUES ('757', '%s has successfully defended the fortress!', '', '', '', '', '', '', '', '');
INSERT INTO `trinity_string` VALUES ('758', '%s has taken over the fortress!', '', '', '', '', '', '', '', '');
INSERT INTO `trinity_string` VALUES ('759', 'The %s siege workshop has been damaged by the %s!', '', '', '', '', '', '', '', '');
INSERT INTO `trinity_string` VALUES ('760', 'The %s siege workshop has been destroyed by the %s!', '', '', '', '', '', '', '', '');
INSERT INTO `trinity_string` VALUES ('761', 'The %s tower has been damaged!', '', '', '', '', '', '', '', '%s башня повреждена');
INSERT INTO `trinity_string` VALUES ('762', 'The %s tower has been destroyed!', '', '', '', '', '', '', '', '%s башня уничтожена!');
INSERT INTO `trinity_string` VALUES ('763', 'Wintergrasp fortress is under attack!', '', '', '', '', '', '', '', '');
INSERT INTO `trinity_string` VALUES ('764', 'Wintergrasp is now under the control of the %s.', '', '', '', '', '', '', '', '');
INSERT INTO `trinity_string` VALUES ('765', 'Wintergrasp timer set to %s.', '', '', '', '', '', '', '', '');
INSERT INTO `trinity_string` VALUES ('766', 'Wintergrasp battle started.', '', '', '', '', '', '', '', '');
INSERT INTO `trinity_string` VALUES ('767', 'Wintergrasp battle finished.', '', '', '', '', '', '', '', '');
INSERT INTO `trinity_string` VALUES ('768', 'Wintergrasp info: %s controlled. Timer: %s. Wartime: %s. Number of Players: (Horde: %u, Alliance: %u)', '', '', '', '', '', '', '', '');
INSERT INTO `trinity_string` VALUES ('769', 'Wintergrasp outdoorPvP is disabled.', '', '', '', '', '', '', '', '');
INSERT INTO `trinity_string` VALUES ('770', 'Wintergrasp outdoorPvP is enabled.', '', '', '', '', '', '', '', '');
INSERT INTO `trinity_string` VALUES ('771', 'You have reached Rank 1: Corporal', '', '', '', '', '', '', '', 'Вы достигли Ранга 1: Капрал');
INSERT INTO `trinity_string` VALUES ('772', 'You have reached Rank 2: First Lieutenant', '', '', '', '', '', '', '', 'Вы достигли Ранга 2: Лейтенант');
REPLACE INTO `trinity_string` VALUES ('780', 'Before the Battle of  Wintergrasp left 30 minutes!', '', '', '', '', '', '', '', 'До битвы на  Озере Ледяных Оков осталось 30 минут!');
REPLACE INTO `trinity_string` VALUES ('781', 'Before the Battle of  Wintergrasp left 10 minutes!', '', '', '', '', '', '', '', 'До битвы на  Озере Ледяных Оков осталось 10 минут!');
REPLACE INTO `trinity_string` VALUES ('782', 'The battle for Wintergrasp  has stopped! Not enough defenders. Wintergrasp Fortress remains  Attackers.', '', '', '', '', '', '', '', 'Битва за Озеро Ледяных Оков Остановлена. Не хватает защитников. Крепость переходит атакующей  стороне.');
REPLACE INTO `trinity_string` VALUES ('783', 'The battle for Wintergrasp  has stopped! Not enough attackers. Wintergrasp Fortress remains  Defenders.', '', '', '', '', '', '', '', 'Битва за Озеро Ледяных Оков Остановлена. Не хватает нападающих. Крепость остается защитникам.');
DELETE FROM `command` WHERE name IN ('wg','wg enable','wg start','wg status','wg stop','wg switch','wg timer');
INSERT INTO `command` VALUES ('wg', '3', 'Syntax: .wg $subcommand.');
INSERT INTO `command` VALUES ('wg enable', '3', 'Syntax: .wg enable [on/off] Enable/Disable Wintergrasp outdoorPvP.');
INSERT INTO `command` VALUES ('wg start', '3', 'Syntax: .wg start\r\nForce Wintergrasp battle start.');
INSERT INTO `command` VALUES ('wg status', '3', 'Syntax: .wg status\r\nWintergrasp info, defender, timer, wartime.');
INSERT INTO `command` VALUES ('wg stop', '3', 'Syntax: .wg stop\r\nForce Wintergrasp battle stop (No rewards).');
INSERT INTO `command` VALUES ('wg switch', '3', 'Syntax: .wg switch\r\nSwitchs Wintergrasp defender team.');
INSERT INTO `command` VALUES ('wg timer', '3', 'Syntax: .wg timer $minutes\r\nChange the current timer. Min value = 1, Max value 60 (Wartime), 1440 (Not Wartime)');
/*Spirit healer FIX */
UPDATE creature_template SET npcflag=npcflag|32768 WHERE entry   IN (31841,31842);
/* Temp removed gameobject stopping you getting to the relic
* 60070 - [Wintergrasp Keep Collision Wall X:5396.209961 Y:2840.010010 Z:432.268005 MapId:571
* 60476 - [Doodad_WG_Keep_Door01_collision01 X:5397.109863 Y:2841.540039 Z:425.901001 MapId:571]*/
DELETE FROM gameobject WHERE id IN ('194323', '194162');

/*Defender's Portal Activate Proper Spell
Not need it now*/
/*
REPLACE INTO `spell_linked_spell` VALUES ('54640','54643','0','Defender\'s Portal Activate Proper Spell');
*/

/* Teleport WG SPELLs*/
REPLACE INTO `spell_target_position` VALUES ('59096', '571', '5325.06', '2843.36', '409.285', '3.20278');
REPLACE INTO `spell_target_position` VALUES ('58632', '571', '5097.79', '2180.29', '365.61', '2.41');
REPLACE INTO `spell_target_position` VALUES ('58633', '571', '5026.80', '3676.69', '362.58', '3.94');