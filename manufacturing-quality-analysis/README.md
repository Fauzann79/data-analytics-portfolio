# Manufacturing Quality & Defect Analysis (SQL)

## Overview
This project analyzes manufacturing production data to identify defect patterns and operational issues.
The analysis focuses on product types, production shifts, machine performance, and machine downtime.

All analysis in this project is performed using SQL.

---

## Business Context
Manufacturing operations show variations in product quality across shifts, machines, and product categories.
Management requires clearer insights into:
- Where defects occur most frequently
- Which shifts and machines require attention
- Whether machine downtime impacts defect rates

The goal of this analysis is to support data-driven operational and maintenance decisions.

---

## Tools Used
- SQL (MySQL)
- Relational Database

---

## Dataset Description
The dataset contains daily manufacturing production records, including:
- Product type
- Production shift
- Machine ID
- Units produced
- Number of defects
- Downtime and maintenance hours
- Scrap rate

A duplicate table was created to ensure the original dataset remained unchanged during the data cleaning process.

---

## Data Cleaning
The following data cleaning steps were performed:
- Converted date fields into proper SQL `DATE` format
- Standardized data types for numerical columns
- Handled missing and invalid defect values
- Checked for null values across key operational columns

All data cleaning queries are documented in `sql/02_data_cleaning.sql`.

---

## Analysis Performed
Key analyses include:
- Overall production and defect performance
- Defect rate comparison by product type
- Defect rate analysis by production shift
- Machine-level defect contribution
- Relationship between machine downtime and defect rate

Exploratory analysis queries can be found in `sql/03_exploratory_analysis.sql`.

---

## Sample Analysis Output

### Defect Rate by Production Shift and Machine
![Defect Rate by Shift](images/defect_machine_and_shift.png)

### Unit Produced
![Defects by Machine](images/unit_produced.png)

### Unit Type Produces
![Downtime vs Defect Rate](images/unit_type_produced.png)

---

## Key Findings
- Certain production shifts consistently show higher defect rates
- Machines with higher average downtime tend to produce more defects
- A small number of machines contribute disproportionately to total defects
- Some product types are more sensitive to operational disruptions

---

## Recommendations
- Prioritize preventive maintenance for machines with high downtime and defect rates
- Review operational conditions during high-defect production shifts
- Apply stricter quality control for high-risk product categories
- Monitor machine–shift combinations with consistently poor performance

---

## Repository Structure
manufacturing-quality-analysis-sql/
├── README.md
├── images/
│ ├── defect_by_shift.png
│ ├── defect_by_machine.png
│ └── downtime_vs_defect.png
├── sql/
│ ├── 01_data_preparation.sql
│ ├── 02_data_cleaning.sql
│ ├── 03_exploratory_analysis.sql
│ └── 04_business_insights.sql
└── dataset/
└── manufacturing.csv

---

