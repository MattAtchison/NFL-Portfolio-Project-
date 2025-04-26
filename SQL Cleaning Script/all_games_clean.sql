-- 1 checking for dupes 
-- 2 now add the betting to raw_all_games 
-- 3 check for nulls (CHECK)
-- 4 change all data to the correct type
-- 5 see how many each team plays should be 17 reg sea 
-- 6 fix the time stamp 
-- 7 make the spread and o/v into decimal (CHECK)
-- 8 create serparate table for refs or split up the string 
-- 9 drop refs column 
-- 10 make a win or loss column 

DROP TABLE IF EXISTS raw_all_games; 

SELECT * 
FROM raw_all_games; 

SELECT * 
FROM game_refs

SELECT *
FROM games; 


-- 1) 
-- Checking for dupes 
SELECT game_id, week, season_type, team_id, COUNT(*)
FROM raw_all_games
GROUP BY game_id, week, season_type, team_id
HAVING COUNT(*) > 1; 


-- deleting all the dupes for first table - raw_all_games
WITH dupe AS (
    SELECT 
        game_id, week, season_type, team_id,
        ROW_NUMBER() OVER (PARTITION BY game_id, week, season_type, team_id ORDER BY team_name) AS row_num
    FROM raw_all_games 
)
DELETE FROM raw_all_games 
WHERE (game_id, week, season_type, team_id) IN (
    SELECT game_id, week, season_type, team_id
    FROM dupe 
    WHERE row_num > 1
);

-- deleting all the dupes for first table - betting table(over/under, spread)
WITH dupe AS (
     SELECT 
         game_id,
         ROW_NUMBER() OVER (PARTITION BY game_id ORDER BY game_id) AS row_num 
         FROM games 
)
DELETE FROM games 
       WHERE game_id IN(
       SELECT game_id
       FROM dupe
       WHERE row_num > 1     
); 
     


-- 2)
-- now add the betting to raw_all_games 

ALTER TABLE raw_all_games
ADD COLUMN spread VARCHAR(255),  -- Adjust the length as needed
ADD COLUMN over_under VARCHAR(255);    -- Adjust the length as needed


UPDATE raw_all_games a
JOIN games g 
ON a.game_id = g.game_id 
SET a.spread = g.spread_text,
    a.over_under = g.over_text


-- 3)
-- checking for nulls - (no nulls)

SELECT *
FROM raw_all_games 
WHERE game_id IS NULL
   OR team_name IS NULL
   OR team_abbreviation IS NULL
   OR team_id IS NULL
   OR referees IS NULL
   OR home_away IS NULL
   OR game_date IS NULL
   OR week IS NULL
   OR season_type IS NULL
   OR score IS NULL
   OR firstdowns IS NULL
   OR firstdownspassing IS NULL
   OR firstdownsrushing IS NULL
   OR firstdownspenalty IS NULL
   OR thirddowneff IS NULL
   OR fourthdowneff IS NULL
   OR totaloffensiveplays IS NULL
   OR totalyards IS NULL
   OR yardsperplay IS NULL
   OR totaldrives IS NULL
   OR netpassingyards IS NULL
   OR completionattempts IS NULL
   OR yardsperpass IS NULL
   OR interceptions IS NULL
   OR sacksyardslost IS NULL
   OR rushingyards IS NULL
   OR rushingattempts IS NULL
   OR yardsperrushattempt IS NULL
   OR redzoneattempts IS NULL
   OR totalpenaltiesyards IS NULL
   OR turnovers IS NULL
   OR fumbleslost IS NULL
   OR defensivetouchdowns IS NULL
   OR possessiontime IS NULL;

 

-- 4) make all the columns the right data type - - thirddowneff, fourthdowneff, redzoneattempts, totalpenaltiesy
-- delete sacksyardlost, netpassingyards, completionattempts



-- changing data types 
ALTER TABLE raw_all_games
MODIFY COLUMN game_id VARCHAR(255),
MODIFY COLUMN week VARCHAR(255);

-- adding in new columns 
ALTER TABLE raw_all_games
ADD COLUMN third_down_attempts INT,
ADD COLUMN third_down_made INT,
ADD COLUMN fourth_down_attempts INT,
ADD COLUMN fourth_down_made INT,
ADD COLUMN redzone_attempts INT,
ADD COLUMN redzone_made INT,
ADD COLUMN penalties INT,
ADD COLUMN penalty_yards INT;

-- adding in the new split data 

