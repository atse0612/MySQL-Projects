# Assignment 3

#Create schema aly6030_assignment3;
Use aly6030_assignment3;

# Creating the database
#CREATE DATABASE IF NOT EXISTS aly6030_assignment3;
#CREATE TABLE IF NOT EXISTS public_housing_inspection_data;
#CREATE TABLE public_housing_inspection_data(
#	INSPECTION_ID INT(6) NOT NULL AUTO_INCREMENT,
#    PUBLIC_HOUSING_AGENCY_NAME VARCHAR(255),
#    COST_OF_INSPECTION_IN_DOLLARS INT(6),    
#    INSPECTED_DEVELOPMENT_NAME VARCHAR(100),
#    INSPECTED_DEVELOPMENT_ADDRESS VARCHAR(255),
#    INSPECTED_DEVELOPMENT_CITY VARCHAR(100),
#    INSPECTION_DATE DATE,
#    INSPECTION_SCORE INT(3));



# Testing the code
select * from public_housing_inspection_data;

# Question 5
Drop table if exists pha;
create table pha AS
SELECT INSPECTION_ID, PUBLIC_HOUSING_AGENCY_NAME AS PHA_NAME, 
INSPECTION_DATE AS MR_INSPECTION_DATE, COST_OF_INSPECTION_IN_DOLLARS AS MR_INSPECTION_COST,
LEAD(INSPECTION_DATE, 1) OVER (ORDER BY INSPECTION_ID, INSPECTION_DATE DESC) AS SECOND_MR_INSPECTION_DATE,
LEAD(COST_OF_INSPECTION_IN_DOLLARS, 1, 0) OVER (ORDER BY INSPECTION_ID, COST_OF_INSPECTION_IN_DOLLARS DESC) AS SECOND_MR_INSPECTION_COST
#COST_OF_INSPECTION_IN_DOLLARS AS SECOND_MR_INSPECTION_COST
FROM public_housing_inspection_data;

# Testing the created table
SELECT * FROM pha;

# Obtaining the renamed results
SELECT *, (SECOND_MR_INSPECTION_COST - MR_INSPECTION_COST) AS CHANGE_IN_COST, 
((SECOND_MR_INSPECTION_COST - MR_INSPECTION_COST)/MR_INSPECTION_COST) AS PERCENT_CHANGE_IN_COST 
FROM pha
WHERE SECOND_MR_INSPECTION_DATE IS NOT NULL
HAVING CHANGE_IN_COST > 0;

# Additional Conditions asked
SELECT distinct(PHA_NAME), MR_INSPECTION_DATE, SECOND_MR_INSPECTION_DATE, MR_INSPECTION_COST, 
SECOND_MR_INSPECTION_COST, (SECOND_MR_INSPECTION_COST - MR_INSPECTION_COST) AS CHANGE_IN_COST, 
((SECOND_MR_INSPECTION_COST - MR_INSPECTION_COST)/MR_INSPECTION_COST) AS PERCENT_CHANGE_IN_COST 
FROM pha
WHERE SECOND_MR_INSPECTION_DATE IS NOT NULL
group by PHA_NAME
HAVING CHANGE_IN_COST > 0
ORDER BY PERCENT_CHANGE_IN_COST DESC;