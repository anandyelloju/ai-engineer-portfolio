-- Medium

/* Problem: Show unique first names from the patients table which only occurs once in the list.
For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output. */
SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(first_name) = 1

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

/* Problem: Show all allergies ordered by popularity. Remove NULL values from query. */
SELECT
  allergies,
  count(allergies) AS total_diagnosis
FROM patients
GROUP BY allergies
HAVING
  allergies IS NOT NULL
ORDER BY total_diagnosis DESC;

/* Problem: Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000. */
SELECT
  province_id,
  SUM(height) AS sum_height
FROM patients
GROUP BY province_id
HAVING sum_height >= 7000;

/* Problem: Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions. */
SELECT
  DAY(admission_date) AS day_number,
  COUNT(*) AS number_of_admissions
FROM admissions
GROUP BY day_number
ORDER BY number_of_admissions DESC;

/* Problem: Show all columns for patient_id 542's most recent admission_date. */
SELECT *
FROM admissions
WHERE patient_id = 542
GROUP BY patient_id
HAVING admission_date = MAX(admission_date);

/* Problem: Show first_name, last_name, and the total number of admissions attended for each doctor.
Every admission has been attended by a doctor.*/
SELECT 
  d.first_name, 
  d.last_name,
  COUNT(a.patient_id) AS total_number_of_admissions
FROM admissions a JOIN doctors d 
  ON a.attending_doctor_id == d.doctor_id
GROUP BY attending_doctor_id;

/* Problem: For each doctor, display their id, full name, and the first and last admission date they attended. */
SELECT 
  d.doctor_id AS id,
  CONCAT(d.first_name, ' ' ,d.last_name) AS full_name,
  Min(a.admission_date) AS first_admission_date,
  MAX(a.admission_date) AS last_admission_date
FROM admissions a
JOIN doctors d 
  ON a.attending_doctor_id == d.doctor_id
GROUP BY id;

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
  count(*) AS num_of_duplicates
FROM patients 
GROUP BY first_name, last_name
HAVING num_of_duplicates > 1;

/* Problem: Display a single row with max_visits, min_visits, average_visits where the maximum, minimum and average number of admissions per day is calculated. Average is rounded to 2 decimal places. */
SELECT 
  MAX(visits) AS max_visits,
  MIN(visits) AS min_visits,
  ROUND(AVG(visits), 2) AS average_visits
FROM (
  SELECT COUNT(*) AS visits
  FROM admissions
  GROUP BY admission_date
) t;

-- Hard

/* Problem: Show all of the patients grouped into weight groups.
Show the total amount of patients in each weight group.
Order the list by the weight group decending.
For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc. */
SELECT
  COUNT(*) AS patients_in_group,
  FLOOR(weight / 10) * 10 AS weight_group
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;

/* Problem: Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.
Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group. */
SELECT 
CASE 
  WHEN patient_id % 2 = 0 Then 'Yes'
  ELSE 'No' 
END as has_insurance,
SUM(CASE 
      WHEN patient_id % 2 = 0 Then 10
      ELSE 50 
    END) as cost_after_insurance
FROM admissions 
GROUP BY has_insurance;

/* Problem: Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name */
SELECT pr.province_name
FROM patients AS pa
  JOIN province_names AS pr ON pa.province_id = pr.province_id
GROUP BY pr.province_name
HAVING
  COUNT( CASE WHEN gender = 'M' THEN 1 END) > COUNT( CASE WHEN gender = 'F' THEN 1 END);

/* Problem: For each day display the total amount of admissions on that day. Display the amount changed from the previous date. */
SELECT 
  admission_date,
  COUNT(*) AS admission_day,
  COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY admission_date) AS admission_count_change
FROM admissions
GROUP BY admission_date;

/* Problem: We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year. */
SELECT 
  d.doctor_id,
  CONCAT(d.first_name, ' ', d.last_name) AS doctor_full_name,
  d.specialty,
  YEAR(a.admission_date) AS year,
  COUNT(*) AS total_admissions
FROM admissions a JOIN doctors d 
  ON a.attending_doctor_id = d.doctor_id
GROUP BY d.doctor_id, doctor_full_name, d.specialty, year;