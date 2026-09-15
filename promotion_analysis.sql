SELECT 
    'Promo 1' AS promotion,
    CASE WHEN promo1_flag = 1 THEN 'Promo1 Participant' ELSE 'Non-Participant' END AS participant_status,
    COUNT(*) AS member_count,
    ROUND(AVG(total_spend), 2) AS avg_total_spend,
    ROUND(AVG(maintenance_spend), 2) AS avg_maintenance,
    ROUND(AVG(detailing_spend), 2) AS avg_detailing,
    ROUND(AVG(tires_spend), 2) AS avg_tires,
    ROUND(AVG(inspections_spend), 2) AS avg_inspections,
    ROUND(AVG(roadside_spend), 2) AS avg_roadside,
    ROUND(AVG(accessories_spend), 2) AS avg_accessories,
    ROUND(AVG(CASE WHEN maintenance_txn_count > 0 THEN 1 ELSE 0 END) * 100, 1) AS pct_use_maintenance,
    ROUND(AVG(CASE WHEN detailing_txn_count > 0 THEN 1 ELSE 0 END) * 100, 1) AS pct_use_detailing,
    ROUND(AVG(CASE WHEN tires_txn_count > 0 THEN 1 ELSE 0 END) * 100, 1) AS pct_use_tires
FROM apex_dw
GROUP BY participant_status


UNION ALL


SELECT 
    'Promo 2' AS promotion,
    CASE WHEN promo2_flag = 1 THEN 'Promo2 Participant' ELSE 'Non-Participant' END AS participant_status,
    COUNT(*) AS member_count,
    ROUND(AVG(total_spend), 2) AS avg_total_spend,
    ROUND(AVG(maintenance_spend), 2) AS avg_maintenance,
    ROUND(AVG(detailing_spend), 2) AS avg_detailing,
    ROUND(AVG(tires_spend), 2) AS avg_tires,
    ROUND(AVG(inspections_spend), 2) AS avg_inspections,
    ROUND(AVG(roadside_spend), 2) AS avg_roadside,
    ROUND(AVG(accessories_spend), 2) AS avg_accessories,
    ROUND(AVG(CASE WHEN maintenance_txn_count > 0 THEN 1 ELSE 0 END) * 100, 1) AS pct_use_maintenance,
    ROUND(AVG(CASE WHEN detailing_txn_count > 0 THEN 1 ELSE 0 END) * 100, 1) AS pct_use_detailing,
    ROUND(AVG(CASE WHEN tires_txn_count > 0 THEN 1 ELSE 0 END) * 100, 1) AS pct_use_tires
FROM apex_dw
GROUP BY participant_status
ORDER BY promotion, participant_status DESC;
