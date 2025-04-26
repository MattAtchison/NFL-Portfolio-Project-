-- the script for the games 

-- 1 home feild advantage
-- 2 how accurate is the over-under 

SELECT *
FROM game_refs;

SELECT * 
FROM raw_all_games ; 

-- 1) home feild advantage

SELECT 
  home_away,
  season_type,
  COUNT(*) AS total_games,
  SUM(CASE WHEN win_loss = 'win' THEN 1 ELSE 0 END) AS total_wins,
  ROUND(SUM(CASE WHEN win_loss = 'win' THEN 1 ELSE 0 END) * 1.0 / COUNT(*), 3) AS win_pct
FROM raw_all_games
GROUP BY home_away, season_type;


-- 2) how accurate is the over-under 


SELECT 
    COUNT(*) AS total_games,
    SUM(CASE WHEN (score_total > over_under) THEN 1 ELSE 0 END) AS games_over,
    ROUND(
        SUM(CASE WHEN (score_total > over_under) THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS over_hit_percentage
FROM (
    SELECT 
        game_id, 
        SUM(score) AS score_total,
        MAX(over_under) AS over_under
    FROM raw_all_games
    GROUP BY game_id
) AS game_scores;





