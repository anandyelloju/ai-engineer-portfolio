-- Easy

/* Problem: Show first name, last name, and gender of patients whose gender is 'M' */
SELECT
  first_name,
  last_name,
  gender
FROM patients
WHERE gender = 'M';

/* Problem: Show first name and last name of patients who does not have allergies. (null) */
SELECT
  first_name,
  last_name
FROM patients
WHERE allergies IS NULL;

/* Problem: Show first name of patients that start with the letter 'C' */
SELECT
  first_name
FROM
  patients
WHERE
  first_name LIKE 'C%';

/* Problem: Show first name and last name of patients that weight within the range of 100 to 120 (inclusive) */
SELECT
  first_name,
  last_name
FROM patients
WHERE weight BETWEEN 100 AND 120;

/* Problem: Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA' */
UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL;

/* Problem: Show how many patients have a birth_date with 2010 as the birth year. */
SELECT COUNT(*) AS total_patients
FROM patients
WHERE YEAR(birth_date) = 2010;

/* Problem: Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000 */
SELECT *
FROM patients
WHERE patient_id IN (1, 45, 534, 879, 1000);

/* Problem: Show all the columns from admissions where the patient was admitted and discharged on the same day. */
SELECT *
FROM admissions
WHERE admission_date = discharge_date;

/* Problem: Show the patient id and the total number of admissions for patient_id 579. */
SELECT
  patient_id,
  COUNT(*) AS total_admissions
FROM admissions
WHERE patient_id = 579;

/* Problem: Based on the cities that our patients live in, show unique cities that are in province_id 'NS'. */
SELECT DISTINCT(city) AS unique_cities
FROM patients
WHERE province_id = 'NS';

/* Problem: Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70 */
SELECT 
  first_name,
  last_name, 
  birth_date 
FROM patients
WHERE height > 160 
  AND weight > 70;

/* Problem: Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton' */
SELECT
  first_name,
  last_name,
  allergies
FROM patients
WHERE city = 'Hamilton'
  AND allergies IS NOT NULL;

-- Medium

/* Problem: Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long. */
SELECT
  patient_id,
  first_name
FROM patients
WHERE first_name LIKE 's____%s';

/* Problem: Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
Primary diagnosis is stored in the admissions table. */
SELECT
  patients.patient_id,
  first_name,
  last_name
FROM patients JOIN admissions 
  ON admissions.patient_id = patients.patient_id
WHERE diagnosis = 'Dementia';

/* Problem: Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row. */
SELECT 
  (SELECT count(*) FROM patients WHERE gender='M') AS male_count, 
  (SELECT count(*) FROM patients WHERE gender='F') AS female_count;

/* Problem: Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name. */
SELECT
  first_name,
  last_name,
  allergies
FROM patients
WHERE allergies IN ('Penicillin', 'Morphine')
ORDER BY
  allergies,
  first_name,
  last_name;

/* Problem: Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date. */
SELECT
  first_name,
  last_name,
  birth_date
FROM patients
WHERE
  YEAR(birth_date) BETWEEN 1970 AND 1979
ORDER BY birth_date;

/* Problem: Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni' */
SELECT
  (MAX(weight) - MIN(weight)) AS weight_delta
FROM patients
WHERE last_name = 'Maroni';

/* Problem: Show all columns for patient_id 542's most recent admission_date. */
SELECT *
FROM admissions
WHERE patient_id = 542
GROUP BY patient_id
HAVING admission_date = MAX(admission_date);

/* Problem: Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters. */
SELECT
  patient_id,
  attending_doctor_id,
  diagnosis
FROM admissions
WHERE
  ( attending_doctor_id IN (1, 5, 19)
    AND patient_id % 2 != 0
  )
  OR 
  ( attending_doctor_id LIKE '%2%'
    AND len(patient_id) = 3
  );

/* Problem: Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.) */
SELECT
  patients.patient_id,
  first_name,
  last_name
FROM patients LEFT JOIN admissions 
  ON patients.patient_id = admissions.patient_id
WHERE admissions.patient_id IS NULL;

/* Problem: Display every patient that has at least one admission and show their most recent admission along with the patient and doctor's full name. */
SELECT 
    p.first_name || ' ' || p.last_name AS patient_name,
    a.admission_date,
    d.first_name || ' ' || d.last_name AS doctor_name
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE a.admission_date = (
    SELECT MAX(a2.admission_date)
    FROM admissions a2
    WHERE a2.patient_id = p.patient_id
);

-- Hard

/* Problem: Show patient_id, first_name, last_name, and attending doctor's specialty.
Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'
Check patients, admissions, and doctors tables for required information. */
SELECT 
  p.patient_id,
  p.first_name,
  p.last_name,
  d.specialty 
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy' AND d.first_name = 'Lisa';

/* Problem: We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
- First_name contains an 'r' after the first two letters.
- Identifies their gender as 'F'
- Born in February, May, or December
- Their weight would be between 60kg and 80kg
- Their patient_id is an odd number
- They are from the city 'Kingston' */
SELECT *
FROM patients
WHERE
  first_name LIKE '__%r%'
  AND gender = 'F'
  AND MONTH(birth_date) IN (2, 5, 12)
  AND weight BETWEEN 60 AND 80
  AND patient_id % 2 = 1
  AND city = 'Kingston';

/* Problem: Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form. */
SELECT
  ROUND(
    (CAST(
      COUNT(
        CASE 
          WHEN gender = 'M' THEN 1 
        END) 
      AS FLOAT) / COUNT(*)) * 100,
    2 ) || '%' AS percent_male
FROM patients;  
