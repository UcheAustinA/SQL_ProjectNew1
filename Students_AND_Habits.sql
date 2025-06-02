-- Students Habit Vs Academic Performance

-- Creating The Table

DROP TABLE IF EXISTS My_Students_Habitz;
CREATE TABLE My_Students_Habitz (
	student_id INT PRIMARY KEY,
	age INT,
	gender VARCHAR (15),
	study_hours_per_day FLOAT,
	social_media_hours FLOAT,
	netflix_hours FLOAT,
	part_time_job VARCHAR (10),
	attendance_percentage FLOAT,
	sleep_hours FLOAT,
	diet_quality VARCHAR (15),
	exercise_frequency INT,
	parental_education_level VARCHAR (20),
	internet_quality VARCHAR (20),
	mental_health_rating INT,
	extracurricular_participation VARCHAR (5),
	exam_score FLOAT
)
;

SELECT * FROM My_Students_Habitz;

SELECT COUNT(*) FROM My_Students_Habitz;

-- Check for Null values (Data cleaning)
SELECT * FROM My_Students_Habitz 
WHERE student_id IS NULL
OR age IS NULL
OR gender IS NULL
OR 	study_hours_per_day IS NULL
OR social_media_hours IS NULL
OR netflix_hours IS NULL
OR part_time_job IS NULL
OR attendance_percentage IS NULL
OR sleep_hours IS NULL
OR diet_quality IS NULL
OR exercise_frequency IS NULL
OR parental_education_level IS NULL
OR internet_quality IS NULL
OR mental_health_rating IS NULL
OR extracurricular_participation IS NULL
OR exam_score IS NULL;

-- DATA EXPLORATION

-- Total number of students involved
SELECT COUNT(DISTINCT student_id) AS "NUMBER OF STUDENTS" FROM My_Students_Habitz;

-- Diet Quality types
SELECT DISTINCT diet_quality AS "DIET QUALITY TYPES" FROM My_Students_Habitz;

-- Minimum Exam Score
SELECT MIN(exam_score) AS "MINIMUM EXAM SCORE" FROM My_Students_Habitz;

-- Maximum Exam Score
SELECT MAX(exam_score) AS "HIGHEST EXAM SCORE" FROM My_Students_Habitz;


-- * PERFORMING DATA ANALYSIS WITH KEY BUSINESS QUESTIONS AND ANSWERS

-- Q1. Write an SQL query to find the average age of the students
-- Q2. Write an SQL query to find the unique number of students with Good diet quality
-- Q3. Write an SQL query to find the average age of the students with a Part Time Job
-- Q4. Write an SQL query to find out number of students who engage in Extracurricular Participation
-- Q5. Write an SQL query to find the average sleep hours for the Male gender
-- Q6. Write an SQL query to find the unique number of students with Poor Internet Quality
-- Q7. Write an SQL query to find the number of students with the lowest exam score
-- Q8. Write an SQL query to find the number of students with the highest exam score
-- Q9. Write an SQL query to find the number of students with Mental Health Rating greater than the average
-- Q10. Write an SQL query to find the number of students who sleep more than the average sleep hours
-- Q11. Write an SQL query to find the average age of genders with high attendance rate and high exam scores
-- Q12. Write an SQL query to find the number of non-performing students
-- Q13. Write an SQL query to find out students who performed well in their exams even with poor Internet Quality
-- Q14. Write an SQL query to estimate student academic status


-- Q1. Write an SQL query to find the average age of the students
SELECT ROUND (AVG(age), 2) AS "Average Age" FROM My_Students_Habitz;

-- Q2. Write an SQL query to find the unique number of students with Good diet quality
SELECT COUNT(DISTINCT student_id) AS "Students with Good Diet Quality" FROM My_Students_Habitz
WHERE diet_quality = 'Good';

-- Q3. Write an SQL query to find the average age of the students with a Part Time Job
SELECT ROUND(AVG(age), 2) AS "Avg. Age of PTJ Students" FROM My_Students_Habitz
WHERE part_time_job = 'Yes';

-- Q4. Write an SQL query to find out number of students who engage in Extracurricular Participation
SELECT COUNT(student_id) AS "Extracurricular Students" FROM My_Students_Habitz
WHERE extracurricular_participation = 'Yes';

-- Q5. Write an SQL query to find the average sleep hours for the Male gender
SELECT gender, AVG(sleep_hours) AS "Average Male Sleep Hours" FROM My_Students_Habitz
WHERE gender = 'Male'
GROUP BY gender;

-- Q6. Write an SQL query to find the unique number of students with Poor Internet Quality
SELECT COUNT(DISTINCT student_id) AS "No. of Unique Students with Poor Internet Quality" FROM My_Students_Habitz
WHERE internet_quality IN ('Poor');

-- Q7. Write an SQL query to find the number of students with the lowest exam score
SELECT COUNT(student_id) AS "No. of Poor Students" FROM My_Students_Habitz
	WHERE exam_score =
	(SELECT MIN(exam_score) FROM My_Students_Habitz)
	;

-- Q8. Write an SQL query to find the number of students with the highest exam score
SELECT COUNT(student_id) AS "No. of Excellent Students" FROM My_Students_Habitz
	WHERE exam_score =
	(SELECT MAX(exam_score) FROM My_Students_Habitz)
	;

-- Q9. Write an SQL query to find the number of students with Mental Health Rating greater than the average
SELECT COUNT(student_id) AS "High Mental Health Stats" FROM My_Students_Habitz
	WHERE mental_health_rating >
	(SELECT ROUND(AVG(mental_health_rating), 2) FROM My_Students_Habitz);

-- Q10. Write an SQL query to find the number of students who sleep more than the average sleep hours
SELECT COUNT(student_id) AS "High Sleeping Students" FROM My_Students_Habitz
	WHERE sleep_hours >
	(SELECT AVG(sleep_hours) FROM My_Students_Habitz);

-- Q11. Write an SQL query to find the average age of genders with high attendance rate and high exam scores
SELECT gender, ROUND(AVG(age), 3) AS "Average age of good students" FROM My_Students_Habitz
WHERE attendance_percentage 
BETWEEN 90 AND 100
AND exam_score BETWEEN 80 AND 100
GROUP BY gender;

-- Q12. Write an SQL query to find the number of non-performing students
SELECT COUNT(student_id) AS "Non-performing students", gender FROM My_Students_Habitz
	WHERE social_media_hours > 3 
	AND netflix_hours > 3.5 
	AND study_hours_per_day < 3.5
	AND sleep_hours > 5.5
	AND exam_score < 50
	AND extracurricular_participation = 'No'
	GROUP BY gender;

-- Q13. Write an SQL query to find out students who performed well in their exams even with poor Internet Quality
SELECT student_id, internet_quality, exam_score FROM My_Students_Habitz
WHERE exam_score >= 80
AND internet_quality IN ('Poor')
;

-- Q14. Write an SQL query to estimate student academic status
SELECT age, exam_score,
	CASE
	WHEN exam_score >= 70 THEN 'Good Student'
	WHEN exam_score BETWEEN 50 AND 69.9 THEN 'Average Student'
	WHEN exam_score <= 49.9 THEN 'Poor Student'
	END AS Student_Status
FROM My_Students_Habitz;


--	END OF PROJECT