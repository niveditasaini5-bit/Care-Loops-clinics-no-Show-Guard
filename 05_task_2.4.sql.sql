USE noshowguard;

WITH monthly AS (
    SELECT
        SUBSTR(appt_date, 1, 7) AS month,
        COUNT(*) AS appointments,
        SUM(no_show) AS no_shows,
        ROUND(100.0 * SUM(no_show) / COUNT(*), 2) AS no_show_pct
    FROM appointments
    GROUP BY SUBSTR(appt_date, 1, 7)
)
SELECT
    month,
    appointments,
    no_shows,
    no_show_pct,
    ROUND(
        no_show_pct - LAG(no_show_pct) OVER (ORDER BY month),
        2
    ) AS change_pp
FROM monthly
ORDER BY month;

