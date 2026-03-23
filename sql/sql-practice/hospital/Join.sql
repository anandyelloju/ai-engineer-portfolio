-- Easy

/* Problem: Show first name, last name, and the full province name of each patient.
Example: 'Ontario' instead of 'ON' */
SELECT 
  p.first_name, 
  p.last_name, 
  pn.province_name 
FROM patients AS p JOIN province_names AS pn 
    ON p.province_id = pn.province_id;

-- Medium

/* Problem: Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
Primary diagnosis is stored in the admissions table. */
SELECT
  patients.patient_id,
  first_name,
  last_name
FROM patients JOIN admissions 
  ON admissions.patient_id = patients.patient_id
WHERE diagnosis = 'Dementia';

/* Problem: Show first_name, last_name, and the total number of admissions attended for each doctor.
Every admission has been attended by a doctor. */
SELECT
  first_name,
  last_name,
  COUNT(*) AS admissions_total
FROM admissions a JOIN doctors ph 
  ON ph.doctor_id = a.attending_doctor_id
GROUP BY attending_doctor_id;

/* Problem: For each doctor, display their id, full name, and the first and last admission date they attended. */
SELECT
  doctor_id,
  first_name || ' ' || last_name AS full_name,
  min(admission_date) AS first_admission_date,
  max(admission_date) AS last_admission_date
FROM admissions a JOIN doctors ph 
  ON a.attending_doctor_id = ph.doctor_id
GROUP BY doctor_id;

/* Problem: Display the total amount of patients for each province. Order by descending. */
SELECT
  province_name,
  COUNT(*) AS patient_count
FROM patients pa JOIN province_names pr 
  ON pr.province_id = pa.province_id
GROUP BY pr.province_id
ORDER BY patient_count DESC;

/* Problem: For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem. */
SELECT 
  p.first_name || ' ' || p.last_name AS patient_name,
  a.diagnosis,
  d.first_name || ' ' || d.last_name AS doctor_name
FROM patients p 
  JOIN admissions a ON p.patient_id = a.patient_id
  JOIN doctors d ON a.attending_doctor_id = d.doctor_id;

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