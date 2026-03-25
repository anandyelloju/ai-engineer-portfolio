-- Easy

/* Problem: Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000 */
SELECT * 
FROM patients
WHERE patient_id IN (1,45,534,879,1000);

-- Medium

/* Problem: Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name. */
SELECT
  first_name,
  last_name,
  allergies
FROM patients
WHERE
  allergies IN ('Penicillin', 'Morphine')
ORDER BY
  allergies,
  first_name,
  last_name;

/* Problem: Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters. */
SELECT 
  patient_id,
  attending_doctor_id,
  diagnosis
FROM admissions
WHERE 
  (
    patient_id % 2 = 1 
    AND attending_doctor_id IN (1, 5, 19)
  )
  OR
  (
    CAST(attending_doctor_id AS VARCHAR) LIKE '%2%'
    AND LEN(CAST(patient_id AS VARCHAR)) = 3
  );

/* Problem: Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.) */
SELECT
  patients.patient_id,
  first_name,
  last_name
FROM patients
WHERE patients.patient_id NOT IN (
    SELECT admissions.patient_id
    FROM admissions
  );

  -- Hard

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