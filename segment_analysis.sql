SELECT 
    CASE WHEN special_flag = 1 THEN 'Special Event Participant' 
         ELSE 'Non-Participant' END AS participation_status,
    membership_category,
    COUNT(*) AS member_count,
    ROUND(AVG(total_spend), 2) AS avg_total_spend,
    ROUND(AVG(maintenance_spend + tires_spend), 2) AS avg_maintenance_tires_spend,
    ROUND(AVG(detailing_spend + accessories_spend), 2) AS avg_detail_accessories_spend,
    ROUND(AVG(CASE WHEN (maintenance_txn_count > 0) + (detailing_txn_count > 0) + 
              (tires_txn_count > 0) + (inspections_txn_count > 0) + 
              (roadside_txn_count > 0) + (accessories_txn_count > 0) >= 3 THEN 1 ELSE 0 END) * 100, 1) AS pct_multi_service
FROM apex_dw
GROUP BY participation_status, membership_category
ORDER BY participation_status, membership_category;


SELECT 
    age_band,
    membership_category,
    COUNT(*) AS member_count,
    ROUND(AVG(total_spend), 2) AS avg_total_spend,
    ROUND(AVG(maintenance_spend), 2) AS avg_maintenance,
    ROUND(AVG(detailing_spend), 2) AS avg_detailing,
    ROUND(AVG(tires_spend), 2) AS avg_tires,
    ROUND(AVG(roadside_spend), 2) AS avg_roadside,
    ROUND(AVG(accessories_spend), 2) AS avg_accessories,
    ROUND(AVG(CASE WHEN total_spend > 0 THEN 1 ELSE 0 END) * 100, 1) AS pct_active
FROM apex_dw
WHERE age_band != 'Unknown'
GROUP BY age_band, membership_category
ORDER BY age_band, membership_category, avg_total_spend;
