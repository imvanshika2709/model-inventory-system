-- 11. Number of models by risk level
SELECT risk_level, COUNT(*) AS total_models
FROM models
GROUP BY risk_level;

--12. Average performance score per model
SELECT model_id, AVG(performance_score) AS avg_score
FROM model_performance
GROUP BY model_id;

--13. Models with average performance < 0.70
SELECT model_id, AVG(performance_score) AS avg_score
FROM model_performance
GROUP BY model_id
HAVING AVG(performance_score) < 0.70;

-- 14. Owners who manage more than 3 models
SELECT owner_id, COUNT(*) AS model_count
FROM models
GROUP BY owner_id
HAVING COUNT(*) > 3;

--15. Most recent validation report per model
SELECT *
FROM validation_reports v
WHERE validation_date = (
    SELECT MAX(validation_date)
    FROM validation_reports
    WHERE model_id = v.model_id
);

--16. Models with open high-severity risk flags
SELECT DISTINCT m.model_name, r.severity
FROM models m
JOIN risk_flags r ON m.model_id = r.model_id
WHERE r.status = 'Open' AND r.severity = 'High';

--17. Top 5 models with the most risk flags
SELECT model_id, COUNT(*) AS total_flags
FROM risk_flags
GROUP BY model_id
ORDER BY total_flags DESC
LIMIT 5;

--18. Departments with more than 10 models
SELECT department, COUNT(*) AS model_count
FROM models
GROUP BY department
HAVING COUNT(*) > 10;

--19. Models that have never been validated
SELECT model_name
FROM models
WHERE model_id NOT IN (
    SELECT DISTINCT model_id
    FROM validation_reports
);

--20. Model with the lowest average performance
SELECT model_id, AVG(performance_score) AS avg_score
FROM model_performance
GROUP BY model_id
ORDER BY avg_score ASC
LIMIT 1;