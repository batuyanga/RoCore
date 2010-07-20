ALTER TABLE db_version CHANGE COLUMN required_3_world_icecrown_citadel required_27_world_command bit;

DELETE FROM `command` WHERE `name` IN ('achievementadd');
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('achievementadd', '3', 'Syntax: .achievementadd #id');