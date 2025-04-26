-- 1 check for dupes 
-- 2 check for nulls 
-- 3 change the id to varchar 
-- 4 change the weight, height, age to float or int 



SELECT *
FROM raw_all_player_attributes_offense; 

SELECT *
FROM raw_all_player_attributes_defense; 


-- 1)
-- check for dupes 
SELECT id, COUNT(*)
FROM raw_all_player_attributes_offense
GROUP BY id
HAVING COUNT(*) > 1;

SELECT id, COUNT(*)
FROM raw_all_player_attributes_defense
GROUP BY id
HAVING COUNT(*) > 1;



-- clear the dupes for both tables 

-- deleting all defense dupes 
WITH dupes AS (
    SELECT 
        id,
        ROW_NUMBER() OVER (PARTITION BY name, team, position, height, weight, age, college, jersey, experience ORDER BY id) AS row_num
    FROM raw_all_player_attributes_defense
)
DELETE FROM raw_all_player_attributes_defense
WHERE id IN (
    SELECT id FROM dupes WHERE row_num > 1
);


-- deleting offense dupes 
WITH dupes AS (
    SELECT 
        id,
        ROW_NUMBER() OVER (PARTITION BY name, team, position, height, weight, age, college, jersey, experience ORDER BY id) AS row_num
    FROM raw_all_player_attributes_defense
)
DELETE FROM raw_all_player_attributes_offense
WHERE id IN (
    SELECT id FROM dupes WHERE row_num > 1
    );

DROP TABLE IF EXISTS raw_all_player_attributes_defense; 
DROP TABLE IF EXISTS raw_all_player_attributes_offense; 

-- 2)
-- check for nulls 

-- defense check 
SELECT * 
FROM raw_all_player_attributes_defense 
WHERE name IS NULL 
	  OR id IS NULL
	  OR team IS NULL
	  OR position IS NULL
	  OR height IS NULL
	  OR weight IS NULL
	  OR age IS NULL
	  OR college IS NULL
	  OR jersey IS NULL
	  OR experience IS NULL ;
	  
-- offense check 

SELECT * 
FROM raw_all_player_attributes_offense
WHERE name IS NULL 
	  OR id IS NULL
	  OR team IS NULL
	  OR position IS NULL
	  OR height IS NULL
	  OR weight IS NULL
	  OR age IS NULL
	  OR college IS NULL
	  OR jersey IS NULL
	  OR experience IS NULL ;

-- 3) 
-- change the id to varchar 

ALTER TABLE raw_all_player_attributes_defense 
MODIFY COLUMN id VARCHAR(50); 

ALTER TABLE raw_all_player_attributes_offense  
MODIFY COLUMN id VARCHAR(50); 



-- 4)
-- change the height to cm or inches then int 

UPDATE raw_all_player_attributes_defense 
SET Height = CAST(LEFT(Height, 1) * 12 AS UNSIGNED) + CAST(REPLACE(SUBSTRING(Height, 3), '"', '') AS UNSIGNED);

UPDATE raw_all_player_attributes_offense 
SET Height = CAST(LEFT(Height, 1) * 12 AS UNSIGNED) + CAST(REPLACE(SUBSTRING(Height, 3), '"', '') AS UNSIGNED);

ALTER TABLE raw_all_player_attributes_defense  MODIFY height int; -- making the Varchar into a int 
ALTER TABLE raw_all_player_attributes_offense  MODIFY height int; -- making the Varchar into a int 

-- Changing the weight 
UPDATE raw_all_player_attributes_defense 
SET Weight = LEFT(Weight, 3); 

ALTER TABLE first_defense_players RENAME COLUMN Weight TO Weight_lbs;


UPDATE raw_all_player_attributes_offense 
SET Weight = LEFT(Weight, 3); 

ALTER TABLE first_offense_players  RENAME COLUMN Weight TO Weight_lbs;

ALTER TABLE raw_all_player_attributes_defense  MODIFY weight int; -- making the Varchar into a int 
ALTER TABLE raw_all_player_attributes_offense  MODIFY weight int; -- making the Varchar into a int 


-- making age into an int 
ALTER TABLE raw_all_player_attributes_offense
MODIFY COLUMN age INT;

ALTER TABLE raw_all_player_attributes_defense
MODIFY COLUMN age INT;


-- theres an na in the data/change that 
SELECT DISTINCT(age)
FROM raw_all_player_attributes_defense 

-- defense 
UPDATE raw_all_player_attributes_defense 
SET age = NULL
WHERE age = 'na' OR age = '';  

-- offense 
UPDATE raw_all_player_attributes_offense 
SET age = NULL
WHERE age = 'na' OR age = '';



