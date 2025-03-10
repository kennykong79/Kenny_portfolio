### WOLRD LIFE EXPECTANCY PROJECT (Exploratory Data Analysis)
SELECT * 
FROM world_life_expectancy;

###Find MIN, MAX of Life Expectancy, Life_Increase in 15 Years
SELECT Country, MIN(`Life expectancy`), MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15_Years ASC;

### Find Average Increase in life expectancy 
SELECT Year, ROUND(AVG(`Life Expectancy`),2)
FROM world_life_expectancy
WHERE `Life Expectancy` <> 0
AND `Life Expectancy` <> 0
GROUP BY Year
ORDER BY Year;


###Correlation between Life Expectancy and GDP 
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp , ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY GDP DESC;


### Case Statement 
SELECT 
CASE
	WHEN GDP >= 1500 THEN 1 
    ELSE 0
END High_GDP_Count
FROM world_life_expectancy;


SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Life Expectancy` ELSE NULL END) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Life Expectancy` ELSE NULL END) Low_GDP_Life_Expectancy
FROM world_life_expectancy;


### Status and Life Expectancy
SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status;


### BMI and Life Expectancy
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp , ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND BMI > 0
ORDER BY BMI DESC;


### Rolling Total 
SELECT country, year, `Life expectancy`, `Adult Mortality`, 
SUM(`Adult Mortality`) OVER (PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
WHERE Country LIKE '%United%';


















