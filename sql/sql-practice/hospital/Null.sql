-- Easy

/* Problem: Show first name and last name of patients who does not have allergies. (null) */
SELECT
  first_name,
  last_name
FROM patients
WHERE allergies IS NULL;

/* Problem: Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton' */
SELECT
  first_name,
  last_name,
  allergies
FROM patients
WHERE city = 'Hamilton'
  AND allergies IS Not NULL;