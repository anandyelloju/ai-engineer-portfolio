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