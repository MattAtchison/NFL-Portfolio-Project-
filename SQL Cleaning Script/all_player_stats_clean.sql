-- defense and offense clean
-- 1 check for duplciates 
-- 2 check for nulls or errors
-- 3 change data types in defense/offense and normalize completions, attempts, sacks, sacks_yards_lost
-- 4 add in position 
-- 5 add in opponent team 


SELECT * 
FROM raw_all_player_defense_stats   ; 

DROP TABLE IF EXISTS defense_stats    ; 

SELECT *
FROM  raw_all_offense_player_stats  ;

DROP TABLE IF EXISTS offense_stats   ; 


# 1) check for duplciates 

-- offense 
SELECT 
    Player_ID,
    Game_ID,
    Week,
    season_type,
    COUNT(*) AS duplicate_count
FROM 
    raw_all_offense_player_stats 
GROUP BY 
    Player_ID, Game_ID, Week, season_type
HAVING 
    COUNT(*) > 1;

-- defense 
SELECT 
    Player_ID,
    Game_ID,
    Week,
    season_type,
    COUNT(*) AS duplicate_count
FROM 
    raw_all_player_defense_stats  
GROUP BY 
    Player_ID, Game_ID, Week, season_type
HAVING 
    COUNT(*) > 1;


-- this puts the QB's together with their rushing and passing stats 
CREATE TABLE raw_all_offense_player_stats AS
SELECT 
    Player_ID,
    Game_ID,
    Team,
    season_type,
    Player,
    Team_Id,
    Week,
    -- Passing stats
    MAX(completions_attempts) AS completions_passingAttempts,
    MAX(passingYards) AS passingYards,
    MAX(yardsPerPassAttempt) AS yardsPerPassAttempt,
    MAX(passingTouchdowns) AS passingTouchdowns,
    MAX(interceptions) AS interceptions,
    MAX(sack_yardslost) AS sacks_sackYardsLost,  -- Ensure this column is correct
    MAX(adjQBR) AS adjQBR,
    MAX(QBRating) AS QBRating,
    -- Rushing stats
    MAX(rushingAttempts) AS rushingAttempts,
    MAX(rushingYards) AS rushingYards,
    MAX(yardsPerRushAttempt) AS yardsPerRushAttempt,
    MAX(rushingTouchdowns) AS rushingTouchdowns,
    MAX(longRushing) AS longRushing,
    -- Receiving stats
    MAX(receptions) AS receptions,
    MAX(receivingYards) AS receivingYards,
    MAX(yardsPerReception) AS yardsPerReception,
    MAX(receivingTouchdowns) AS receivingTouchdowns,
    MAX(longReception) AS longReception,
    MAX(receivingTargets) AS receivingTargets
FROM 
    offense_stats 
GROUP BY 
    Player_ID,
    Game_ID,
    Team,
    season_type,
    Player,
    Team_Id,
    Week;




-- defense dupe clean 


WITH def_dupes AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY player_id, game_id, season_type, week ORDER BY player_id) AS row_num
    FROM raw_all_player_defense_stats 
)
DELETE FROM raw_all_player_defense_stats 
WHERE (player_id, game_id, season_type, week) IN (
    SELECT player_id, game_id, season_type, week
    FROM def_dupes
    WHERE row_num > 1
);



-- 2)
-- check for nulls or errors

-- offense 
SELECT *
FROM raw_all_offense_player_stats 
WHERE 
    Player_ID IS NULL OR
    Game_ID IS NULL OR
    Team IS NULL OR
    season_type IS NULL OR
    Player IS NULL OR
    Team_Id IS NULL OR
    Week IS NULL OR
    completions_passingAttempts IS NULL OR
    passingYards IS NULL OR
    yardsPerPassAttempt IS NULL OR
    passingTouchdowns IS NULL OR
    interceptions IS NULL OR
    sacks_sackYardsLost IS NULL OR
    adjQBR IS NULL OR
    QBRating IS NULL OR
    rushingAttempts IS NULL OR
    rushingYards IS NULL OR
    yardsPerRushAttempt IS NULL OR
    rushingTouchdowns IS NULL OR
    longRushing IS NULL OR
    receptions IS NULL OR
    receivingYards IS NULL OR
    yardsPerReception IS NULL OR
    receivingTouchdowns IS NULL OR
    longReception IS NULL OR
    receivingTargets IS NULL;

