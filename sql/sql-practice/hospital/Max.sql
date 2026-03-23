-- Easy

/* Problem: Show the first_name, last_name, and height of the patient with the greatest height. */
SELECT
  first_name,
  last_name,
  MAX(height) AS height
FROM patients;

-- Medium

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
