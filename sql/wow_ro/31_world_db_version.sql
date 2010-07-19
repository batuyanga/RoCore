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