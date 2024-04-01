create database skills;
-- A. Retrieve all records from the Olympics table.
SELECT * FROM Olympics;
-- B. Retrieve only the Athlete names and the Medals they won 
SELECT name, medal FROM Olympics;
-- C. Count the total number of athletes in the dataset. 
SELECT COUNT(DISTINCT name) AS total_athletes FROM Olympics;
-- D. Find all records of athletes who won a Gold medal
SELECT * FROM Olympics WHERE medal = 'Gold';
-- E. List all athletes who won Silver, ordered by the Year they won it.
SELECT name, year FROM Olympics WHERE medal = 'Silver' ORDER BY year;
-- F. Count how many Gold, Silver, and Bronze medals each country has won. 
SELECT team, 
       COUNT(CASE WHEN medal = 'Gold' THEN 1 END) AS gold_count,
       COUNT(CASE WHEN medal = 'Silver' THEN 1 END) AS silver_count,
       COUNT(CASE WHEN medal = 'Bronze' THEN 1 END) AS bronze_count
FROM Olympics
GROUP BY team;
-- G. Identify countries that have won more than 50 Gold medals.
SELECT team FROM (
    SELECT team, COUNT(*) AS gold_count 
    FROM Olympics WHERE medal = 'Gold' 
    GROUP BY team
) AS gold_counts
WHERE gold_count > 50;
-- I. Find the athlete who has won the most medals
SELECT name, COUNT(*) AS total_medals
FROM Olympics
GROUP BY name
ORDER BY total_medals DESC
LIMIT 1;
-- J. List all events that include the term 'Freestyle' in their name 
SELECT DISTINCT event FROM Olympics WHERE event LIKE '%Freestyle%';
-- K. Find the top 3 athletes by the total number of medals won in each sport. 
SELECT sport, name, COUNT(*) AS total_medals
FROM Olympics
GROUP BY sport, name
ORDER BY total_medals DESC
LIMIT 3;
-- L. List athletes who won more than one medal in a single Olympic year. 
SELECT name, year, COUNT(*) AS total_medals
FROM Olympics
GROUP BY name, year
HAVING COUNT(*) > 1;
-- M. Identify countries that have won gold medals in both Summer and Winter Olympics 
SELECT team
FROM Olympics
GROUP BY team
HAVING COUNT(DISTINCT season) > 1 AND MAX(medal) = 'Gold';
-- N. Show the year difference between the first and last medal won by each country. 
SELECT team, MAX(year) - MIN(year) AS year_difference
FROM Olympics
GROUP BY team;
-- O. Calculate the average number of medals won per athlete for each country. 
SELECT team, COUNT(*) / COUNT(DISTINCT name) AS avg_medals_per_athlete
FROM Olympics
GROUP BY team;
-- P. Identify athletes who have won a silver medal and then later won a gold in the same event. 
SELECT o1.name, o1.event
FROM Olympics o1
JOIN Olympics o2 ON o1.name = o2.name AND o1.event = o2.event
WHERE o1.medal = 'Silver' AND o2.medal = 'Gold' AND o1.year < o2.year;
-- S. List countries that have won medals in more than 10 different sports. 
SELECT team
FROM (
    SELECT team, COUNT(DISTINCT sport) AS sports_count
    FROM Olympics
    GROUP BY team
) AS sports_counts
WHERE sports_count > 10;