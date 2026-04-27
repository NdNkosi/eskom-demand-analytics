CREATE OR REPLACE VIEW vw_power_bi_weekly AS
SELECT
    DATE_TRUNC('week', datetime)                    AS week_start,
    EXTRACT(YEAR  FROM datetime)                    AS year,
    EXTRACT(MONTH FROM datetime)                    AS month,
    MAX(actual_demand)                              AS weekly_peak_actual,
    MAX(forecast_demand)                            AS weekly_peak_forecast,
    MAX(capacity)                                   AS weekly_peak_capacity,
    MAX(actual_demand) / NULLIF(MAX(capacity), 0)   AS weekly_peak_stress,
    AVG(forecast_error)                             AS avg_forecast_error,
    MAX(ABS(forecast_error))                        AS max_abs_forecast_error,
    MAX(nuclear)                                    AS weekly_peak_nuclear,
    MAX(imports)                                    AS weekly_peak_imports,
    MAX(exports)                                    AS weekly_peak_exports,
    MAX(pump_storage)                               AS weekly_peak_pump_storage
FROM power_system
GROUP BY DATE_TRUNC('week', datetime),
         EXTRACT(YEAR FROM datetime),
         EXTRACT(MONTH FROM datetime);
