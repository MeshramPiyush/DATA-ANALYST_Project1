```markdown
# DATA-ANALYST_Project1: Healthcare Risk Stratification Web Application

An end-to-end healthcare data analytics and risk stratification project designed to evaluate patient outcomes, identify high-risk clinical cohorts, monitor diagnostic lab values, and analyze treatment costs using SQL, Python, and Excel.

**Author:** Piyush Meshram  
**Project Track:** Healthcare Data Analytics  

---

## 📌 Project Overview

Clinical risk stratification identifies patient populations prone to complications, prolonged hospitalization, and elevated medical expenses. This project models and analyzes hospital records across four core relational dimensions: patient demographics, clinical diagnoses, laboratory test results, and discharge outcomes.

The project demonstrates:
* Relational database design and foreign key integrity in **SQL Server**.
* Clinical metric reporting and risk cohort identification via **SQL queries**.
* Exploratory data analysis, statistical breakdowns, and distribution insights via **Python (Pandas, Matplotlib/Seaborn)**.
* Tabular validations and pivot aggregations in **Excel**.

---

## 🛠️ Tech Stack & Tools

* **Database Engine:** Microsoft SQL Server (SSMS)
* **Data Processing & Analysis:** Python, Pandas, NumPy
* **Data Visualization:** Matplotlib, Seaborn
* **Spreadsheet Analysis:** Microsoft Excel (Pivot tables, conditional formatting, summary metrics)
* **Version Control:** Git, GitHub

---

## 📂 Repository Structure

```text
DATA-ANALYST_Project1/
│
├── data/
│   ├── Patients.csv              # Patient demographics, admission/discharge, cost, IDs
│   ├── Diagnosis.csv             # Diagnostic lookup (DiagnosisID, DiagnosisName)
│   ├── Outcomes.csv              # Discharge status lookup (OutcomeID, OutcomeName)
│   └── labs.csv                  # Diagnostic lab tests, numeric results, normal ranges
│
├── sql/
│   └── Healtcare_database.sql    # DDL table creation, foreign keys & analytical queries
│
├── notebooks/
│   └── healthcare_analysis.ipynb # Jupyter Notebook: EDA, risk stratification & charts
│
├── excel/
│   └── healthcare_summary.xlsx   # Pivot summaries and exploratory cross-tabulations
│
└── README.md                     # Comprehensive project documentation

```

---

## 🗄️ Database Architecture & Schema

The relational schema implements referential integrity connecting patient visits with diagnoses, outcomes, and repeated lab tests:

```text
       [ Diagnosis ]                 [ Outcomes ]
             │                            │
             │ (1:N)                      │ (1:N)
             ▼                            ▼
      ┌──────────────────────────────────────────┐
      │                 Patients                 │
      │──────────────────────────────────────────│
      │ PatientId (PK)                           │
      │ Name, Age, Gender                        │
      │ DiagnosisId (FK) ──► Diagnosis           │
      │ AdmissionDate, DischargeDate             │
      │ OutcomeId (FK)   ──► Outcomes            │
      │ TreatmentCost                            │
      └──────────────────────────────────────────┘
                           │ (1:N)
                           ▼
                     ┌───────────┐
                     │   Labs    │
                     │───────────│
                     │ LabId(PK) │
                     │ PatientId │ (FK ──► Patients)
                     │ TestName  │
                     │ Result    │
                     │ NormalRng │
                     └───────────┘

```

### Table Definitions

* **`Diagnosis`**: `DiagnosisId` (PK, INT), `DiagnosisName` (VARCHAR(255))


* **`Outcomes`**: `OutcomeId` (PK, INT), `OutcomeName` (VARCHAR(255))


* **`Patients`**: `PatientId` (PK, INT), `Name` (VARCHAR(255)), `Age` (INT), `Gender` (CHAR(1)), `DiagnosisId` (FK, INT), `AdmissionDate` (DATE), `DischargeDate` (DATE), `OutcomeId` (FK, INT), `TreatmentCost` (DECIMAL(10,2))


* **`Labs`**: `LabId` (PK, INT), `PatientId` (FK, INT), `TestName` (VARCHAR(255)), `Result` (DECIMAL(10,2)), `NormalRange` (VARCHAR(255))



---

## 🔍 Key SQL Queries & Analytics

The analysis pipeline in `Healtcare_database.sql` answers vital clinical and administrative questions:

1. **Detailed Patient Lab History:** Joins `Patients`, `Diagnosis`, `Outcomes`, and `Labs` to generate longitudinal clinical profiles.


2. **Average Lab Results by Diagnosis:** Aggregates diagnostic ranges across clinical categories (e.g., Blood Sugar, Cholesterol, Hemoglobin, Blood Pressure).


3. **Abnormal Lab Result Counts:** Identifies patients exhibiting multiple high-risk lab flags:


* Cholesterol $> 200\text{ mg/dL}$

* Blood Sugar $> 120\text{ mg/dL}$

* Hemoglobin $< 13\text{ g/dL}$



4. **Highest Treatment Cost by Diagnosis:** Ranks diagnosis categories by total financial footprint.


5. **High-Risk Vulnerable Cohorts:** Segments geriatric patients ($\text{Age} > 65$) presenting unrecovered or complicated discharge statuses.


6. **Outcome Distributions by Diagnosis:** Quantifies recovery vs. complication/readmission rates across conditions.



---

## 🚀 Setup & Execution Guide

### 1. Database Setup in SSMS

1. Open SSMS and connect to your SQL Server instance.
2. Create the database:
```sql
CREATE DATABASE Healthcare;
GO
USE Healthcare;
GO

```


3. Run the DDL scripts to create parent tables (`Diagnosis`, `Outcomes`), child table (`Patients`), and grand-child table (`Labs`).


4. Import the four CSV files in sequence:

$$\text{Diagnosis.csv, Outcomes.csv} \longrightarrow \text{Patients.csv} \longrightarrow \text{labs.csv}$$


5. Execute the analytical queries in `Healtcare_database.sql`.



### 2. Python Environment & Jupyter Notebook

1. Clone the repository:
```bash
git clone [https://github.com/MeshramPiyush/DATA-ANALYST_Project1.git](https://github.com/MeshramPiyush/DATA-ANALYST_Project1.git)
cd DATA-ANALYST_Project1

```


2. Install dependencies:
```bash
pip install pandas numpy matplotlib seaborn jupyter

```


3. Launch the notebook:
```bash
jupyter notebook

```


4. Run `notebooks/healthcare_analysis.ipynb` to view statistical charts, distributions, and correlation matrices.

---

## 📌 Next Steps & Milestones

* Build an interactive Streamlit or Power BI dashboard for live clinical exploration.
* Implement predictive risk stratification using Scikit-Learn to flag high-probability readmission cases upon admission.

```

```
