-- offense player stats insights 
-- 1) week to week receiving yard changes of players, and the over the year percent to see most consistent 
-- 2)rb matchup against each team 
-- 3) amount of games does each qb win when they have a qbr over 90 

SELECT * 
FROM raw_all_offense_player_stats
;

SELECT *
FROM raw_all_player_defense_stats ; 



-- 1) three most dominate weekly receving yards and the change from each week (WR analyst)
-- week to week receiving yard changes of players

SELECT 
    player, 
    season_type,
    week,
    receivingYards, 
    LAG(receivingYards) OVER (PARTITION BY player ORDER BY week) AS last_week,
    (receivingYards - LAG(receivingYards) OVER (PARTITION BY player ORDER BY week)) AS week_change,      
    ROUND(
        LAG(receivingYards) OVER (PARTITION BY player ORDER BY week) * 1.0 
        / NULLIF(receivingYards, 0), 
        2
    ) AS percent_change 
FROM raw_all_offense_player_stats 
WHERE player IN ("Ja'Marr Chase", 'Justin Jefferson', 'Puka Nacua')
  AND season_type = 'regular-season';




-- 2) rb matchup against each team 


SELECT player, 
       team,
       week,
       opponent_team, 
       rushingAttempts,
       rushingYards, 
       yardsPerPassAttempt, 
       rushingTouchdowns,
       longRushing, 
       season_type 
FROM raw_all_offense_player_stats 
WHERE position = "rb"
     AND season_type = 'regular-season'
ORDER BY player; 






-- 3) amount of games does each qb win when they have a qbr over 90 

SELECT 
    Player,
    COUNT(*) AS games_with_qbr_over_90,
    SUM(CASE WHEN win_loss = 'win' THEN 1 ELSE 0 END) AS wins_with_qbr_over_90,
    ROUND(SUM(CASE WHEN win_loss = 'win' THEN 1 ELSE 0 END) * 1.0 / COUNT(*), 2) AS win_pct_with_qbr_over_90
FROM (
    SELECT 
        t1.Player,
        t2.win_loss
    FROM raw_all_offense_player_stats t1
    JOIN raw_all_games t2 
        ON t1.game_id = t2.game_id 
       AND t1.team = t2.team_name
    WHERE t1.position = 'QB'
      AND t1.qbrating >= 90
      AND t2.season_type = 'regular-season'
) AS high_qbr_games
GROUP BY Player
ORDER BY win_pct_with_qbr_over_90 DESC;














