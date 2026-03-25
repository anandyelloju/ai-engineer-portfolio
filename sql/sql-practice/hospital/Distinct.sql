-- Easy 

/* Problem: Based on the cities that our patients live in, show unique cities that are in province_id 'NS'. */
SELECT 
  DISTINCT city AS unique_cities
FROM patients
WHERE province_id = 'NS';

-- Medium

/* Problem: Show unique birth years from patients and order them by ascending. */
SELECT
  DISTINCT YEAR(birth_date) AS birth_year
FROM patients
ORDER BY birth_year;

-- Hard

/* Problem: All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
The password must be the following, in order:
1. patient_id
2. the numerical length of patient's last_name
3. year of patient's birth_date */
SELECT
  DISTINCT P.patient_id,
  CONCAT(
    P.patient_id,
    LEN(last_name),
    YEAR(birth_date)
  ) AS temp_password
FROM patients P JOIN admissions A 
  ON A.patient_id = P.patient_id;