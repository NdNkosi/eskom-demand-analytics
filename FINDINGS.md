# Eskom Power System Analytics — Key Findings
**Financial Year 2024/25 | Author: Ndumiso Nkosi**

---

## 1. Project Overview
This project delivers an end-to-end analytics pipeline on Eskom's national power system dataset covering April 2024 to March 2025. The pipeline spans data engineering, feature engineering, machine learning model development, REST API deployment on AWS, and a 5-page interactive Power BI dashboard.

**Tech Stack:** Python, PostgreSQL, AWS (S3, RDS, EC2), FastAPI, Scikit-learn, XGBoost, Power BI

---

## 2. Dataset Summary

| Attribute | Detail |
|---|---|
| Source | Eskom national power system dataset |
| Period | April 2024 — March 2025 (Financial Year 2024/25) |
| Rows | 43,824 half-hourly records |
| Key columns | actual_demand, forecast_demand, imports, exports, nuclear, pump_storage, capacity |
| Engineered features | stress_index, forecast_error, import_ratio, lag features (1h, 24h, 168h) |

---

## 3. Power BI Dashboard Findings

### 3.1 Weekly Peak Demand
- Peak actual demand reached approximately **31,500 MW** during June/July 2024, consistent with South Africa's winter heating load
- Demand declined steadily through summer, reaching a low of approximately **24,000 MW** in January 2025 during the holiday period
- Actual and forecast demand tracked closely throughout the year, indicating reasonable Eskom planning accuracy overall

### 3.2 Grid Stress Index
- The grid stress index (actual demand / installed capacity) peaked at **0.68** during June/July 2024
- The index dropped to a low of **0.49** in January 2025, reflecting the summer demand trough
- The stress index remained below the critical threshold of **0.85** throughout the entire financial year, suggesting the end of severe loadshedding conditions that characterised prior years

### 3.3 System Hourly Demand
- Hourly demand follows a consistent daily wave pattern with morning peaks around **07:00–09:00** and evening peaks around **18:00–20:00**
- Overnight troughs occur between **03:00–05:00**, dropping to approximately **18,000 MW**
- Weekend demand is noticeably lower than weekday demand, reflecting reduced industrial and commercial activity

### 3.4 Weekly Imports vs Actual Demand
- Cross-border electricity imports peaked at approximately **1,600 MW**, representing only **~5% of total demand**
- Import levels were volatile week-to-week, suggesting opportunistic rather than structural dependency on neighbouring countries
- South Africa maintained a relatively self-sufficient grid throughout 2024/25

### 3.5 Weekly Forecast Error
- The largest forecast error occurred in **June 2024** at approximately **+700 MW**, meaning Eskom significantly underestimated winter peak demand
- Negative errors (overestimation) were observed in April 2024 and August 2024, each reaching approximately **-400 MW**
- Forecast accuracy improved in the second half of the financial year (January–March 2025), with errors consistently below **±200 MW**

---

## 4. Machine Learning Results

Three models were trained to predict hourly actual demand using time-based and lag features:

| Model | MAE (MW) | RMSE (MW) |
|---|---|---|
| Linear Regression | 131.96 | 171.07 |
| XGBoost | 166.96 | 248.41 |
| **Random Forest** | **128.54** | **167.97** |

### Key Takeaways
- **Random Forest** achieved the best performance with an MAE of **128.54 MW** — equivalent to less than **0.5% error** on typical demand levels of ~27,000 MW
- Linear Regression outperformed XGBoost, confirming that demand follows strong **linear temporal patterns** — the previous hour's demand is the dominant predictor
- The most important features were **lag_1h, lag_24h and lag_168h**, confirming that recent demand history is more predictive than calendar features like month alone
- The trained Random Forest model is deployed as a **live REST API on AWS EC2**, accessible at `http://13.245.229.94:8000`

---

## 5. AWS Infrastructure

| Service | Configuration | Purpose |
|---|---|---|
| **S3** | `eskom-demand-analytics1` (af-south-1) | Stores raw dataset, trained model and feature list |
| **RDS** | PostgreSQL 18.3 (af-south-1) | Hosts 43,824 rows and 4 analytical views |
| **EC2** | Ubuntu 24.04, t2.micro (af-south-1) | Runs FastAPI demand prediction service |

---

## 6. Conclusion
This project demonstrates that South Africa's grid demand in 2024/25 was characterised by:

- **Stable seasonal patterns** — predictable winter peaks and summer troughs
- **Improved grid stability** — stress index remaining below critical thresholds throughout the year, consistent with the end of systematic loadshedding
- **Strong forecast accuracy** — Random Forest achieving sub-0.5% MAE, suitable for operational planning support
- **Low import dependency** — cross-border imports accounting for only ~5% of demand, indicating a largely self-sufficient grid

The pipeline architecture — from raw data ingestion through PostgreSQL, feature engineering in Python, ML model training, AWS deployment and Power BI visualisation — demonstrates a production-grade approach to energy analytics.

---

*Report generated as part of Eskom Power System Analytics Portfolio Project*
*Ndumiso Nkosi | github.com/NdNkosi/eskom-demand-analytics*
