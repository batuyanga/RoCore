ALTER TABLE db_version CHANGE COLUMN required_3_world_icecrown_citadel required_27_world_command bit;

INSERT INTO `command` (`name`, `security`, `help`) VALUES ('achievementadd', '5', 'Syntax: .achievementadd #id');