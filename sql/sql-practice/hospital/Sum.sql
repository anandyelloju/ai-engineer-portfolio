-- Hard

/* Problem: Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.
Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group. */
SELECT 
  CASE 
    WHEN patient_id % 2 = 0 THEN 'Yes' 
    ELSE 'No' END AS has_insurance,
  SUM(CASE 
        WHEN patient_id % 2 = 0 THEN 10 
        ELSE 50 
  END) AS admission_total
FROM admissions
GROUP BY has_insurance;