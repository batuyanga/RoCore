-- Temp fix for some quests

-- Death Knight Starting Zone
-- Into the Realm of Shadows
UPDATE `quest_template` SET `method`='0' WHERE `entry`='12687';
-- Behind Scarlet Lines
UPDATE `quest_template` SET `PrevQuestId`='-12720'  WHERE `entry`='12723';
-- The Battle For The Ebon Hold
UPDATE `quest_template` SET `method`='0' WHERE `entry`='13166';
-- Into the Realm of Shadows
UPDATE `quest_template` SET `method`='0' WHERE `entry`='12687';
-- Massacre At Light's Point
UPDATE `quest_template` SET `method`='0' WHERE `entry`='12701';
-- An End To All Things
UPDATE `quest_template` SET `method`='0' WHERE `entry`='12779';