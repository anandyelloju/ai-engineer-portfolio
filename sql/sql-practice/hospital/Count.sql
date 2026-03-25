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

--- Hard

/* Problem: Show all of the patients grouped into weight groups.
Show the total amount of patients in each weight group.
Order the list by the weight group decending.
For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc. */
SELECT
  COUNT(patient_id) AS patients_in_group,
  FLOOR(weight / 10) * 10 AS weight_group
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;

/* Problem: Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name */
SELECT pr.province_name
FROM patients AS pa JOIN province_names AS pr 
  ON pa.province_id = pr.province_id  
GROUP BY pr.province_name
HAVING SUM(CASE WHEN pa.gender = 'M' THEN 1 ELSE 0 END) > SUM(CASE WHEN pa.gender = 'F' THEN 1 ELSE 0 END);

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

/* Problem: For each day display the total amount of admissions on that day. Display the amount changed from the previous date. */
SELECT
  admission_date,
  COUNT(*) AS total_admissions,
  COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY admission_date) AS change_from_previous_day 
FROM admissions
GROUP BY admission_date
ORDER BY admission_date;

/* Problem: We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year. */
SELECT 
  d.doctor_id,
  CONCAT(d.first_name, ' ', d.last_name) AS doctor_full_name,
  d.specialty,
  YEAR(a.admission_date) AS year,
  COUNT(*) AS total_admissions
FROM admissions a JOIN doctors d 
  ON a.attending_doctor_id = d.doctor_id
GROUP BY d.doctor_id, doctor_full_name, d.specialty, year
ORDER BY year, total_admissions DESC;