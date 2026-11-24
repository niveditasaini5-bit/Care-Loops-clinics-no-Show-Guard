USE noshowguard;

SELECT
    CASE
        WHEN lead_days BETWEEN 1 AND 7 THEN '1-7'
        WHEN lead_days BETWEEN 8 AND 14 THEN '8-14'
        WHEN lead_days BETWEEN 15 AND 30 THEN '15-30'
        WHEN lead_days >= 31 THEN '31+'
    END AS lead_band,
    COUNT(*) AS appointments,
    SUM(no_show) AS no_shows,
    ROUND(100.0 * SUM(no_show) / COUNT(*), 1) AS no_show_pct,
    MIN(lead_days) AS min_lead_days
FROM appointments
WHERE lead_days >= 1
GROUP BY lead_band
ORDER BY min_lead_days;  

