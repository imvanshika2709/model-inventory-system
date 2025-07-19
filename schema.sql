USE model_inventory;
-- 1. model_owners
CREATE TABLE model_owners (
    owner_id INT PRIMARY KEY AUTO_INCREMENT,
    owner_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    team VARCHAR(100)
);

-- 2. models
CREATE TABLE models (
    model_id INT PRIMARY KEY AUTO_INCREMENT,
    model_name VARCHAR(100) NOT NULL,
    model_type VARCHAR(50) NOT NULL,
    owner_id INT NOT NULL,
    department VARCHAR(100),
    risk_level VARCHAR(10) CHECK (risk_level IN ('Low', 'Medium', 'High')),
    status VARCHAR(20) CHECK (status IN ('In Use', 'Retired', 'In Development')),
    last_review_date DATE,
    next_review_due DATE,
    FOREIGN KEY (owner_id) REFERENCES model_owners(owner_id)
);

-- 3. validation_reports
CREATE TABLE validation_reports (
    report_id INT PRIMARY KEY AUTO_INCREMENT,
    model_id INT NOT NULL,
    validation_date DATE,
    validator_name VARCHAR(100),
    issues_found TEXT,
    status VARCHAR(20) CHECK (status IN ('Approved', 'Action Required', 'Rejected')),
    FOREIGN KEY (model_id) REFERENCES models(model_id)
);

-- 4. risk_flags
CREATE TABLE risk_flags (
    flag_id INT PRIMARY KEY AUTO_INCREMENT,
    model_id INT NOT NULL,
    raised_on DATE,
    flag_type VARCHAR(50),
    severity VARCHAR(10) CHECK (severity IN ('Low', 'Medium', 'High')),
    status VARCHAR(10) CHECK (status IN ('Open', 'Closed')),
    closed_on DATE,
    FOREIGN KEY (model_id) REFERENCES models(model_id)
);

-- 5. review_cycles
CREATE TABLE review_cycles (
    cycle_id INT PRIMARY KEY AUTO_INCREMENT,
    model_id INT NOT NULL,
    start_date DATE,
    end_date DATE,
    outcome VARCHAR(10) CHECK (outcome IN ('Passed', 'Failed', 'Deferred')),
    FOREIGN KEY (model_id) REFERENCES models(model_id)
);

-- 6. model_audit_log – for tracking changes
CREATE TABLE model_audit_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    model_id INT NOT NULL,
    changed_field VARCHAR(100),
    old_value TEXT,
    new_value TEXT,
    changed_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    changed_by VARCHAR(100),
    FOREIGN KEY (model_id) REFERENCES models(model_id)
);

-- 7. model_performance – for storing performance scores
CREATE TABLE model_performance (
    performance_id INT PRIMARY KEY AUTO_INCREMENT,
    model_id INT NOT NULL,
    recorded_on DATE,
    performance_score FLOAT,
    notes TEXT,
    FOREIGN KEY (model_id) REFERENCES models(model_id)
);
