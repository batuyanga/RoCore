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