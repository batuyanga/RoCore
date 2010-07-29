--
-- Table structure for table `character_db_version`
--

DROP TABLE IF EXISTS `character_db_version`;
CREATE TABLE `character_db_version` (
  `required_31_characters_db_version` bit(1) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Last applied sql update to DB';

--
-- Dumping data for table `character_db_version`
--

LOCK TABLES `character_db_version` WRITE;
/*!40000 ALTER TABLE `character_db_version` DISABLE KEYS */;
INSERT INTO `character_db_version` VALUES
(NULL);
/*!40000 ALTER TABLE `character_db_version` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `armory_character_stats`;
CREATE TABLE `armory_character_stats` (
  `guid` int(11) NOT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY  (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='World of Warcraft Armory table';

DROP TABLE IF EXISTS `character_feed_log`;
CREATE TABLE `character_feed_log` (
  `guid` int(11) NOT NULL,
  `type` smallint(1) NOT NULL,
  `data` int(11) NOT NULL,
  `date` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `counter` int(11) NOT NULL,
  PRIMARY KEY  (`guid`,`type`,`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

ALTER TABLE character_db_version CHANGE COLUMN required_31_characters_db_version required_165_characters_armory_patch bit;

DROP TABLE IF EXISTS `armory_character_stats`;
CREATE TABLE `armory_character_stats` (
  `guid` int(11) NOT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY  (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='World of Warcraft Armory table';

DROP TABLE IF EXISTS `character_feed_log`;
CREATE TABLE `character_feed_log` (
  `guid` int(11) NOT NULL,
  `type` smallint(1) NOT NULL,
  `data` int(11) NOT NULL,
  `date` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `counter` int(11) NOT NULL,
  PRIMARY KEY  (`guid`,`type`,`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `armory_game_chart`;
CREATE TABLE `armory_game_chart` (
  `gameid` int(11) NOT NULL,
  `teamid` int(11) NOT NULL,
  `guid` int(11) NOT NULL,
  `changeType` int(11) NOT NULL,
  `ratingChange` int(11) NOT NULL,
  `teamRating` int(11) NOT NULL,
  `damageDone` int(11) NOT NULL,
  `deaths` int(11) NOT NULL,
  `healingDone` int(11) NOT NULL,
  `damageTaken` int(11) NOT NULL,
  `healingTaken` int(11) NOT NULL,
  `killingBlows` int(11) NOT NULL,
  `mapId` int(11) NOT NULL,
  `start` int(11) NOT NULL,
  `end` int(11) NOT NULL,
  PRIMARY KEY  (`gameid`,`teamid`,`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='WoWArmory Game Chart';