# Customer Segmentation &amp; Analysis - SQL, Tableau
I took a normalized transactional database for a membership-based auto services company, run queries to look at cross-selling, customer segments, and promotion performance.

01 — Build analytics table:
- Creates apex_dw: one row per member
- Joins membership attributes (type, join date, region, state)
- Derives age bands, tier names, household size
- Flags promo 1, promo 2, event attendance
- Aggregates transaction count and spend per service line, plus total

02 — Segment analysis:
- Queries:
  - Event participants vs non-participants, by tier
  - Spend and multi-service usage rate
  - Spend by age band and tier across all six services
- 1st Question What distinguishes members who participated in special events from non-participants, and are special event attendees more valuable customers?

  --> Special event participants show high engagement with 78-97% using multiple services across all membership tiers. Corporate participants average $468.22 in spending with the strongest preference for maintenance and tires ($316.40), while Premium members favor discretionary services like detailing and accessories ($148.02), suggesting event attendees are highly engaged customers worth targeting for retention programs.
- 2nd Question: How do service preferences and spending patterns vary across different age groups, and which age demographics represent the highest value segments?

  --> Corporate members aged 50-64 show the highest spending at $479.71, driven primarily by maintenance ($207.76). Across all age groups, Corporate members consistently spend 2x more than Single members, while the 35-49 age band has the largest member base (416 members), representing the best opportunity for tier upgrade campaigns.

03 - Tableau visualizaton (see full write-up)

04 — Cross-sell analysis
- Maintenance buyers vs non-buyers
- What share of each group buys each other service
- Spend and service usage by household size

05 — Promotion analysis
- Promo 1 and promo 2 participants vs non-participants
- Spend and usage rate per service line
- UNION ALL stacks both promos into one output
