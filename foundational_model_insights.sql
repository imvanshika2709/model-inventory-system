-- Query 1: See all models
SELECT * FROM models;

-- Query 2: List all model owners
SELECT * FROM model_owners;

-- Query 3: Check all models with their owners
SELECT m.model_name, o.owner_name, o.team
FROM models m
JOIN model_owners o ON m.owner_id = o.owner_id;

-- Query 4: Count models in use
SELECT COUNT(*) AS active_models
FROM models
WHERE status = 'In Use';

-- Query 5: List models with high risk
SELECT model_name, risk_level
FROM models
WHERE risk_level = 'High';

-- Query 6: View all open risk flags
SELECT * FROM risk_flags
WHERE status = 'Open';

-- Query 7: Show models with open flags
SELECT m.model_name, r.flag_type, r.severity
FROM models m
JOIN risk_flags r ON m.model_id = r.model_id
WHERE r.status = 'Open';

-- Query 8: Validation reports marked ‘Action Required’
SELECT model_id, validator_name, issues_found
FROM validation_reports
WHERE status = 'Action Required';

-- Query 9: Average performance score per model
SELECT model_id, ROUND(AVG(performance_score),3) AS avg_score
FROM model_performance
GROUP BY model_id;

-- Query 10: Models with no performance record
SELECT model_name
FROM models
WHERE model_id NOT IN (
    SELECT DISTINCT model_id FROM model_performance
);
