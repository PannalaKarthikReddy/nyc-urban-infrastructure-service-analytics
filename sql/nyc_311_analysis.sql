-- NYC 311 service request analysis
-- Analysis period: January to December 2025

USE nyc_311_analytics;


-- Dataset overview

SELECT
    COUNT(*) AS total_service_requests,
    COUNT(DISTINCT service_request_id) AS unique_service_requests,
    COUNT(DISTINCT agency) AS agencies,
    COUNT(DISTINCT complaint_type) AS complaint_types,
    COUNT(DISTINCT community_board_number) AS community_boards,
    COUNT(DISTINCT borough) AS boroughs
FROM nyc_311;


-- Monthly service request demand

SELECT
    DATE_FORMAT(created_at, '%Y-%m') AS month,
    COUNT(*) AS service_requests
FROM nyc_311
GROUP BY DATE_FORMAT(created_at, '%Y-%m')
ORDER BY month;


-- Agency workload

SELECT
    agency,
    COUNT(*) AS service_requests
FROM nyc_311
GROUP BY agency
ORDER BY service_requests DESC;


-- Top complaint types by service demand

SELECT
    complaint_type,
    COUNT(*) AS service_requests,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM nyc_311),
        2
    ) AS request_share_pct
FROM nyc_311
GROUP BY complaint_type
ORDER BY service_requests DESC
LIMIT 15;


-- Borough service demand

SELECT
    COALESCE(NULLIF(TRIM(borough), ''), 'UNKNOWN') AS borough_clean,
    COUNT(*) AS service_requests
FROM nyc_311
GROUP BY COALESCE(NULLIF(TRIM(borough), ''), 'UNKNOWN')
ORDER BY service_requests DESC;


-- Agency resolution performance

SELECT
    agency,
    COUNT(*) AS service_requests,
    ROUND(AVG(resolution_hours), 2) AS avg_resolution_hours,
    ROUND(
        AVG(
            CASE
                WHEN resolution_hours <= 24 THEN 1
                ELSE 0
            END
        ) * 100,
        2
    ) AS resolved_within_24h_pct
FROM nyc_311
WHERE resolution_hours IS NOT NULL
GROUP BY agency
ORDER BY avg_resolution_hours DESC;


-- Borough resolution performance

SELECT
    COALESCE(NULLIF(TRIM(borough), ''), 'UNKNOWN') AS borough_clean,
    COUNT(*) AS service_requests,
    ROUND(AVG(resolution_hours), 2) AS avg_resolution_hours,
    ROUND(
        AVG(
            CASE
                WHEN resolution_hours <= 24 THEN 1
                ELSE 0
            END
        ) * 100,
        2
    ) AS resolved_within_24h_pct
FROM nyc_311
WHERE resolution_hours IS NOT NULL
GROUP BY COALESCE(NULLIF(TRIM(borough), ''), 'UNKNOWN')
ORDER BY avg_resolution_hours DESC;


-- Top complaint types by resolution performance

SELECT
    complaint_type,
    COUNT(*) AS service_requests,
    ROUND(AVG(resolution_hours), 2) AS avg_resolution_hours,
    ROUND(
        AVG(
            CASE
                WHEN resolution_hours <= 24 THEN 1
                ELSE 0
            END
        ) * 100,
        2
    ) AS resolved_within_24h_pct
FROM nyc_311
WHERE resolution_hours IS NOT NULL
GROUP BY complaint_type
ORDER BY service_requests DESC
LIMIT 15;


-- Overall resolution time summary

SELECT
    COUNT(*) AS valid_resolution_records,
    ROUND(MIN(resolution_hours), 2) AS minimum_resolution_hours,
    ROUND(AVG(resolution_hours), 2) AS average_resolution_hours,
    ROUND(MAX(resolution_hours), 2) AS maximum_resolution_hours,
    ROUND(
        AVG(
            CASE
                WHEN resolution_hours <= 24 THEN 1
                ELSE 0
            END
        ) * 100,
        2
    ) AS resolved_within_24h_pct
FROM nyc_311
WHERE resolution_hours IS NOT NULL;


-- Community board service demand

SELECT
    COALESCE(
        NULLIF(TRIM(community_board), ''),
        'UNKNOWN'
    ) AS community_board_clean,
    COUNT(*) AS service_requests,
    ROUND(AVG(resolution_hours), 2) AS avg_resolution_hours
FROM nyc_311
GROUP BY COALESCE(
    NULLIF(TRIM(community_board), ''),
    'UNKNOWN'
)
ORDER BY service_requests DESC
LIMIT 15;


-- Community board resolution performance

SELECT
    COALESCE(
        NULLIF(TRIM(community_board), ''),
        'UNKNOWN'
    ) AS community_board_clean,
    COUNT(*) AS service_requests,
    ROUND(AVG(resolution_hours), 2) AS avg_resolution_hours,
    ROUND(
        AVG(
            CASE
                WHEN resolution_hours <= 24 THEN 1
                ELSE 0
            END
        ) * 100,
        2
    ) AS resolved_within_24h_pct
FROM nyc_311
WHERE resolution_hours IS NOT NULL
GROUP BY COALESCE(
    NULLIF(TRIM(community_board), ''),
    'UNKNOWN'
)
ORDER BY avg_resolution_hours DESC;


-- Monthly resolution performance

SELECT
    DATE_FORMAT(created_at, '%Y-%m') AS month,
    COUNT(*) AS service_requests,
    ROUND(AVG(resolution_hours), 2) AS avg_resolution_hours,
    ROUND(
        AVG(
            CASE
                WHEN resolution_hours <= 24 THEN 1
                ELSE 0
            END
        ) * 100,
        2
    ) AS resolved_within_24h_pct
FROM nyc_311
WHERE resolution_hours IS NOT NULL
GROUP BY DATE_FORMAT(created_at, '%Y-%m')
ORDER BY month;


-- Overall KPI summary

SELECT
    COUNT(*) AS total_service_requests,
    COUNT(DISTINCT service_request_id) AS unique_service_requests,
    COUNT(DISTINCT agency) AS agencies,
    COUNT(DISTINCT complaint_type) AS complaint_types,
    COUNT(DISTINCT community_board_number) AS community_boards,
    COUNT(DISTINCT borough) AS boroughs,
    COUNT(resolution_hours) AS valid_resolution_records,
    ROUND(AVG(resolution_hours), 2) AS average_resolution_hours,
    ROUND(
        AVG(
            CASE
                WHEN resolution_hours <= 24 THEN 1
                ELSE 0
            END
        ) * 100,
        2
    ) AS resolved_within_24h_pct
FROM nyc_311;
