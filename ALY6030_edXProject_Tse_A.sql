-- 

-- ALY 6030 - edX Project

-- Part 2:

--------------------------------------------

-- Step 1:
--------------------------------------------


-- (i) Create the edX database. Write your sql script for creating this database in the space below:
#create schema if not exists edx;
DROP Database if exists edx;
create database if not exists edx; 
use edx;

-- (ii)	Create a first table in this database that is exactly the same as the table in the csv file. 
-- Assign the name “information” to this table. Next, dump data from the csv file into this table. 
-- Type your sql script in the space below for creating this table along with dumping data into it.  
DROP TABLE if exists information;
create table information(
course_id VARCHAR(50), Course_Short_Title CHAR(25), Course_Long_Title CHAR(100),
userID_DI VARCHAR(15), registered INT(1), viewed INT(1), explored INT(1), certified INT(1), Country CHAR(75), LoE_DI CHAR(25), YoB VARCHAR(4),
Age VARCHAR(2), gender CHAR(1), grade VARCHAR(3), nevents INT(5), ndays_act INT(3), nplay_video INT(3), nchapters INT(2),
nforum_posts INT(2), roles VARCHAR(25), incomplete_flag VARCHAR(1));

# Load data
SET GLOBAL local_infile = ON;
# Information
TRUNCATE information;
LOAD DATA LOCAL INFILE 'C:/Users/atse/Documents/ALY6030/EdXEnrollment.csv'
INTO TABLE information
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

# Testing the code
SELECT * from information;
DESCRIBE information;
SHOW TABLE STATUS LIKE 'information';
select * from information LIMIT 10;

-- (iii) Create the other tables that you have included in the design of your model.
-- Next, use the “information” table created above to dump data into each of the tables. 

-- Note: Primary and Foreign key assignments should be included with this step. 
--  Type your sql script for creating each table along with dumping data into each table.
DROP TABLE if exists course;

create table course(course_id VARCHAR(50) NOT NULL PRIMARY KEY, Course_Short_Title CHAR(25), Course_Long_Title CHAR(100), userID_DI VARCHAR(15));
SELECT DISTINCT(course_id), Course_Short_Title, Course_Long_Title from information limit 10; 

DROP TABLE if exists student;
create table student(userID_DI VARCHAR(15) NOT NULL PRIMARY KEY, Country CHAR(75), LoE_DI CHAR(25), YoB VARCHAR(4),
Age VARCHAR(2), gender CHAR(1));
# First ten rows of information table
select MAX(userid_DI) AS highest_id, course_id, Country, LoE_DI, YoB, Age, gender, grade from information
GROUP BY userid_DI limit 10; 

DROP TABLE if exists Course_user;
create table Course_user(userID_DI VARCHAR(15) NOT NULL PRIMARY KEY, 
registered INT(1), viewed INT(1), explored INT(1), certified INT(1),grade VARCHAR(3), 
nevents INT(5), ndays_act INT(3), nplay_video INT(3), nchapters INT(2),
nforum_posts INT(2), roles VARCHAR(10), incomplete_flag VARCHAR(10));
SELECT MAX(userid_DI) as highest_course_user, course_id, registered, viewed, explored, certified, 
nevents, ndays_act, nplay_video, nchapters, nforum_posts, roles, incomplete_flag from information
GROUP BY userid_DI limit 10;


--------------------------------------------

-- Step 2: Write queries to answer the following questions:
--------------------------------------------


--  Question 1: How many rows are there in the “information” table whose grades are not NULL?
--    write your query/queries in the space below:
SELECT COUNT(*)
FROM information 
WHERE grade IS NOT NULL;



--  Question 2: Among the rows in the “information” table whose grades are not NULL, 
--  list the countries with doctoral students; sorted by country. 
--    write your query/queries in the space below:
SELECT country AS international_country
FROM information 
WHERE grade IS NOT NULL 
AND LoE_DI = 'Doctorate'
GROUP BY country
ORDER BY count(LoE_DI) DESC;

-- Question 3: 3.How many students were registered in 6.00x at MIT during fall 2012 and Spring 2013 combined?#    
-- write your query/queries in the space below:
SELECT COUNT(*) AS MIT_SIX
FROM information
WHERE course_id = 'MITx/6.00x/2012_Fall'
OR course_id = 'MITx/6.00x/2013_Spring';


-- Question 4: What was the average grade in each term of 6.00x, 
-- excluding all the zeros for people who have not taken any tests. 
-- write your query/queries in the space below:
SELECT course_id, AVG(grade) AS average_grade_fall
FROM information
WHERE course_id = 'MITx/6.00x/2012_Fall' 
AND grade != 0
OR course_id = 'MITx/6.00x/2013_Spring'
AND grade != 0
group by course_id;


-- Question 5: What was the total number of people registered in each course offered (during all terms)?
--    write your query/queries in the space below:

