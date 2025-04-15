### US HOUSEHOLD INCOME EXPLORATORY DATA ANALYSIS 

SELECT *
FROM us_household_income;

SELECT *
FROM us_household_income_statistics;

#### Find out the states with the largest Land and/or Water
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10;

SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 3 DESC
LIMIT 10;


#### JOIN Tables 
SELECT *
FROM us_household_income u
JOIN us_household_income_statistics us 
	ON u.id = us.id
WHERE Mean <> 0;

### Find Out the Average Mean and Median 
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us 
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name;

### Find Out the top 10 lowest average Mean Household Income
SELECT u.State_Name, ROUND(AVG(Mean),1)
FROM us_household_income u
JOIN us_household_income_statistics us 
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2
LIMIT 10;

### Find Out the top 10 highest average Mean Household Income
SELECT u.State_Name, ROUND(AVG(Mean),1)
FROM us_household_income u
JOIN us_household_income_statistics us 
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2 DESC
LIMIT 10;

### Find Out the top 10 lowest average Median Household Income
SELECT u.State_Name, ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us 
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2
LIMIT 10;

### Find Out the top 10 highest average Median Household Income
SELECT u.State_Name, ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us 
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2 DESC
LIMIT 10;

#### Find out relationship between Type and Mean and Median
SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us 
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY Type
ORDER BY 3 DESC;

### Find out which state has the `Community` Type (Lowest Household Income)
SELECT *
FROM us_household_income
WHERE Type = 'Community';



##### Filter out the Outliers 
SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us 
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY Type
HAVING COUNT(Type) > 100
ORDER BY 3 DESC;



##### Find out Top 10 Cities with the Highest Average Household Income 
SELECT u.State_Name, City, ROUND(AVG(Mean),1)
FROM us_household_income u
JOIN us_household_income_statistics us 
	ON u.id = us.id
GROUP BY u.State_Name, City
ORDER BY 3 DESC
LIMIT 10;
