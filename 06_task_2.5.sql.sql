USE noshowguard;

WITH clinic_rates AS (
    SELECT
        c.clinic_name,
        c.city,
        COUNT(*) AS appointments,
        SUM(a.no_show) AS no_shows,
        ROUND(100.0 * SUM(a.no_show) / COUNT(*), 2) AS no_show_pct
    FROM appointments a
    JOIN clinics c
        ON a.clinic_id = c.clinic_id
    GROUP BY c.clinic_id, c.clinic_name, c.city
)
SELECT
    clinic_name,
    city,
    appointments,
    no_shows,
    no_show_pct,
    RANK() OVER (
        PARTITION BY city
        ORDER BY no_show_pct DESC
    ) AS city_rank,
    CASE
        WHEN no_show_pct > 22.02 THEN 'above'
        WHEN no_show_pct < 22.02 THEN 'below'
        ELSE 'equal'
    END AS overall_comparison
FROM clinic_rates
ORDER BY city, city_rank; 

