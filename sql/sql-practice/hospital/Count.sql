-- Easy

/* Problem: Show how many patients have a birth_date with 2010 as the birth year. */
SELECT COUNT(*) AS total_patients
FROM patients
WHERE YEAR(birth_date) = 2010;

/* Problem: Show the total number of admissions */
SELECT COUNT(*) AS total_admissions
FROM admissions;

/* Problem: Show the patient id and the total number of admissions for patient_id 579. */
SELECT
  patient_id,
  COUNT(*) AS total_admissions
FROM admissions
WHERE patient_id = 579;
