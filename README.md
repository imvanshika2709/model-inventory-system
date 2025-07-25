
# Risk Analysis using SQL & Tableau

This project focuses on performing **comprehensive risk analysis** of model review processes using **SQL queries**. The analysis includes lifecycle KPIs, governance summaries, and trend monitoring across model inventories. The project concludes with a  **Tableau dashboard** built on SQL outputs to support visualization.

---

## 🧠 About the Project

This project is aimed at extracting insights from a model governance system. The core focus lies in using **structured SQL queries** to uncover:

- Review timelines across models and departments
- Risk level distribution
- Frequency of flags based on severity
- Departmental performance in governance
- Temporal trends in review activities

The results of the SQL queries are further transformed into datasets for visualization in Tableau.

---

## 🗂️ Dataset Overview

The raw data simulates a **model governance system** and is structured into the following key fields:

| Column Name       | Description                                         |
|-------------------|-----------------------------------------------------|
| `model_id`        | Unique identifier for each model                    |
| `model_name`      | Human-readable name of the model                    |
| `risk_level`      | Categorical risk classification: Low, Medium, High  |
| `department`      | Department owning or using the model                |
| `review_start`    | Timestamp when the review started                   |
| `review_end`      | Timestamp when the review ended                     |
| `duration_days`   | Review duration in days (calculated)                |
| `severity`        | Severity (e.g., high, medium, low)                  |
| `flag_count`      | Number of flags triggered during review             |

---

## 🔍 Focus on SQL: 50+ Query Collection

The project involves **over 50 structured SQL queries**, grouped by functionality. These queries are designed for **data extraction, aggregation, transformation, and trend analysis**.

| Category                          | Description                                                                 |
|----------------------------------|-----------------------------------------------------------------------------|
| `foundational_model_insights.sql`     | Base queries to fetch models, durations, departments, risk levels         |
| `aggregated_model_insights.sql`       | Aggregations by model, department, and risk category                      |
| `governance_and_audit_summary.sql`    | Queries to summarize review activity, governance coverage                 |
| `lifecycle_kpi_queries.sql`           | KPI computation: review frequency, duration averages, compliance metrics |
| `monitoring_and_trend_analysis.sql`   | Time series queries: trends in flags, severity patterns, performance      |
| `procedures.sql`                      | Stored procedures for automated batch processing                          |
| `schema.sql`                          | Defines the schema and DDL for table creation                             |

Each query is written to be **modular, reusable, and aligned with enterprise reporting needs**.

---

## 🧾 SQL Outputs

Each SQL script generates tabular results which are exported into `.xlsx` format and can be loaded into Tableau or any BI tool. Example outputs:

- `avg_review_duration_by_model.xlsx`
- `department_wise_risk.xlsx`
- `risk_flags_by_severity.xlsx`
- `model_count_by_risk_level.xlsx`
- `trend_analysis.xlsx`

---

## Tableau Dashboards

While this project is SQL-heavy, selected outputs are visualized in Tableau Public for stakeholders. The dashboards use cleaned SQL results and include:

- **Bar Chart**: Average Review Duration by Model
- **Stacked Bar Chart**: Risk Level by Department
- **Pie Chart**: Severity-based Flag Distribution
- **Trend Line**: Flag volumes over time (if applicable)

---

## 🛠️ Tools & Technologies

- **SQL**: MySQL / PostgreSQL
- **VS Code**: SQL Scripting & Execution
- **Excel / CSV**: Data export for BI tools
- **Tableau Public**: Dashboards for visualization
- **Git**: Version control of query evolution

---

## 📁 Project Structure

```bash
model-inventory-system/
├── aggregated_model_insights.sql
├── data.sql
├── foundational_model_insights.sql
├── governance_and_audit_summary.sql
├── lifecycle_kpi_queries.sql
├── monitoring_and_trend_analysis.sql
├── procedures.sql
├── schema.sql
├── README.md
└── dashboards/
    └── data/
        ├── avg_review_duration_by_model.xlsx
        ├── department_wise_risk.xlsx
        ├── model_count_by_risk_level.xlsx
        ├── risk_flags_by_severity.xlsx
        └── Trend_analysis.xlsx
```

---

## 🧪 How to Use

1. Clone or download the repository.
2. Create the database schema using `schema.sql`.
3. Populate data using `data.sql` (optional dummy data).
4. Execute SQL files grouped by function to generate insights.
5. Export outputs to `.xlsx` or `.csv` for dashboard use.
6. (Optional) Open Tableau and import the outputs for visualization.

---

## 📸 Sample Visuals

- `bar_chart_avg_duration.png`
- `stacked_bar_department.png`
- `severity_flag_pie.png`

---

## 👩‍💻 Author

- **Name**: *Vanshika Chaudhary*
- **Email**: *vanshika.chaudharywork@gmail.com*
- **GitHub**: *https://github.com/imvanshika2709*

---

## 📄 License

This project is intended for educational and portfolio use. Attribution required for reuse.
