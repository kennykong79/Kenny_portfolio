### WOLRD LIFE EXPECTANCY PROJECT (DATA CLEANING) 

SELECT * 
FROM WORLD_LIFE_EXPECTANCY;

### TO FIND ANY DUPLICATES 
SELECT COUNTRY, YEAR, CONCAT(COUNTRY,YEAR), COUNT(CONCAT(COUNTRY,YEAR))
FROM WORLD_LIFE_EXPECTANCY
GROUP BY COUNTRY, YEAR, CONCAT(COUNTRY,YEAR)
HAVING COUNT(CONCAT(COUNTRY,YEAR)) > 1;

### HOW TO FIND THE ROW_ID FOR DUPLICATES
SELECT ROW_ID, CONCAT(COUNTRY,YEAR),
ROW_NUMBER() OVER( PARTITION BY CONCAT(COUNTRY, YEAR) 
ORDER BY CONCAT(COUNTRY,YEAR)) AS ROW_NUM
FROM world_life_expectancy;

SELECT *
FROM (
		SELECT ROW_ID, CONCAT(COUNTRY,YEAR),
		ROW_NUMBER() OVER( PARTITION BY CONCAT(COUNTRY, YEAR) 
		ORDER BY CONCAT(COUNTRY,YEAR)) AS ROW_NUM
		FROM world_life_expectancy) AS ROW_TABLE
WHERE ROW_NUM > 1;

### HOW TO DELETE ROW_NUM > 1
DELETE FROM world_life_expectancy
WHERE 
	ROW_ID IN (
	SELECT ROW_ID
FROM (
		SELECT ROW_ID, CONCAT(COUNTRY,YEAR),
		ROW_NUMBER() OVER( PARTITION BY CONCAT(COUNTRY, YEAR) 
		ORDER BY CONCAT(COUNTRY,YEAR)) AS ROW_NUM
		FROM world_life_expectancy) AS ROW_TABLE
WHERE ROW_NUM > 1
)
;

#### How to fill out Status NULL
SELECT * 
FROM WORLD_LIFE_EXPECTANCY
WHERE Status = '';


SELECT DISTINCT(Status) 
FROM WORLD_LIFE_EXPECTANCY
WHERE Status <> '';

SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE status = 'Developing'

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1. Status = 'Developing'
WHERE t2.Status <> ''
AND t2.Status = 'Developing';


UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1. Status = 'Developed'
WHERE t2.Status <> ''
AND t2.Status = 'Developed';


#### How to fill out Life Expectancy NULL with SELF JOIN (to get the average)
SELECT * 
FROM WORLD_LIFE_EXPECTANCY;

SELECT Country, Year, `Life expectancy`
FROM WORLD_LIFE_EXPECTANCY
WHERE `Life expectancy` = ''


SELECT t1.Country, t1.Year, t1.`Life expectancy`,
t2.Country, t2.Year, t2.`Life expectancy`,
t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`) /2, 1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
	AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
	AND t1.Year = t3.Year + 1  
WHERE t1.`Life expectancy` = ''


UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
	AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
	AND t1.Year = t3.Year + 1  
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`) /2, 1)
WHERE t1.`Life expectancy` = ''
;