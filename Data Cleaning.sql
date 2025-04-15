### US Household Income Data Cleaning 

SELECT * 
FROM us_project.us_household_income;

SELECT * 
FROM us_project.us_household_income_statistics;

### Alter Column Name 
ALTER TABLE us_project.us_household_income_statistics
RENAME COLUMN `ï»¿id` TO `id`

### Compare the total id for both tables 
SELECT COUNT(id)
FROM us_project.us_household_income;

SELECT COUNT(id) 
FROM us_project.us_household_income_statistics;


### Identify duplicates
SElECT id, COUNT(id)
FROM us_project.us_household_income
GROUP BY id
HAVING COUNT(id) > 1
;

SELECT * 
FROM (
SELECT row_id,
id,
ROW_NUMBER () OVER (PARTITION BY id ORDER BY id) row_num
FROM us_project.us_household_income
) duplicates
WHERE row_num > 1
;
#### Delete duplicates 
DELETE FROM us_household_income
WHERE row_id IN (
		SELECT row_id
		FROM (
		SELECT row_id,
		id,
		ROW_NUMBER () OVER (PARTITION BY id ORDER BY id) row_num
		FROM us_project.us_household_income
		) duplicates
		WHERE row_num > 1)
;
##### UPDATE STATE NAME that has incorect spelling
SELECT DISTINCT State_Name
FROM us_project.us_household_income
ORDER BY State_Name;

UPDATE us_household_income
SET State_Name = 'Georgia' 
WHERE State_Name = 'georia';

UPDATE us_household_income
SET State_Name = 'Alabama' 
WHERE State_Name = 'alabama';


##### Populate a blank column 
SELECT *
FROM us_project.us_household_income
WHERE County = 'Autauga County'
ORDER BY 1;

UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont';


#### Update 'Boroughs' to 'Borough'
SELECT Type, COUNT(Type)
FROM us_project.us_household_income
GROUP By Type
ORDER BY 1;

UPDATE us_household_income
SET Type = 'Borough' 
WHERE Type = 'Boroughs';


#### Look for ALand and AWater with '0' or BLANK or NULL
SELECT Aland, Awater
FROM us_project.us_household_income
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL)
AND (ALand = 0 OR ALand = '' OR ALand IS NULL);
