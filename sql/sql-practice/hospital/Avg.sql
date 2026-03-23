-- Medium

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