SELECT course_id, COUNT(*) AS total_registered FROM information GROUP by course_id ORDER BY total_registered DESC;


-- Question 6: 	List courses that are hosted at Harvard, and have at least 2000 enrollees (registered).
-- Order these courses according to the number of enrollees from the largest to the smallest, 
--   and according to the term during when they were offered. 
--    write your query/queries in the space below:

SELECT course_id, count(*) AS Harvard_two_thousand
FROM information
WHERE course_id = 'HarvardX/CB22x/2013_Spring'
OR course_id = 'HarvardX/CS50x/2012'
OR course_id = 'HarvardX/ER22x/2013_Spring'
OR course_id = 'HarvardX/PH207x/2012_Fall'
OR course_id = 'HarvardX/PH278x/2013_Spring'
GROUP BY course_id
HAVING Harvard_two_thousand > 2000
ORDER BY Harvard_two_thousand DESC;


-- Question 7: For each course, how many people are registered, have viewed, 
--  have explored, and have become certified? 
--  Group the courses by Course_Long_Title.
--    write your query/queries in the space below:

SELECT Course_Long_Title, SUM(registered) AS registered_total, 
SUM(viewed) AS total_viewed, SUM(explored) as total_explored, 
SUM(certified) AS total_certified
FROM information
GROUP BY Course_Long_Title;


-- Question 8: What fraction of users view, explore, or certify in the content 
--  in each course once they have registered? 
--  Group the courses by Course_Long_Title.  
--    write your query/queries in the space below:	 
SELECT Course_Long_Title, SUM(viewed)/COUNT(registered) AS frac_viewed, SUM(explored)/count(registered) as frac_explored, 
SUM(certified)/count(registered) AS certified_frac
FROM information
WHERE registered = 1
GROUP BY Course_Long_Title;





-- Question 9: List the classes taught at Harvard with more than 1500 enrollees. 
--  Group the classes according to the term during which they were offered, and 
--  Order them according to the number of enrollees in descending order. 
--    write your query/queries in the space below:
SELECT course_id, count(userID_DI) AS Harvard_fifteen_hundred
FROM information
WHERE course_id LIKE 'HarvardX%'
GROUP BY course_id 
HAVING Harvard_fifteen_hundred > 1500
ORDER BY (course_id & Harvard_fifteen_hundred) ASC;



-- Question 10:List Users who have registered for more than three courses.  
--  Include user's ID, age, country, level of education, and the number of 
--  courses registered. 
--  Order the list according to the number of courses that the user has registered in. 
--    write your query/queries in the space below:
select userID_DI, Age, Country, LoE_DI, course_id, count(course_id) AS total_courses
FROM information
GROUP BY userID_DI
HAVING count(course_id) > 3
ORDER BY total_courses DESC;




-- Question 11: How many users are there by country, ordered alphabetically, 
--  and not including those whose 'Country' is indicated to be 'Unknown/Other' or 'Other'.
--    write your query/queries in the space below:
select Country, COUNT(userID_DI) AS course_users
FROM information
WHERE country <> 'Unknown/Other' 
AND country <> 'Other'
GROUP BY Country
ORDER BY Country ASC;



-- Question 12: For each country, what tis the average grade for the certified users? 
--  Do not include those whose 'Country' is labeled as 'Unknown/Other' or 'Other". 
--  Also, do not include users with a NULL grade. 
--  Sort the list from the highest average to the lowest. 
--    write your query/queries in the space below:

SELECT Country, avg(grade) as cert_avg_grade
FROM information
WHERE Country <> 'Unknown/Other' 
AND Country <> 'Other'
AND certified = 1
AND grade IS NOT NULL
GROUP BY Country
ORDER BY cert_avg_grade DESC;







-- Question 13: For each country, what is the average grade for the certified users 
--   at Harvard, excluding countries whose name start with "Other"? 
--   Order the list according to the average grades from the highest to the lowest. 
--    write your query/queries in the space below:
SELECT Country, avg(grade) as cert_avg_grade_harvard
FROM information
WHERE Country NOT LIKE 'Other%'
AND certified = 1
AND course_id LIKE 'Harvard%'
AND grade IS NOT NULL
GROUP BY Country
ORDER BY cert_avg_grade_harvard DESC;



-- Question 14: Rank each student, across all terms and in each of the 6.002x courses (in descending order),
--  according to his/her grade in this course, across all terms. 
--    write your query/queries in the space below:


SELECT userID_DI, course_id, avg(grade) as avg_mit_grade
FROM information
WHERE course_id LIKE '%6.002x%'
GROUP BY userID_DI
ORDER BY avg_mit_grade DESC;
--  ------------------------------------------------------------------
--  ------------------------------------------------------------------

-- END


--  ------------------------------------------------------------------
--  ------------------------------------------------------------------