-- defense
SELECT *
FROM raw_all_player_defense_stats 
WHERE 
    Player_ID IS NULL
    OR Game_ID IS NULL
    OR Team IS NULL
    OR season_type IS NULL
    OR Player IS NULL
    OR Team_Id IS NULL
    OR Week IS NULL
    OR totalTackles IS NULL
    OR soloTackles IS NULL
    OR sacks IS NULL
    OR tacklesForLoss IS NULL
    OR passesDefended IS NULL
    OR QBHits IS NULL
    OR defensiveTouchdowns IS NULL;



-- checking to see if the interceptions etc will be zero or null if player played and had none 


SELECT a.position,
       s.interceptions,
       s.passingYards
FROM raw_all_offense_stats s
JOIN raw_all_player_attributes_offense a
ON s.Player_ID = a.id
WHERE a.position = "QB"; 


-- 3)
-- change data types in defense/ offense 


ALTER TABLE raw_all_player_defense_stats 
MODIFY COLUMN player_id VARCHAR(20),
MODIFY COLUMN game_id VARCHAR(20),
MODIFY COLUMN team_id VARCHAR(20),
MODIFY COLUMN week VARCHAR(20);


-- split columns on offense and change week to var 

ALTER TABLE raw_all_offense_player_stats 
ADD COLUMN completions VARCHAR(20),
ADD COLUMN attempts VARCHAR(20),
ADD COLUMN sacks VARCHAR(20),
ADD COLUMN sacks_yards_lost VARCHAR(20);



UPDATE raw_all_offense_player_stats 
SET 
    completions = CAST(SUBSTRING_INDEX(completions_passingAttempts, '/', 1) AS UNSIGNED),
    attempts = CAST(SUBSTRING_INDEX(completions_passingAttempts, '/', -1) AS UNSIGNED),
    sacks = CAST(SUBSTRING_INDEX(sacks_sackyardslost, '-', 1) AS UNSIGNED),
    sacks_yards_lost = CAST(SUBSTRING_INDEX(sacks_sackyardslost, '-', -1) AS UNSIGNED);

-- dropping old columns 

ALTER TABLE raw_all_offense_player_stats 
DROP COLUMN completions_passingAttempts,
DROP COLUMN sacks_sackyardslost; 



-- 4)
-- add position in 

ALTER TABLE raw_all_offense_player_stats 
ADD COLUMN position VARCHAR(20)  ; 


UPDATE raw_all_offense_player_stats s
JOIN raw_all_player_attributes_offense a
ON s.player_id = a.id 
SET s.position = a.position; 


ALTER TABLE raw_all_player_defense_stats 
ADD COLUMN position VARCHAR(20); 

UPDATE raw_all_player_defense_stats s 
JOIN raw_all_player_attributes_defense a
ON s.player_id = a.id
SET s.position = a.position ;


-- 5) 
-- add in opponent team 


ALTER TABLE raw_all_offense_player_stats ADD COLUMN opponent_team VARCHAR(100);


UPDATE raw_all_offense_player_stats s
JOIN raw_all_games a1 
    ON s.game_id = a1.game_id AND s.team = a1.team_name
JOIN raw_all_games a2 
    ON a1.game_id = a2.game_id AND a1.team_name != a2.team_name
SET s.opponent_team = a2.team_name;



-- defense add column 
ALTER TABLE raw_all_player_defense_stats ADD COLUMN opponent_team VARCHAR(100);

-- update with opponent 
UPDATE raw_all_player_defense_stats d
JOIN raw_all_games g1 
    ON d.game_id = g1.game_id AND d.team = g1.team_name
JOIN raw_all_games g2 
    ON g1.game_id = g2.game_id AND g1.team_name != g2.team_name
SET d.opponent_team = g2.team_name;







