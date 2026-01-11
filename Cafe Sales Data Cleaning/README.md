# Cafe Sales Data Cleaning (SQL)

## 📌 Project Overview
This project focuses on cleaning and standardizing cafe sales transaction data using SQL.
The dataset contains missing values, inconsistent labels, and invalid entries that require
systematic data cleaning before analysis.

## 🔍 Problems Identified
- Missing and invalid item names (NULL, '', UNKNOWN, ERROR)
- Inconsistent payment method and location values
- Invalid or inconsistent transaction date formats
- Duplicate and missing transaction IDs

## 🛠 Tools
- MySQL
- SQL (CTE, CASE WHEN, aggregation)

## 🧹 Data Cleaning Steps
1. Schema standardization (column renaming & data types)
2. Data quality checks (NULLs, duplicates, invalid values)
3. Item name imputation based on price
4. Standardization of payment method and location
5. Transaction date normalization

## ⚠️ Important Notes
- Missing payment methods (~32%) were not imputed due to lack of consistent patterns.
- These values were categorized as 'Unknown' to preserve data integrity.

## 📊 Result
The cleaned dataset is ready for Exploratory Data Analysis (EDA) and further business insights.

## 📁 Repository Structure
- `/data/raw` : original dataset
- `/sql` : SQL scripts for exploration, quality checks, and cleaning
