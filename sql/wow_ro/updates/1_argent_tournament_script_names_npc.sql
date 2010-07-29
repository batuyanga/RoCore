-- Argent Tournament
UPDATE gameobject SET state = 0 WHERE id = 194618;
DELETE FROM `gameobject_loot_template` WHERE entry = 194618;
INSERT INTO `gameobject_loot_template` VALUES(
194618, 46070, 100, 1, 0, 1, 1);
UPDATE quest_template SET QuestFlags = 0 WHERE entry = 13678;
UPDATE quest_template SET NextQuestId = 0 WHERE NextQuestId = 13678;
UPDATE quest_template SET ReqCreatureOrGOId1 = 24108 WHERE entry = 13679;
UPDATE quest_template SET NextQuestId = 0 WHERE NextQuestId = 13672;
UPDATE creature_template SET mindmg = 500, maxdmg = 800 WHERE entry = 33448;
UPDATE creature_template SET ScriptName = 'npc_squire_danny' WHERE entry = 33518;
UPDATE creature_template SET mindmg = 650, maxdmg = 1000, ScriptName = 'npc_argent_champion' WHERE entry = 33707;
UPDATE quest_template SET PrevQuestId = 13680 WHERE PrevQuestId = 13687;
UPDATE quest_template SET PrevQuestId = 13679 WHERE PrevQuestId = 13686;
UPDATE quest_template SET ReqSourceId2 = 0, ReqSourceCount2 = 0 WHERE ReqSourceId2 = 45000;
UPDATE item_template SET maxcount = 1 WHERE entry = 45005;
UPDATE creature_template SET  ScriptName = 'npc_argent_valiant' WHERE entry = 33448;