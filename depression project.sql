SELECT *
FROM depression;

CREATE TABLE depression_2
LIKE depression;

SELECT *
FROM depression_2;

INSERT depression_2
SELECT *
FROM depression;

SELECT * 
FROM depression_2;

SELECT Gender, City, CGPA, Depression 
FROM depression_2;

--  Find top 5 GPA and what city they reside in 

SELECT * 
FROM depression_2
ORDER BY CGPA DESC;

WITH RankedData AS (
	SELECT
		City,
        CGPA,
        ROW_NUMBER() OVER (ORDER BY CGPA DESC) AS 'Rank'
	FROM depression_2
)
SELECT *
FROM RankedData
WHERE 'Rank' <= 5
LIMIT 5;

 -- Finding the relationship between degree and Financial Stress

SELECT Degree, AVG (`Financial Stress`) AS AVG_FinancialStress
FROM depression_2 
GROUP BY Degree
ORDER BY AVG_FinancialStress DESC
LIMIT 5;

SELECT Depression, AVG(CASE 
                         WHEN `Sleep Duration` = 'Less than 5 hours' THEN 1
                         WHEN `Sleep Duration` = '5-6 hours' THEN 2
                         WHEN `Sleep Duration` = '7-8 hours' THEN 3
                         WHEN `Sleep Duration` = '9-10 hours' THEN 4
                         WHEN `Sleep Duration` = 'More than 10 hours' THEN 5
                         ELSE NULL
                     END) AS Avg_Sleep_Score
FROM depression_2
GROUP BY Depression;

SELECT *
FROM depression_2;

SELECT Degree, COUNT(`Have you ever had suicidal thoughts ?`) AS Suicidal_thoughts
FROM depression_2
GROUP BY Degree;

-- What percentage of students with "Healthy" dietary habits report depression versus those with "Moderate" or "Unhealthy" dietary habits?

SELECT 
    `Dietary Habits`,
    COUNT(*) AS Total_Students,
    SUM(CASE WHEN Depression = 1 THEN 1 ELSE 0 END) AS Students_With_Depression
FROM depression_2
GROUP BY `Dietary Habits`;

-- Total of Students with Depression and the perctanges under different Dietary Habits
SELECT 
    `Dietary Habits`,
    COUNT(*) AS Total_Students,
    SUM(CASE WHEN Depression = 1 THEN 1 ELSE 0 END) AS Students_With_Depression,
    ROUND((SUM(CASE WHEN Depression = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS Depression_Percentage
FROM 
    depression_2
GROUP BY 
    `Dietary Habits`
ORDER BY 
    Depression_Percentage DESC;


