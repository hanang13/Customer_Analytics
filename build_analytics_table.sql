USE apex;


DROP TABLE IF EXISTS apex_dw;


CREATE TABLE apex_dw AS
SELECT
    -- keys
    m.member_id,
    m.membership_id,
    -- Membership attributes --
    ms.membership_type,
    CASE 
        WHEN ms.membership_type = 'Individual' THEN 'Single'
        WHEN ms.membership_type = 'Family'     THEN 'Household'
        WHEN ms.membership_type = 'Fleet'      THEN 'Corporate'
        ELSE 'Premium'
    END AS membership_category,
    ms.join_date,
    YEAR(ms.join_date)  AS join_year,
    MONTH(ms.join_date) AS join_month,
    QUARTER(ms.join_date) AS join_quarter,
    -- Geography --
    ms.region,
    ms.state,
    -- Household size --
    hh.household_size,
    -- Member demographics --
    m.gender,
    CASE 
        WHEN m.age < 20          THEN 'Under 20'
        WHEN m.age BETWEEN 20 AND 34 THEN '20-34'
        WHEN m.age BETWEEN 35 AND 49 THEN '35-49'
        WHEN m.age BETWEEN 50 AND 64 THEN '50-64'
        ELSE '65+'
    END AS age_band,
    -- Promo & special flags --
    CASE WHEN p1.member_id IS NOT NULL THEN 1 ELSE 0 END AS promo1_flag,
    CASE WHEN p2.member_id IS NOT NULL THEN 1 ELSE 0 END AS promo2_flag,
    CASE WHEN sp.membership_id IS NOT NULL THEN 1 ELSE 0 END AS special_flag,
    -- Service aggregates by member --
    -- Maintenance
    COALESCE(mai.maintenance_txn_count, 0) AS maintenance_txn_count,
    COALESCE(mai.maintenance_spend,     0) AS maintenance_spend,
    -- Detailing
    COALESCE(det.detailing_txn_count,   0) AS detailing_txn_count,
    COALESCE(det.detailing_spend,       0) AS detailing_spend,
    -- Tires
    COALESCE(ti.tires_txn_count,        0) AS tires_txn_count,
    COALESCE(ti.tires_spend,            0) AS tires_spend,
    -- Inspections
    COALESCE(ins.inspections_txn_count, 0) AS inspections_txn_count,
    COALESCE(ins.inspections_spend,     0) AS inspections_spend,
    -- Roadside
    COALESCE(rs.roadside_txn_count,     0) AS roadside_txn_count,
    COALESCE(rs.roadside_spend,         0) AS roadside_spend,
    -- Accessories
    COALESCE(ac.accessories_txn_count,  0) AS accessories_txn_count,
    COALESCE(ac.accessories_spend,      0) AS accessories_spend,
    -- Total spend across all service categories --
    COALESCE(mai.maintenance_spend,  0)
  + COALESCE(det.detailing_spend,    0)
  + COALESCE(ti.tires_spend,         0)
  + COALESCE(ins.inspections_spend,  0)
  + COALESCE(rs.roadside_spend,      0)
  + COALESCE(ac.accessories_spend,   0) AS total_spend
FROM members m
JOIN memberships ms
  ON m.membership_id = ms.membership_id
-- household size per membership --
LEFT JOIN (
    SELECT membership_id,
           COUNT(*) AS household_size
    FROM members
    GROUP BY membership_id
) AS hh
  ON m.membership_id = hh.membership_id
-- promos & special --
LEFT JOIN promoone  AS p1 ON m.member_id      = p1.member_id
LEFT JOIN promotwo  AS p2 ON m.member_id      = p2.member_id
LEFT JOIN special   AS sp ON ms.membership_id = sp.membership_id
-- maintenance aggregate per member --
LEFT JOIN (
    SELECT member_id,
           COUNT(*)          AS maintenance_txn_count,
           SUM(amount_spent) AS maintenance_spend
    FROM maintenance
    GROUP BY member_id
) AS mai
  ON m.member_id = mai.member_id
-- detailing aggregate per member --
LEFT JOIN (
    SELECT member_id,
           COUNT(*)          AS detailing_txn_count,
           SUM(amount_spent) AS detailing_spend
    FROM detailing
    GROUP BY member_id
) AS det
  ON m.member_id = det.member_id
-- tires aggregate per member --
LEFT JOIN (
    SELECT member_id,
           COUNT(*)          AS tires_txn_count,
           SUM(amount_spent) AS tires_spend
    FROM tires
    GROUP BY member_id
) AS ti
  ON m.member_id = ti.member_id
-- inspections aggregate per member --
LEFT JOIN (
    SELECT member_id,
           COUNT(*)          AS inspections_txn_count,
           SUM(amount_spent) AS inspections_spend
    FROM inspections
    GROUP BY member_id
) AS ins
  ON m.member_id = ins.member_id
-- roadside aggregate per member --
LEFT JOIN (
    SELECT member_id,
           COUNT(*)          AS roadside_txn_count,
           SUM(amount_spent) AS roadside_spend
    FROM roadside
    GROUP BY member_id
) AS rs
  ON m.member_id = rs.member_id
-- accessories aggregate per member --
LEFT JOIN (
    SELECT member_id,
           COUNT(*)          AS accessories_txn_count,
           SUM(amount_spent) AS accessories_spend
    FROM accessories
    GROUP BY member_id
) AS ac
  ON m.member_id = ac.member_id;
