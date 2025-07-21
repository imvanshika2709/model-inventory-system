
DELIMITER $$
-- 1. Procedure: insert_validation_report

-- Purpose: Add validation report only if model exists and is not retired
CREATE PROCEDURE insert_validation_report (
    IN p_model_id INT,
    IN p_validation_date DATE,
    IN p_validator_name VARCHAR(100),
    IN p_issues_found TEXT,
    IN p_status VARCHAR(20)
)
BEGIN
    DECLARE model_status VARCHAR(20);

    -- Check if model exists and fetch status
    SELECT status INTO model_status
    FROM models
    WHERE model_id = p_model_id;

    -- Handle missing or retired models
    IF model_status IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Model not found.';
    ELSEIF model_status = 'Retired' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot validate a retired model.';
    ELSE
        -- Insert the validation record
        INSERT INTO validation_reports (model_id, validation_date, validator_name, issues_found, status)
        VALUES (p_model_id, p_validation_date, p_validator_name, p_issues_found, p_status);
    END IF;
END $$

-- 2. Procedure: retire_models_due_for_review

-- Purpose: Automatically retire models that haven’t been reviewed in over a year
CREATE PROCEDURE retire_models_due_for_review ()
BEGIN
    UPDATE models
    SET status = 'Retired'
    WHERE next_review_due < DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
      AND status = 'In Use';
END $$

-- Reset delimiter back to normal
DELIMITER ;

-- To call procedure:

--CALL insert_validation_report(1, '2025-07-21', 'QA Team', 'drift detected', 'Action Required');
--CALL retire_models_due_for_review();
