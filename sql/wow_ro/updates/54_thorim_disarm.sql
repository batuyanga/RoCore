ALTER TABLE db_version CHANGE COLUMN required_27_world_command required_54_thorim_disarm bit;

-- Thorim immunity on disarm
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854239 WHERE `entry` = 32865;