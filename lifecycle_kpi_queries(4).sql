-- 31. Models reviewed more than once
SELECT model_id, COUNT(*) AS review_count
FROM review_cycles
GROUP BY model_id
HAVING COUNT(*) > 1;

--32.  Models flagged but never validated
SELECT m.model_id, m.model_name
FROM models m
WHERE m.model_id IN (SELECT model_id FROM risk_flags)
  AND m.model_id NOT IN (SELECT model_id FROM validation_reports);

--33.Average time between review cycles per model
SELECT model_id,
       CONCAT(ROUND(AVG(DATEDIFF(end_date, start_date))), ' days') AS avg_review_duration
FROM review_cycles
GROUP BY model_id;

--34.op 3 departments by number of ‘High Risk’ models
SELECT department, COUNT(*) AS high_risk_count
FROM models
WHERE risk_level = 'High'
GROUP BY department
ORDER BY high_risk_count DESC
LIMIT 3;

--35.Models with frequent flag closures (>= 3 closed flags)
SELECT model_id, COUNT(*) AS closed_flags
FROM risk_flags
WHERE status = 'Closed'
GROUP BY model_id
HAVING COUNT(*) >= 3;

--36.Percentage of models per status (In Use, Retired, In Development)
SELECT status,
       COUNT(*) * 100.0 / (SELECT COUNT(*) FROM models) AS percentage
FROM models
GROUP BY status;

--37.Review compliance: % of models reviewed in last 12 months
SELECT
  (SELECT COUNT(DISTINCT model_id)
   FROM review_cycles
   WHERE end_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)) * 100.0
  / (SELECT COUNT(*) FROM models) AS compliance_percent;

--38.Flag resolution time per model (avg)
SELECT model_id,
       AVG(DATEDIFF(closed_on, raised_on)) AS avg_resolution_days
FROM risk_flags
WHERE status = 'Closed'
GROUP BY model_id;

--39. Recent validation failure summary
SELECT model_id, validation_date, issues_found
FROM validation_reports
WHERE status = 'Rejected'
ORDER BY validation_date DESC
LIMIT 10;

--40. Models owned bt different departments
SELECT owner_id, COUNT(DISTINCT department) AS dept_count
FROM models
GROUP BY owner_id
HAVING COUNT(DISTINCT department) > 1;

