-- 41. Models with more than one validation failure

SELECT model_id, COUNT(*) AS failed_count FROM validation_reports WHERE status = 'Rejected' GROUP BY model_id HAVING COUNT(*) > 1;

-- 42. Most common issues found in validation reports

SELECT issues_found, COUNT(*) AS occurrence FROM validation_reports GROUP BY issues_found ORDER BY occurrence DESC LIMIT 5;

-- 43. Latest model changes by each user

SELECT changed_by, MAX(changed_on) AS last_change FROM model_audit_log GROUP BY changed_by;

-- 44. Average number of models per owner

SELECT ROUND(COUNT(*) / (SELECT COUNT(*) FROM model_owners), 2) AS avg_models_per_owner FROM models;

-- 45. Models with inconsistent status vs review

SELECT model_name, status, next_review_due FROM models WHERE status = 'In Use' AND next_review_due IS NULL;

-- 46. Days since last change per model

SELECT model_id, DATEDIFF(CURDATE(), MAX(changed_on)) AS days_since_last_change FROM model_audit_log GROUP BY model_id;

-- 47. Most flagged model in each department

SELECT m.department, m.model_name, COUNT(r.flag_id) AS total_flags FROM models m JOIN risk_flags r ON m.model_id = r.model_id GROUP BY m.model_id ORDER BY department, total_flags DESC;

-- 48. Models added but never reviewed or validated

SELECT model_name FROM models WHERE model_id NOT IN (SELECT model_id FROM validation_reports) AND model_id NOT IN (SELECT model_id FROM review_cycles);

-- 49. Most recently added model per owner

SELECT owner_id, model_name, MAX(last_review_date) AS last_review FROM models GROUP BY owner_id;

-- 50. Summary of model states

SELECT SUM(status = 'In Use') AS active, SUM(status = 'Retired') AS retired, SUM(status = 'In Development') AS in_dev FROM models;