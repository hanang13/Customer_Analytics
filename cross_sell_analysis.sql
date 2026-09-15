SELECT 
    CASE 
        WHEN maintenance_spend > 0 THEN 'Maintenance' 
        ELSE 'No Maintenance' 
    END AS maintenance_buyer,
    ROUND(AVG(CASE WHEN detailing_spend > 0 THEN 1 ELSE 0 END) * 100, 1) AS pct_buy_detailing,
    ROUND(AVG(CASE WHEN tires_spend > 0 THEN 1 ELSE 0 END) * 100, 1) AS pct_buy_tires,
    ROUND(AVG(CASE WHEN inspections_spend > 0 THEN 1 ELSE 0 END) * 100, 1) AS pct_buy_inspections,
    ROUND(AVG(CASE WHEN roadside_spend > 0 THEN 1 ELSE 0 END) * 100, 1) AS pct_buy_roadside,
    ROUND(AVG(CASE WHEN accessories_spend > 0 THEN 1 ELSE 0 END) * 100, 1) AS pct_buy_accessories,
    COUNT(*) AS member_count,
    ROUND(AVG(total_spend), 2) AS avg_total_spend
FROM apex_dw
GROUP BY maintenance_buyer
ORDER BY maintenance_buyer;


SELECT 
    CASE 
        WHEN household_size = 1 THEN '1 member'
        WHEN household_size = 2 THEN '2 members'
        WHEN household_size BETWEEN 3 AND 4 THEN '3-4 members'
        WHEN household_size >= 5 THEN '5+ members'
    END AS household_category,
    COUNT(*) AS total_members,
    ROUND(AVG(total_spend), 2) AS avg_total_spend,
    ROUND(AVG(maintenance_txn_count + detailing_txn_count + tires_txn_count + 
              inspections_txn_count + roadside_txn_count + accessories_txn_count), 1) AS avg_transactions,
    ROUND(AVG(CASE WHEN maintenance_txn_count > 0 THEN 1 ELSE 0 END) * 100, 1) AS pct_use_maintenance,
    ROUND(AVG(CASE WHEN detailing_txn_count > 0 THEN 1 ELSE 0 END) * 100, 1) AS pct_use_detailing,
    ROUND(AVG(CASE WHEN accessories_txn_count > 0 THEN 1 ELSE 0 END) * 100, 1) AS pct_use_accessories,
    ROUND(AVG(accessories_spend), 2) AS avg_accessories_spend
FROM apex_dw
GROUP BY 
    CASE 
        WHEN household_size = 1 THEN '1 member'
        WHEN household_size = 2 THEN '2 members'
        WHEN household_size BETWEEN 3 AND 4 THEN '3-4 members'
        WHEN household_size >= 5 THEN '5+ members'
    END
ORDER BY 
    MIN(household_size);
