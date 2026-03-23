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

-- Medium

/* Problem: Show unique first names from the patients table which only occurs once in the list.
For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output. */
SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(first_name) = 1;

/* Problem: Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row. */
SELECT 
  (SELECT count(*) FROM patients WHERE gender='M') AS male_count, 
  (SELECT count(*) FROM patients WHERE gender='F') AS female_count;

/* Problem: Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis. */
SELECT
  patient_id,
  diagnosis
FROM admissions
GROUP BY
  patient_id,
  diagnosis
HAVING COUNT(*) > 1;

/* Problem: Show the city and the total number of patients in the city.
Order from most to least patients and then by city name ascending. */
SELECT
  city,
  COUNT(*) AS num_patients
FROM patients
GROUP BY city
ORDER BY num_patients DESC, city ASC;

/* Problem: Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions. */
SELECT
  DAY(admission_date) AS day_number,
  COUNT(*) AS number_of_admissions
FROM admissions
GROUP BY day_number
ORDER BY number_of_admissions DESC;

/* Show first_name, last_name, and the total number of admissions attended for each doctor.
Every admission has been attended by a doctor. */
SELECT
  first_name,
  last_name,
  count(*) AS admissions_total
FROM admissions a JOIN doctors d 
  ON d.doctor_id = a.attending_doctor_id
GROUP BY attending_doctor_id;

/* Problem: Display the total amount of patients for each province. Order by descending. */
SELECT
  province_name,
  COUNT(*) AS patient_count
FROM patients pa JOIN province_names pr 
  ON pr.province_id = pa.province_id
GROUP BY pr.province_id
ORDER BY patient_count DESC;

/* Problem: display the first name, last name and number of duplicate patients based on their first name and last name.
Ex: A patient with an identical name can be considered a duplicate. */
SELECT
  first_name,
  last_name,
  COUNT(*) AS num_of_duplicates
FROM patients
GROUP BY
  first_name,
  last_name
HAVING COUNT(*) > 1;
