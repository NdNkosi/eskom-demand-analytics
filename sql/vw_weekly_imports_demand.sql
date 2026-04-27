CREATE OR REPLACE VIEW vw_weekly_imports_demand AS
SELECT
    DATE_TRUNC('week', datetime)  AS week_start,
    MAX(imports)                  AS weekly_peak_imports,
    MAX(actual_demand)            AS weekly_peak_actual,
    MAX(exports)                  AS weekly_peak_exports
FROM power_system
WHERE datetime >= '2024-04-01'
  AND datetime <  '2025-04-01'
GROUP BY DATE_TRUNC('week', datetime);
