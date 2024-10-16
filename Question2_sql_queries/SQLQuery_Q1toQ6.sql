
/*
QUERY 1: What are the top 5 brands by receipts scanned for most recent month?
*/

WITH recent AS (
    SELECT TOP 1 
        YEAR(r.scanned_date) AS year, MONTH(r.scanned_date) AS month
    FROM receipts_main r
    ORDER BY r.scanned_date DESC
),
res AS (
    SELECT TOP 5 i.barcode
    FROM receipts_main r
    JOIN receipt_items i ON r.receipt_id = i.receipt_id
    WHERE YEAR(r.scanned_date) = (SELECT year FROM recent) 
      AND MONTH(r.scanned_date) = (SELECT month FROM recent)
    GROUP BY i.barcode
    ORDER BY COUNT(i.barcode) DESC
)
SELECT b.brand_id, b.brand_name FROM brands_data b
JOIN res ON b.barcode = res.barcode;

-------------------------------------------------------------------------------------------------------------------

/*
Query 3: When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
*/
SELECT rewards_receipt_status AS STATUS, 
    SUM(total_spent) AS TotalSpent,
    (SUM(total_spent) / COUNT(rewards_receipt_status)) AS AvgSpent 
FROM receipts_main 
GROUP BY rewards_receipt_status 
ORDER BY AvgSpent DESC;

---------------------------------------------------------------------------------------------------------------------

/* 
Query 4: When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
*/

SELECT rewards_receipt_status AS STATUS, 
	SUM(purchased_item_count) AS ItemsCount 
FROM receipts_main 
GROUP BY rewards_receipt_status 
ORDER BY ItemsCount DESC;

-----------------------------------------------------------------------------------------------------------------------

/* 
Query 5: Which brand has the most spend among users who were created within the past 6 months?
*/

WITH recent AS (
    SELECT user_id AS users FROM users_data 
    WHERE created_date > DATEADD(MONTH, -6, (SELECT TOP 1 created_date FROM users_data 
    ORDER BY created_date DESC))
),
barcode_spending AS (
    SELECT i.barcode, SUM(r.total_spent) AS TotalSpent FROM receipts_main r
      JOIN receipt_items i ON r.receipt_id = i.receipt_id
    WHERE r.user_id IN (SELECT users FROM recent)
    GROUP BY i.barcode 
)
SELECT bs.barcode, bs.TotalSpent, b.brand_name FROM barcode_spending bs
LEFT JOIN brands_data b ON bs.barcode = b.barcode
ORDER BY bs.TotalSpent DESC;

---------------------------------------------------------------------------------------------------------------------

/*
Query 6: Which brand has the most transactions among users who were created within the past 6 months?
*/

WITH recent AS (
    SELECT user_id AS users FROM users_data 
    WHERE created_date > DATEADD(MONTH, -6, (SELECT TOP 1 created_date FROM users_data 
  ORDER BY created_date DESC))
)
SELECT i.barcode, COUNT(i.barcode) AS Transactions, b.brand_name FROM receipts_main r
JOIN receipt_items i ON r.receipt_id = i.receipt_id 
LEFT JOIN brands_data b ON i.barcode = b.barcode
WHERE r.user_id IN (SELECT users FROM recent)
GROUP BY i.barcode, b.brand_name 
ORDER BY Transactions DESC;

---------------------------------------------------------------------------------------------------------------------------

