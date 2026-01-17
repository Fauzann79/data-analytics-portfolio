# Manufacturing Quality & Defect Analysis (SQL)

## Overview
This project analyzes manufacturing production data to understand defect patterns and operational issues.
The analysis focuses on identifying problem areas related to product type, production shift, machine performance,
and machine downtime.

All analysis is performed using SQL.

---

## Business Context
The manufacturing process shows variations in product quality across shifts, machines, and product categories.
Management needs clearer insight into:
- Where defects are most frequent
- Which shifts and machines require attention
- Whether downtime impacts defect rates

The goal of this project is to support better operational and maintenance decisions.

---

## Tools Used
- SQL (MySQL)
- Relational database

---

## Dataset Description
The dataset contains daily production records, including:
- Product type
- Shift
- Machine ID
- Units produced
- Number of defects
- Downtime and maintenance hours
- Scrap rate

A duplicate table was created to ensure the original data remained unchanged during cleaning.

---

## Data Cleaning
The following steps were performed:
- Converted date fields into proper SQL `DATE` format
- Fixed data types for numerical columns
- Replaced missing or invalid defect values
- Checked null values across key operational columns

Cleaning queries are documented in `02_data_cleaning.sql`.

---

## Analysis Performed
Key areas of analysis include:
- Overall production and defect performance
- Defect rate comparison by product type
- Defect rate analysis by shift
- Machine-level defect contribution
- Relationship between downtime and defect rate

Exploratory queries can be found in `03_exploratory_analysis.sql`.

---

## Key Findings
- Certain shifts consistently show higher defect rates
- Machines with higher average downtime tend to have higher defect rates
- A small number of machines contribute disproportionately to total defects
- Some product types appear more sensitive to operational disruptions

---

## Recommendations
- Prioritize maintenance for machines with high downtime and defect rates
- Review operational conditions on high-defect shifts
- Apply tighter quality control for high-risk product categories
- Monitor machine–shift combinations with consistently poor performance

---

## Repository Structure
manufacturing-quality-analysis-sql/
├── README.md
├── sql/
│ ├── 01_data_preparation.sql
│ ├── 02_data_cleaning.sql
│ ├── 03_exploratory_analysis.sql
│ └── 04_business_insights.sql
└── dataset/
└── manufacturing.csv

---

## Notes
This project focuses on SQL-based analysis and insight generation.
Visualization and dashboard development are considered future improvements.
