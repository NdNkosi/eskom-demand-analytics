from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import joblib
import json
import numpy as np

model = joblib.load('eskom_demand_model.pkl')
with open('features.json', 'r') as f:
    features = json.load(f)

app = FastAPI(
    title="Eskom Demand Forecasting API",
    description="Predicts South Africa grid demand using Random Forest",
    version="1.0.0"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"]
)

class DemandInput(BaseModel):
    hour: int
    day: int
    month: int
    day_of_week: int
    week: int
    forecast_demand: float
    stress_index: float
    import_ratio: float
    lag_1h: float
    lag_24h: float
    lag_168h: float

@app.get("/")
def root():
    return {"message": "Eskom Demand Forecasting API is running"}

@app.get("/health")
def health():
    return {"status": "healthy"}

@app.post("/predict")
def predict(data: DemandInput):
    input_data = np.array([[
        data.hour, data.day, data.month, data.day_of_week, data.week,
        data.forecast_demand, data.stress_index, data.import_ratio,
        data.lag_1h, data.lag_24h, data.lag_168h
    ]])
    prediction = model.predict(input_data)[0]
    return {
        "predicted_demand_mw": round(float(prediction), 2),
        "input_features": data.dict()
    }