UPDATE raw_all_games 
SET third_down_attempts = CAST(SUBSTRING_INDEX(thirddowneff, '-', 1) AS UNSIGNED),
    third_down_made = CAST(SUBSTRING_INDEX(thirddowneff, '-', -1) AS UNSIGNED), 
    fourth_down_attempts = CAST(SUBSTRING_INDEX(fourthdowneff, '-', 1) AS UNSIGNED),
    fourth_down_made = CAST(SUBSTRING_INDEX(fourthdowneff, '-', -1) AS UNSIGNED)
    redzone_attempts = CAST(SUBSTRING_INDEX(redzoneattempts, '-', 1) AS UNSIGNED),
    redzone_made = CAST(SUBSTRING_INDEX(redzoneattempts, '-', -1) AS UNSIGNED),
    penalties = CAST(SUBSTRING_INDEX(totalpenaltiesyards, '-', 1) AS UNSIGNED),
    penalty_yards = CAST(SUBSTRING_INDEX(totalpenaltiesyards, '-', -1) AS UNSIGNED); 

-- dropping the old columns 
ALTER TABLE raw_all_games 
DROP COLUMN thirddowneff, 
DROP COLUMN sacksyardslost, 
DROP COLUMN netpassingyards, 
DROP COLUMN completionattempts
DROP COLUMN fourthdowneff,
DROP COLUMN redzoneattempts,
DROP COLUMN totalpenaltiesyards; 


    
    
    

-- 5)
-- see how many each team plays should be 17 reg sea 
SELECT COUNT(*), team_id, team_name 
FROM raw_all_games
GROUP BY team_id, team_name; 

SELECT COUNT(DISTINCT team_id) as team_id,
       COUNT(DISTINCT team_name) as team_name
FROM raw_all_games 





-- 6)
-- fix the time stamp 
    
UPDATE raw_all_games 
SET game_date = DATE(game_date);

-- quick check 
SELECT *, MONTH(game_date)
FROM raw_all_games 
WHERE MONTH(game_date) < 6 

    
    

-- 7) 
-- make the spread and over/under into decimal 


-- Extract the team abbreviation and the spread value
UPDATE raw_all_games
SET 
    favored_team = SUBSTRING_INDEX(SUBSTRING_INDEX(spread, ' ', -2), ' ', 1),
    clean_spread = ABS(CAST(SUBSTRING_INDEX(spread, ' ', -1) AS DECIMAL(5,2)));

UPDATE raw_all_games
SET clean_spread = 
    CASE 
        WHEN team_abbreviation = favored_team THEN -clean_spread
        ELSE clean_spread
    END;


ALTER TABLE raw_all_games 
DROP COLUMN spread ; 


UPDATE raw_all_games 
SET over_under = CAST(SUBSTRING_INDEX(over_under, ' ', -1) AS DECIMAL(5,1))



-- 8)
-- create serparate table for refs or split up the string 

ALTER TABLE raw_all_games
ADD COLUMN ref1 VARCHAR(100),
ADD COLUMN ref2 VARCHAR(100),
ADD COLUMN ref3 VARCHAR(100),
ADD COLUMN ref4 VARCHAR(100),
ADD COLUMN ref5 VARCHAR(100),
ADD COLUMN ref6 VARCHAR(100),
ADD COLUMN ref7 VARCHAR(100);

CREATE TABLE game_refs (
    game_id VARCHAR(20),
    ref1 VARCHAR(100),
    ref2 VARCHAR(100),
    ref3 VARCHAR(100),
    ref4 VARCHAR(100),
    ref5 VARCHAR(100),
    ref6 VARCHAR(100),
    ref7 VARCHAR(100)
);

UPDATE raw_all_games
SET 
    ref1 = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(referees, ',', 1), ',', -1)),
    ref2 = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(referees, ',', 2), ',', -1)),
    ref3 = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(referees, ',', 3), ',', -1)),
    ref4 = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(referees, ',', 4), ',', -1)),
    ref5 = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(referees, ',', 5), ',', -1)),
    ref6 = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(referees, ',', 6), ',', -1)),
    ref7 = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(referees, ',', 7), ',', -1));

INSERT INTO game_refs (game_id, ref1, ref2, ref3, ref4, ref5, ref6, ref7)
SELECT game_id, ref1, ref2, ref3, ref4, ref5, ref6, ref7
FROM raw_all_games;


-- 9 ) 
-- drop refs column 

ALTER TABLE raw_all_games 
DROP COLUMN referees;



-- 10) 
-- win or loss

ALTER TABLE raw_all_games 
ADD COLUMN win_loss VARCHAR(20); 

UPDATE raw_all_games g1
JOIN raw_all_games g2
  ON g1.game_id = g2.game_id AND g1.team_name != g2.team_name 
SET g1.win_loss = 
  CASE 
    WHEN g1.score > g2.score THEN 'win'
    WHEN g1.score < g2.score THEN 'loss'
  END;












