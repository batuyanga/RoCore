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


-- Ulduar
UPDATE `creature_addon` SET `auras` = NULL WHERE `creature_addon`.`guid` =137496 LIMIT 1;
UPDATE `creature_template` SET `difficulty_entry_1` = '0' WHERE `creature_template`.`entry` =33240 LIMIT 1 ;
UPDATE `creature_template` SET `unit_class` = '2' WHERE `creature_template`.`entry` =33515 LIMIT 1;
UPDATE `creature_template` SET `unit_class` = '1' WHERE `creature_template`.`entry` =32918 LIMIT 1;
UPDATE `creature_template` SET `unit_class` = '1' WHERE `creature_template`.`entry` =33399 LIMIT 1;
UPDATE `creature_template` SET `unit_class` = '2' WHERE `creature_template`.`entry` =34175 LIMIT 1;
update gameobject_scripts set `command`=11 where `id`=55194;