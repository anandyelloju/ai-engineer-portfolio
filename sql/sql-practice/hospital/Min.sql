-- Medium

/* Problem: Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni' */
SELECT
  (MAX(weight) - MIN(weight)) AS weight_delta
FROM patients
WHERE last_name = 'Maroni';

/* Problem: For each doctor, display their id, full name, and the first and last admission date they attended. */
SELECT 
  d.doctor_id AS id,
  CONCAT(d.first_name, ' ' ,d.last_name) AS full_name,
  Min(a.admission_date) AS first_admission_date,
  MAX(a.admission_date) AS last_admission_date
FROM admissions a JOIN doctors d 
  ON a.attending_doctor_id == d.doctor_id
GROUP BY attending_doctor_id;

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