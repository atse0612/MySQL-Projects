# Schema Created
#Create schema aly6030_assignment2;
USE aly6030_assignment2;

# Test codes
SELECT COUNT(*) FROM bed_fact;
SELECT COUNT(*) FROM bed_type;
SELECT COUNT(*) FROM business;
SELECT * FROM bed_fact;
SELECT * FROM bed_type;
SELECT * FROM business;

# Question 4.1 
SELECT b.business_name AS hospital, SUM(bf.license_beds) AS sum_license
FROM bed_fact AS bf
JOIN business AS b ON bf.ims_org_id = b.ims_org_id
WHERE bf.bed_id = 4 OR bf.bed_id = 15 
GROUP BY hospital 
ORDER BY sum_license DESC
LIMIT 10;

# Question 4.2 
SELECT b.business_name AS hospital, SUM(bf.census_beds) AS sum_census
FROM bed_fact AS bf
JOIN business AS b ON bf.ims_org_id = b.ims_org_id
WHERE bf.bed_id = 4 OR bf.bed_id = 15 
GROUP BY hospital 
ORDER BY sum_census DESC
LIMIT 10;

# Question 4.3 
SELECT b.business_name AS hospital, SUM(bf.staffed_beds) AS sum_staffed
FROM bed_fact AS bf
JOIN business AS b ON bf.ims_org_id = b.ims_org_id
WHERE bf.bed_id = 4 OR bf.bed_id = 15 
GROUP BY hospital 
ORDER BY sum_staffed DESC
LIMIT 10;

# Question 5.1 
SELECT b.business_name AS hospital, SUM(bf.license_beds) AS sum_license
FROM bed_fact AS bf
LEFT JOIN business AS b ON bf.ims_org_id = b.ims_org_id
WHERE bf.bed_id = 4 OR bf.bed_id = 15 
GROUP BY hospital 
HAVING COUNT(hospital) > 1
ORDER BY sum_license DESC
LIMIT 10;

# Question 5.2 
SELECT b.business_name AS hospital, SUM(bf.census_beds) AS sum_census
FROM bed_fact AS bf
LEFT JOIN business AS b ON bf.ims_org_id = b.ims_org_id
WHERE bf.bed_id = 4 OR bf.bed_id = 15 
GROUP BY hospital 
HAVING COUNT(hospital) > 1
ORDER BY sum_census DESC
LIMIT 10;


# Question 5.3 
SELECT b.business_name AS hospital, SUM(bf.staffed_beds) AS sum_staffed
FROM bed_fact AS bf
LEFT JOIN business AS b ON bf.ims_org_id = b.ims_org_id
WHERE bf.bed_id = 4 OR bf.bed_id = 15 
GROUP BY hospital 
HAVING COUNT(hospital) > 1
ORDER BY sum_staffed DESC
LIMIT 10;