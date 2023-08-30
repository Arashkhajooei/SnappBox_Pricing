SELECT
    o.City,
    o.Service_Type,
    o.Created_date,
    CASE
        WHEN i.Distance BETWEEN 0 AND 1 THEN '0-1'
        WHEN i.Distance BETWEEN 1 AND 2 THEN '1-2'
        WHEN i.Distance BETWEEN 2 AND 3 THEN '2-3'
        WHEN i.Distance BETWEEN 3 AND 4 THEN '3-4'
        WHEN i.Distance BETWEEN 4 AND 5 THEN '4-5'
        WHEN i.Distance BETWEEN 5 AND 6 THEN '5-6'
        WHEN i.Distance BETWEEN 6 AND 7 THEN '6-7'
        WHEN i.Distance BETWEEN 7 AND 8 THEN '7-8'
        WHEN i.Distance BETWEEN 8 AND 9 THEN '8-9'
        WHEN i.Distance BETWEEN 9 AND 10 THEN '9-10'
        WHEN i.Distance BETWEEN 10 AND 11 THEN '10-11'
        WHEN i.Distance BETWEEN 11 AND 12 THEN '11-12'
        WHEN i.Distance BETWEEN 12 AND 13 THEN '12-13'
        WHEN i.Distance BETWEEN 13 AND 14 THEN '13-14'
        WHEN i.Distance BETWEEN 14 AND 15 THEN '14-15'
        WHEN i.Distance BETWEEN 15 AND 16 THEN '15-16'
        WHEN i.Distance BETWEEN 16 AND 17 THEN '16-17'
        WHEN i.Distance BETWEEN 17 AND 18 THEN '17-18'
        WHEN i.Distance BETWEEN 18 AND 19 THEN '18-19'
        WHEN i.Distance BETWEEN 19 AND 20 THEN '19-20'
        WHEN i.Distance BETWEEN 20 AND 21 THEN '20-21'
        WHEN i.Distance BETWEEN 21 AND 22 THEN '21-22'
        WHEN i.Distance BETWEEN 22 AND 23 THEN '22-23'
        WHEN i.Distance BETWEEN 23 AND 24 THEN '23-24'
    END AS `Distance Buckets(KM)`,
    COUNT(DISTINCT o.ID) AS Request,
    COUNT(DISTINCT ofr.ID) AS Offered_Requests,
    COUNT(DISTINCT a.ID) AS Accepted_Requests,
    COUNT(DISTINCT CASE WHEN a.Status = 'Delivered' THEN a.ID END) AS Ride,
    SUM(i.Fare) AS `Total Ride Fare(GMV)(IRR)`,
    ROUND(COUNT(DISTINCT a.ID) * 100.0 / COUNT(DISTINCT o.ID), 2) AS `Offered-Order / Created-Order %`,
    ROUND(COUNT(DISTINCT CASE WHEN a.Status = 'Delivered' THEN a.ID END) * 100.0 / COUNT(DISTINCT a.ID), 2) AS `Accepted-Order / Offered-Order%`,
    ROUND(COUNT(DISTINCT CASE WHEN a.Status = 'Delivered' THEN a.ID END) * 100.0 / COUNT(DISTINCT o.ID), 2) AS `Fullfillment Rate%`,
    ROUND(SUM(i.Fare) / COUNT(DISTINCT CASE WHEN a.Status = 'Delivered' THEN a.ID END), 2) AS `Average Ride Fare`
FROM Order o
LEFT JOIN Offer ofr ON o.ID = ofr.Order_ID
LEFT JOIN Allotment a ON o.ID = a.Order_ID
LEFT JOIN Invoice i ON o.ID = i.Order_ID
WHERE o.City = 'A'
    AND o.Service_Type = 1
    AND o.Created_date = '6/22/2022'
GROUP BY
    o.City,
    o.Service_Type,
    o.Created_date,
    `Distance Buckets(KM)`
ORDER BY
    o.City,
    o.Service_Type,
    o.Created_date,
    `Distance Buckets(KM)`;
