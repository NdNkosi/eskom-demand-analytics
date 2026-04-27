# Eskom Demand Analytics

End-to-end demand forecasting pipeline for South Africa's power grid using Python, PostgreSQL, AWS (S3, RDS, EC2) and Power BI.

## Project Overview
This project analyses Eskom's national power system data for the 2024/25 financial year, combining data engineering, machine learning and business intelligence to deliver actionable grid insights.

## Architecture
- **Data Storage**: AWS S3 (raw data + model artifacts) and AWS RDS PostgreSQL (43,824 rows)
- **Data Processing**: Python (Pandas, NumPy) with feature engineering
- **Machine Learning**: Scikit-learn, XGBoost, Random Forest
- **API Deployment**: FastAPI hosted on AWS EC2
- **Business Intelligence**: Power BI (5-page interactive dashboard)

## Key Results
| Model | MAE | RMSE |
|---|---|---|
| Linear Regression | 131.96 MW | 171.07 MW |
| XGBoost | 166.96 MW | 248.41 MW |
| **Random Forest** | **128.54 MW** | **167.97 MW** |

## Live API
The demand forecasting model is deployed as a REST API on AWS EC2:
- **Endpoint**: http://13.245.229.94:8000
- **Docs**: http://13.245.229.94:8000/docs

## Repository Structure\
eskom-demand-analytics/
├── notebooks/
│   ├── eskom_project.ipynb    # Data cleaning & Power BI prep
│   └── ml_models.ipynb        # ML models & evaluation
├── api/
│   └── main.py                # FastAPI prediction endpoint
├── sql/
│   ├── vw_power_bi_weekly.sql
│   ├── vw_hourly_demand.sql
│   ├── vw_weekly_imports_demand.sql
│   └── vw_weekly_forecast_error.sql
└── README.md\
## AWS Infrastructure
- **S3**: `eskom-demand-analytics1` (af-south-1) — stores raw dataset and trained model
- **RDS**: PostgreSQL database with 4 analytical views
- **EC2**: Ubuntu 24.04 instance running FastAPI prediction service

## Tech Stack
Python, PostgreSQL, AWS (S3, RDS, EC2), FastAPI, Scikit-learn, XGBoost, Power BI, Pandas, NumPy, Matplotlib, Seaborn, SQLAlchemy, boto3

## Key Insights
- Random Forest outperformed XGBoost, confirming strong linear temporal patterns in grid demand
- Grid stress index peaked at 0.68 during June/July 2024 winter period
- Cross-border imports peaked at ~1,600 MW, representing ~5% of total demand
- June 2024 showed the largest forecast error (~700 MW) during winter peak
