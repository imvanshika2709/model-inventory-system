-- 21. Models overdue for reviews
SELECT model_id, next_review_due
from models
where next_review_due< CURDATE();

-- 22. Upcoming reviews in next 30 days
SELECT model_name, next_review_due
FROM models
WHERE next_review_due BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);

--23. Models with performance drop this month vs last month
SELECT model_id,
       MAX(CASE WHEN MONTH(recorded_on) = MONTH(CURDATE()) THEN performance_score END) AS current_score,
       MAX(CASE WHEN MONTH(recorded_on) = MONTH(CURDATE()) - 1 THEN performance_score END) AS last_month_score
FROM model_performance
WHERE recorded_on >= DATE_SUB(CURDATE(), INTERVAL 2 MONTH)
GROUP BY model_id
HAVING current_score < last_month_score;

-- 24.Recently updated fields in audit log
SELECT model_id, changed_field, old_value, new_value, changed_on
FROM model_audit_log
ORDER BY changed_on DESC
LIMIT 20

--25. Models updated by a pecific user
SELECT model_id, changed_field, changed_on
FROM model_audit_log
WHERE changed_by = 'vanshika.kumar@example.com';

--26. Models flagged more than twice
SELECT model_id, COUNT(*) AS flag_count
FROM risk_flags
GROUP BY model_id
HAVING COUNT(*) > 2;

--27. Validation report stats per department
SELECT m.department, COUNT(r.report_id) AS total_reports
FROM models m
JOIN validation_reports r ON m.model_id = r.model_id
GROUP BY m.department;

--28. Model owners with most active models
SELECT o.owner_name, COUNT(*) AS active_models
FROM models m
JOIN model_owners o ON m.owner_id = o.owner_id
WHERE m.status = 'In Use'
GROUP BY o.owner_name
ORDER BY active_models DESC;

--29. Monthly trend of risk flags
SELECT MONTH(raised_on) AS month, COUNT(*) AS total_flags
FROM risk_flags
GROUP BY MONTH(raised_on)
ORDER BY month;

--30. Model performance distribution
SELECT
  CASE
    WHEN performance_score >= 0.9 THEN 'Excellent'
    WHEN performance_score >= 0.75 THEN 'Good'
    WHEN performance_score >= 0.5 THEN 'Moderate'
    ELSE 'Poor'
  END AS performance_band,
  COUNT(*) AS model_count
FROM model_performance
GROUP BY performance_band;



