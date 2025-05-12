-- SQL Queries for the Marketing Campaign Analysis

-- creating the table with appropriate data types ignoring the dollar sign and comma in acquisition_cost

CREATE TABLE marketing_campaigns (
    campaign_id INTEGER PRIMARY KEY,
    company VARCHAR(100),
    campaign_type VARCHAR(50),
    target_audience VARCHAR(50),
    duration VARCHAR(20),
    channel_used VARCHAR(50),
    conversion_rate DECIMAL(5,2),
    acquisition_cost DECIMAL(10,2),
    roi DECIMAL(5,2),
    location VARCHAR(50),
    language VARCHAR(50),
    clicks INTEGER,
    impressions INTEGER,
    engagement_score INTEGER,
    customer_segment VARCHAR(50),
    date DATE
);

-- Channel Effectiveness Analysis
SELECT 
    channel_used, 
    COUNT(*) AS campaign_count, 
    AVG(conversion_rate) AS avg_conversion_rate, 
    AVG(roi) AS avg_roi, 
    AVG(acquisition_cost) AS avg_acquisition_cost,
    SUM(clicks) AS total_clicks, 
    SUM(impressions) AS total_impressions
FROM marketing_campaigns
GROUP BY channel_used
ORDER BY avg_roi DESC;

-- Campaign Type Performance
SELECT 
    campaign_type, 
    COUNT(*) AS campaign_count, 
    AVG(conversion_rate) AS avg_conversion_rate,
    AVG(roi) AS avg_roi, 
    AVG(acquisition_cost) AS avg_acquisition_cost
FROM marketing_campaigns
GROUP BY campaign_type
ORDER BY avg_roi DESC;

-- Top 10 Highest ROI Campaigns
SELECT 
    campaign_id, 
    company, 
    campaign_type, 
    channel_used, 
    target_audience, 
    roi, 
    conversion_rate
FROM marketing_campaigns
ORDER BY roi DESC
LIMIT 10;

-- Customer Segment Analysis
SELECT 
    customer_segment, 
    COUNT(*) AS campaign_count, 
    AVG(conversion_rate) AS avg_conversion_rate,
    AVG(roi) AS avg_roi, 
    AVG(engagement_score) AS avg_engagement
FROM marketing_campaigns
GROUP BY customer_segment
ORDER BY avg_roi DESC;

-- Channel and Target Audience Cross-Analysis
SELECT 
    channel_used, 
    target_audience, 
    COUNT(*) AS campaign_count, 
    AVG(conversion_rate) AS avg_conversion_rate, 
    AVG(roi) AS avg_roi
FROM marketing_campaigns
GROUP BY channel_used, target_audience
ORDER BY avg_roi DESC;

-- Campaign Performance Analysis with Conversion Funnel Metrics
SELECT 
    campaign_id, 
    company, 
    impressions, 
    clicks, 
    clicks * conversion_rate AS estimated_conversions,
    CAST(clicks AS DECIMAL) / NULLIF(impressions, 0) AS ctr, 
    conversion_rate,
    acquisition_cost / (clicks * conversion_rate) AS cost_per_conversion
FROM marketing_campaigns
WHERE impressions > 0 AND clicks > 0
ORDER BY cost_per_conversion;
