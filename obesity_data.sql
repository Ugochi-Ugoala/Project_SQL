1. Retrieve the details of patients with a BMI greater than 30

Select Age, Gender, Bmi
from obesity
where bmi > 30
group by 1,2,3
Order by 1 Asc

2. Calculate the average BMI for male and female patients separately

SELECT Gender, AVG(bmi) AS AVG_Bmi
FROM obesity
GROUP BY Gender;

-- Find the oldest patient's details in the dataset?

SELECT *
FROM obesity
ORDER BY AGE DESC
LIMIT 1;

-- Count the number of patients in each age group (e.g., 18-25, 26-35, 36-45,etc)

SELECT 
	CASE
		WHEN age BETWEEN 18 AND 25 THEN '18-25'
		WHEN age BETWEEN 26 AND 35 THEN '26-35'
		WHEN age BETWEEN 36 AND 45 THEN '36-45'
		WHEN age BETWEEN 46 AND 59 THEN '46-59'
		WHEN age BETWEEN 60 AND 79 THEN '60-79'
	END AS Age_group,
	COUNT (*) AS Patient_count
FROM obesity
GROUP BY Age_group;

-- Retrieve the details of patients with weight greater than 50 kg and height less than 160 cm

SELECT *
FROM obesity
WHERE Weight > 50 AND Height < 160;

-- Calculate the total number of male and female patients in the dataset
SELECT Gender, COUNT(*) Gender_count
FROM obesity
GROUP BY Gender;

-- Find the average age of patients with a BMI less than 25
SELECT Bmi, ROUND(AVG(Age),1) AS Avg_age
FROM obesity
WHERE Bmi < 25
GROUP BY Bmi;

-- Identify patients with an overweight status (BMI between 25 and 30) and list their details

SELECT *
FROM obesity
WHERE Bmi BETWEEN 25 AND 30 
ORDER BY Age ASC

-- Calculate the total number of patients in the dataset

SELECT COUNT(*) Total_patient
FROM obesity

-- Retrieve the details of the five patients with the highest BMI values

SELECT *
FROM Obesity
ORDER BY Bmi DESC
LIMIT 5;