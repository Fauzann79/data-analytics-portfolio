# Student Performance Data Cleaning (Excel)

## 📌 Project Overview

This project focuses on **data cleaning and data quality improvement** for a Student Performance dataset using **Microsoft Excel**. The objective is to prepare the dataset for reliable analysis (e.g., Pivot Table analysis) by identifying and resolving common real-world data issues.

This project demonstrates practical data cleaning skills commonly required in data analyst roles, without applying modeling or advanced analytics.

---

## 🧩 Dataset Description

The dataset contains student-related information, including:

* StudentID
* Name
* Gender
* AttendanceRate
* StudyHours
* PreviousGrade
* FinalGrade
* ParentalSupport
* OnlineClassesTaken

The raw data contains multiple data quality issues such as missing values, invalid ranges, and inconsistent identifiers.

---

## 🚨 Data Quality Issues Identified

| Column             | Issue Type                            | Count | Resolution                                   |
| ------------------ | ------------------------------------- | ----- | -------------------------------------------- |
| StudentID          | Duplicate IDs (different individuals) | Many  | Regenerated unique sequential IDs            |
| Name               | Missing values                        | 25    | Left as missing (non-critical)               |
| AttendanceRate     | Missing values                        | 40    | Imputed using median                         |
| StudyHours         | Missing values                        | 24    | Imputed using mean                           |
| StudyHours         | Invalid negative values (-5)          | 1     | Treated as missing value                     |
| PreviousGrade      | Missing values                        | 33    | Imputed using group-based mean by FinalGrade |
| FinalGrade         | Missing values                        | 39    | Records removed (target variable)            |
| Attendance (%)     | Values > 100                          | 10    | Capped at 100                                |
| ParentalSupport    | Missing values                        | 22    | Imputed using mode                           |
| OnlineClassesTaken | Missing values                        | 25    | Left as missing                              |

---

## 🔧 Data Cleaning Decisions & Justification

* **Median imputation** was applied to AttendanceRate due to its robustness against outliers.
* **Mean imputation** was used for StudyHours after removing invalid negative values.
* **Negative values** (e.g., -5 StudyHours) were considered invalid and treated as missing.
* **Attendance percentages exceeding 100%** were capped at logical maximum values.
* **Duplicate Student IDs** were regenerated since identical IDs represented different individuals.
* **FinalGrade missing records** were removed because FinalGrade is the primary analysis target.

---

## 🛠 Tools Used

* Microsoft Excel

  * Formulas (IF, AVERAGE, MEDIAN, AVERAGEIF)
  * Conditional Formatting
  * Pivot Table (for validation)

---

## 📊 Output

The cleaned dataset is ready for:

* Pivot Table analysis
* Descriptive statistics
* Educational performance insights

No predictive modeling was applied in this project.

---

## 📝 Key Takeaway

> *This project demonstrates structured data cleaning and decision-making processes to improve data reliability and analytical readiness using Microsoft Excel.*

---

## 📁 Repository Structure

```
/Student-Performance-Data-Cleaning
│── raw_data.xlsx
│── cleaned_data.xlsx
│── README.md
```

---

## 👤 Author

**Fauzan**
Data Cleaning & Analysis (Excel)
