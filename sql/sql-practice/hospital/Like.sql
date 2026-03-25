-- Easy

/* Problem: Show first name of patients that start with the letter 'C' */
SELECT
  first_name
FROM patients
WHERE first_name LIKE 'C%';

-- Medium

/* Problem: Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long. */
SELECT
  patient_id,
  first_name
FROM patients
WHERE first_name LIKE 's____%s';

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