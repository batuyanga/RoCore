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

