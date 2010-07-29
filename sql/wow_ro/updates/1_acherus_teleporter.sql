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