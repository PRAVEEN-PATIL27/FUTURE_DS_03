use funnel_data_analysis ;

 
-- TOP 10 VALUES OF THE DATASET
SELECT TOP 10 *
FROM Funnel;


-- TOTAL NUMBER OF SESSIONS 
SELECT COUNT(DISTINCT Session_ID) AS TotalSessions
FROM Funnel;


-- TOTAL REVENUE 
SELECT ROUND(SUM(Revenue),1) AS TotalRevenue
FROM Funnel;

-- TOTAL EVENT ANALYSIS
SELECT Event,
COUNT(*) AS TotalEvents
FROM Funnel
GROUP BY Event
ORDER BY TotalEvents DESC;


-- TOTAL DEVICE ANALYSIS
SELECT Device,
COUNT(*) AS Users
FROM Funnel
GROUP BY Device;


-- TOTAL CHANNEL ANALYSIS
SELECT Channel,
COUNT(*) AS Users
FROM Funnel
GROUP BY Channel;

-- REGIONAL ANALYSIS
SELECT Region,
COUNT(*) AS Users
FROM Funnel
GROUP BY Region;


-- COUNT OF THE TOTAL PURCHASES 
SELECT COUNT(*) AS TotalPurchases
FROM Funnel
WHERE Event = 'Purchase';


--  TOTAL OF PURCHASE REVENUE
SELECT ROUND(SUM(Revenue),1) AS PurchaseRevenue
FROM Funnel
WHERE Event = 'Purchase';

-- TOTAL REVENUE BY CHANNEL 
SELECT
    Channel,
    ROUND(SUM(Revenue),1) AS TotalRevenue
FROM Funnel
GROUP BY Channel
ORDER BY TotalRevenue DESC;

-- TOTAL REVENUE BY REGION
SELECT
    Region,
    ROUND(SUM(Revenue),1) AS TotalRevenue
FROM Funnel
GROUP BY Region
ORDER BY TotalRevenue DESC;

-- PRODUCT CATEGORY ANALYSIS
SELECT
    Product_Category,
    COUNT(*) AS Events
FROM Funnel
GROUP BY Product_Category
ORDER BY Events DESC;


-- REVENUE BY PRODUCT
SELECT
    Product_Category,
    ROUND(SUM(Revenue),1) AS Revenue
FROM Funnel
GROUP BY Product_Category
ORDER BY Revenue DESC;

-- REVENUE BY DEVICES
SELECT
    Device,
    ROUND(SUM(Revenue),1) AS Revenue
FROM Funnel
GROUP BY Device
ORDER BY Revenue DESC;


-- CONVERSION RATE CALCULATION
SELECT
CAST(
    COUNT(CASE WHEN Event = 'Purchase' THEN 1 END)
    * 100.0 /
    COUNT(DISTINCT Session_ID)
AS DECIMAL(10,2)) AS ConversionRate
FROM Funnel;


-- FUNNEL DROP OFF RATE 
SELECT
    Event,
    COUNT(*) AS Users,
    CAST(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM Funnel WHERE Event = 'Browse')
    AS DECIMAL(10,2)) AS FunnelPercentage
FROM Funnel
GROUP BY Event
ORDER BY Users DESC;