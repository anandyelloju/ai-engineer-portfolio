-- Medium

/* Problem: Show all columns for patient_id 542's most recent admission_date. */
SELECT *
FROM admissions
WHERE patient_id = 542
ORDER BY admission_date DESC
LIMIT 1

/* Problem: Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis. */
SELECT
  patient_id,
  diagnosis
FROM admissions
GROUP BY
  patient_id,
  diagnosis
HAVING COUNT(*) > 1;

/* Problem: Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000. */
SELECT
  province_id,
  SUM(height) AS sum_height
FROM patients
GROUP BY province_id
HAVING sum_height >= 7000;

/* Problem: Show all columns for patient_id 542's most recent admission_date. */
SELECT *
FROM admissions
GROUP BY patient_id
HAVING patient_id = 542
  AND MAX(admission_date);

/* Problem: display the first name, last name and number of duplicate patients based on their first name and last name.
Ex: A patient with an identical name can be considered a duplicate. */
SELECT 
  first_name,
  last_name,
  COUNT(*) AS num_of_duplicates
FROM patients 
GROUP BY first_name, last_name
HAVING num_of_duplicates > 1;

-- Hard

/* Problem: Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name */
SELECT pr.province_name
FROM patients AS pa JOIN province_names AS pr 
  ON pa.province_id = pr.province_id
GROUP BY pr.province_name
HAVING COUNT( CASE WHEN gender = 'M' THEN 1 END) > COUNT( CASE WHEN gender = 'F' THEN 1 END); 