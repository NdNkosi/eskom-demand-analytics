CREATE OR REPLACE VIEW vw_weekly_forecast_error AS
SELECT
    DATE_TRUNC('week', datetime)     AS week_start,
    AVG(forecast_error)              AS avg_forecast_error,
    MAX(forecast_error)              AS max_forecast_error,
    MIN(forecast_error)              AS min_forecast_error
FROM power_system
WHERE datetime >= '2024-04-01'
  AND datetime <  '2025-04-01'
GROUP BY DATE_TRUNC('week', datetime);
