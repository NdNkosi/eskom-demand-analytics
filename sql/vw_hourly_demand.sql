CREATE OR REPLACE VIEW vw_hourly_demand AS
SELECT
    DATE_TRUNC('hour', datetime)           AS hour_start,
    DATE(datetime)                         AS date_only,
    EXTRACT(HOUR FROM datetime)            AS hour_of_day,
    AVG(actual_demand)                     AS hourly_actual,
    AVG(forecast_demand)                   AS hourly_forecast
FROM power_system
WHERE datetime >= '2024-04-01'
  AND datetime <  '2025-04-01'
GROUP BY DATE_TRUNC('hour', datetime), DATE(datetime), EXTRACT(HOUR FROM datetime);
