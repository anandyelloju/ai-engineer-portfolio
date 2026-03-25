-- Medium

/* Problem: Display patient's full name,
height in the units feet rounded to 1 decimal,
weight in the unit pounds rounded to 0 decimals,
birth_date,
gender non abbreviated.

Convert CM to feet by dividing by 30.48.
Convert KG to pounds by multiplying by 2.205. */
SELECT
    CONCAT(first_name, ' ', last_name) AS 'patient_name', 
    ROUND(height / 30.48, 1) AS 'height "Feet"', 
    ROUND(weight * 2.205, 0) AS 'weight "Pounds"', 
    birth_date,
    CASE
	    WHEN gender = 'M' THEN 'MALE' 
        ELSE 'FEMALE' 
    END AS 'gender_type'
FROM patients

-- Hard

/* Problem: Show patient_id, weight, height, isObese from the patients table.
Display isObese as a boolean 0 or 1.
Obese is defined as weight(kg)/(height(m)2) >= 30.
weight is in units kg.
height is in units cm. */
SELECT
    patient_id,
    weight,
    height,
    CASE
        WHEN (weight / POWER(height / 100.0, 2)) >= 30 THEN 1
        ELSE 0
    END AS isObese
FROM patients;

/* Problem: Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.
Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group. */
SELECT
    CASE
        WHEN patient_id % 2 == 0 THEN 'Yes'
        ELSE 'No'
    END AS has_insurance,
    SUM(CASE
            WHEN patient_id % 2 == 0 THEN 10
            ELSE 50
        END) AS cost_after_insurance
FROM admissions
GROUP BY has_insurance;

/* Problem: Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name */
SELECT 
  pr.province_name
FROM patients AS pa JOIN province_names AS pr 
  ON pa.province_id = pr.province_id
GROUP BY pr.province_name
HAVING COUNT( CASE WHEN gender = 'M' THEN 1 END) > COUNT( CASE WHEN gender = 'F' THEN 1 END);

/* Problem: Sort the province names in ascending order in such a way that the province 'Ontario' is always on top. */
SELECT 
  province_name
FROM province_names
ORDER BY
  CASE
    WHEN province_name = 'Ontario' THEN 1
    ELSE province_name
  END;
