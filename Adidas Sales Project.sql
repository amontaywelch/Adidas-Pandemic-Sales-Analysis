-- Collecting a scope of the data
SELECT *
FROM adidas_data
LIMIT 10;

-- Which retailers are present, and how many locations do each retailer occupy?

SELECT
   DISTINCT retailer,
   COUNT(retailer) AS retailer_count
FROM adidas_data
GROUP BY retailer;

-- How many states are present? (Used to group into regions, if number were to be less than 50, data could skew greatly)

SELECT 
   COUNT(DISTINCT state)
FROM adidas_data;


-- What are the product categories sold, and how many in total were recorded for each?

SELECT 
   product, 
   COUNT(product) AS product_count
FROM adidas_data
GROUP BY product
ORDER BY product_count DESC;


-- How many total units(total products sold) were sold?

SELECT 
   SUM(units_sold) AS total_products_sold
FROM adidas_data;


-- Comparing 2020 and 2021, how many units were sold in each year? 

SELECT 
  sales_year, SUM(units_sold) AS num_products_sold
FROM
    (SELECT 
        units_Sold, SUBSTRING(invoice_date, 1, 4) AS sales_year
    FROM
        adidas_data) AS subquery
WHERE sales_year IN ('2020' , '2021')
GROUP BY sales_year;


-- What were the number of units sold per month? Display along with month-over-month trends as a percent

WITH monthly_units_sold AS (
    SELECT
        YEAR(invoice_date) AS sales_year,
        MONTH(invoice_date) AS sales_month,
        COUNT(units_sold) AS products_sold
    FROM
        adidas_data
    WHERE
        YEAR(invoice_date) IN (2020, 2021)
    GROUP BY
        sales_year, sales_month
    ORDER BY
        sales_year, sales_month
),
units_sold_with_change AS (
    SELECT
        sales_year,
        sales_month,
        products_sold,
        LAG(products_sold) OVER (
            PARTITION BY sales_year 
            ORDER BY sales_month
        ) AS previous_month_units_sold
    FROM
        monthly_units_sold
)
SELECT
    sales_year,
    sales_month,
    products_sold,
    previous_month_units_sold,
    CASE
        WHEN previous_month_units_sold IS NOT NULL THEN 
            ROUND(((products_sold - previous_month_units_sold) * 100.0 / previous_month_units_sold), 2)
        ELSE NULL
    END AS percent_change
FROM
    units_sold_with_change
ORDER BY
    sales_year, sales_month;

    
-- How much revenue did Adidas generate from 2020-2021? 
SELECT 
  SUM(total_sales) AS total_revenue
FROM adidas_data;
    


-- Compare revenue earned in 2020 and 2021 separately. How much did each respective year generate?

SELECT 
  sales_year, SUM(total_sales) AS overall_revenue
FROM
    (SELECT 
        Total_Sales, SUBSTRING(invoice_date, 1, 4) AS sales_year
    FROM
        adidas_data) AS subquery
WHERE sales_year IN ('2020' , '2021')
GROUP BY sales_year;


-- Show the month over month revenue trends, along with growth percentage. 

WITH monthly_revenue AS (
    SELECT
        YEAR(invoice_date) AS sales_year,
        MONTH(invoice_date) AS sales_month,
        SUM(total_sales) AS monthly_revenue
    FROM
        adidas_data
    WHERE
        YEAR(invoice_date) IN (2020, 2021)
    GROUP BY
        sales_year, sales_month
    ORDER BY
        sales_year, sales_month
),
revenue_with_change AS (
    SELECT
        sales_year,
        sales_month,
        monthly_revenue,
        LAG(monthly_revenue) OVER (
            PARTITION BY sales_year 
            ORDER BY sales_month
        ) AS previous_month_revenue
    FROM
        monthly_revenue
)
SELECT
    sales_year,
    sales_month,
    monthly_revenue,
    previous_month_revenue,
    CASE
        WHEN previous_month_revenue IS NOT NULL THEN 
            ROUND(((monthly_revenue - previous_month_revenue) * 100.0 / previous_month_revenue), 2)
        ELSE NULL
    END AS percent_change
FROM
    revenue_with_change
ORDER BY
    sales_year, sales_month;


-- How much did Adidas make in profit?

SELECT 
   SUM(operating_profit) AS total_profit
FROM adidas_data;


-- Display profit margins by month, including growth percentages.

WITH monthly_profits AS (
    SELECT
        YEAR(invoice_date) AS sales_year,
        MONTH(invoice_date) AS sales_month,
        ROUND(SUM(operating_profit), 2) AS monthly_profit
    FROM
        adidas_data
    WHERE
        YEAR(invoice_date) IN (2020, 2021)
    GROUP BY
        sales_year, sales_month
    ORDER BY
        sales_year, sales_month
),
profits_with_change AS (
    SELECT
        sales_year,
        sales_month,
        monthly_profit,
        LAG(monthly_profit) OVER (
            PARTITION BY sales_year 
            ORDER BY sales_month
        ) AS previous_month_profit
    FROM
        monthly_profits
)
SELECT
    sales_year,
    sales_month,
    monthly_profit,
    previous_month_profit,
    CASE
        WHEN previous_month_profit IS NOT NULL THEN 
            ROUND(((monthly_profit - previous_month_profit) * 100.0 / previous_month_profit), 2)
        ELSE NULL
    END AS percent_change
FROM
    profits_with_change
ORDER BY
    sales_year, sales_month;


-- For each product, how much revenue did each one generate? Display totals and percentage of total

SELECT 
    product,
    SUM(total_sales) AS total_revenue,
    ROUND(
        (SUM(total_sales) / (SELECT SUM(total_sales) FROM adidas_data)) * 100,
        2
    ) AS percentage_of_total
FROM
    adidas_data
GROUP BY 
    product
ORDER BY 
    percentage_of_total DESC;


-- How profitable is each product, and what is the profit margin of each>

SELECT
    product,
    SUM(operating_profit) AS total_profit,
    ROUND(AVG(operating_margin), 2) AS average_profit_margin
FROM
    adidas_data
GROUP BY
    product
ORDER BY
    average_profit_margin DESC;



-- Grouped by each month in 2020 and 2021, rank each product in terms of total sales(rank 1-6)

WITH monthly_product_sales_ranking AS (
    SELECT
        product,
        YEAR(invoice_date) AS sales_year,
        MONTH(invoice_date) AS sales_month,
        SUM(total_sales) AS total_revenue,
        DENSE_RANK() OVER (
            PARTITION BY YEAR(invoice_date), MONTH(invoice_date) 
            ORDER BY SUM(total_sales) DESC
        ) AS product_rank
    FROM
        adidas_data
    GROUP BY
        product, sales_year, sales_month
)
SELECT
    product,
    sales_year,
    sales_month,
    total_revenue,
    product_rank
FROM
    monthly_product_sales_ranking
ORDER BY
    sales_year, sales_month, product_rank;

    
-- Use the same query as above to rank products based on total units sold on a month to month basis

WITH monthly_units_sold_ranking AS (
    SELECT
        product,
        YEAR(invoice_date) AS sales_year,
        MONTH(invoice_date) AS sales_month,
        SUM(units_sold) AS total_quantity_sold,
        DENSE_RANK() OVER (
            PARTITION BY YEAR(invoice_date), MONTH(invoice_date) 
            ORDER BY SUM(units_sold) DESC
        ) AS product_dense_rank
    FROM
        adidas_data
    GROUP BY
        product, sales_year, sales_month
)
SELECT
    product,
    sales_year,
    sales_month,
    total_quantity_sold,
    product_dense_rank
FROM
    monthly_units_sold_ranking
ORDER BY
    sales_year, sales_month, product_dense_rank;


-- Showcase each region, how much revenue each generated(including %), and total units sold(including %). 

SELECT
    region,
    SUM(total_sales) AS regional_revenue,
    ROUND(
        (SUM(total_sales) / (SELECT SUM(total_sales) FROM adidas_data)) * 100,
        2
    ) AS regional_sales_percentage,
    SUM(units_sold) AS total_units_sold,
    ROUND(
        (SUM(units_sold) / (SELECT SUM(units_sold) FROM adidas_data)) * 100,
        2
    ) AS units_sold_percentage
FROM
    adidas_data
GROUP BY
    region
ORDER BY
    regional_sales_percentage DESC, units_sold_percentage DESC;



-- Viewing month over month trends, what did regional revenue growth rates look like?

WITH monthly_regional_revenue AS (
    SELECT
        region,
        YEAR(invoice_date) AS sales_year,
        MONTH(invoice_date) AS sales_month,
        SUM(total_sales) AS monthly_revenue
    FROM
        adidas_data
    WHERE
        YEAR(invoice_date) IN (2020, 2021)
    GROUP BY
        region, sales_year, sales_month
    ORDER BY
        region, sales_year, sales_month
),
revenue_with_change AS (
    SELECT
        region,
        sales_year,
        sales_month,
        monthly_revenue,
        LAG(monthly_revenue) OVER (
            PARTITION BY region, sales_year 
            ORDER BY sales_month
        ) AS previous_month_revenue
    FROM
        monthly_regional_revenue
)
SELECT
    region,
    sales_year,
    sales_month,
    monthly_revenue,
    previous_month_revenue,
    CASE
        WHEN previous_month_revenue IS NOT NULL THEN 
            ROUND(((monthly_revenue - previous_month_revenue) * 100.0 / previous_month_revenue), 2)
        ELSE NULL
    END AS percent_change
FROM
    revenue_with_change
ORDER BY
    region, sales_year, sales_month;


-- What are growth trends for units sold per region, month over month?

WITH regional_units_sold AS (
    SELECT
        region,
        YEAR(invoice_date) AS sales_year,
        MONTH(invoice_date) AS sales_month,
        SUM(units_sold) AS total_units_sold
    FROM
        adidas_data
    WHERE
        YEAR(invoice_date) IN (2020, 2021)
    GROUP BY
        region, sales_year, sales_month
    ORDER BY
        region, sales_year, sales_month
),
units_sold_with_change AS (
    SELECT
        region,
        sales_year,
        sales_month,
        total_units_sold,
        LAG(total_units_sold) OVER (
            PARTITION BY region, sales_year 
            ORDER BY sales_month
        ) AS previous_month_units_sold
    FROM
        regional_units_sold
)
SELECT
    region,
    sales_year,
    sales_month,
    total_units_sold,
    previous_month_units_sold,
    CASE
        WHEN previous_month_units_sold IS NOT NULL THEN 
            ROUND(((total_units_sold - previous_month_units_sold) * 100.0 / previous_month_units_sold), 2)
        ELSE NULL
    END AS percent_change
FROM
    units_sold_with_change
ORDER BY
    region, sales_year, sales_month;


-- What are the top five months in terms of total sales? (Can be used to find seasonality trends, increase bundling products and targeted marketing during these months).

SELECT
    YEAR(invoice_date) AS sales_year,
    MONTH(invoice_date) AS sales_month,
    SUM(total_sales) AS total_revenue
FROM
    adidas_data
GROUP BY
    sales_year, sales_month
ORDER BY
    total_revenue DESC
LIMIT 5;


-- What was the most popular product sold in each region?

WITH product_ranking AS (
    SELECT
        region,
        product,
        SUM(units_sold) AS total_units_sold,
        RANK() OVER (PARTITION BY region ORDER BY SUM(units_sold) DESC) AS product_rank
    FROM
        adidas_data
    GROUP BY
        region, product
)
SELECT
    region,
    product,
    total_units_sold
FROM
    ProductRanking
WHERE
    product_rank = 1
ORDER BY
    total_units_sold DESC;


-- Which regions were the most profitable, and what was their respective profit margin?

SELECT
    region,
    SUM(operating_profit) AS total_profit,
    ROUND(AVG(operating_margin), 2) AS average_operating_margin
FROM
    adidas_data
GROUP BY
    region
ORDER BY
    average_operating_margin DESC;



-- For each sale method, calculate which method was deemed the most popular amongst customers by finding total sales, units sold, and totals as percentages.

SELECT 
    sales_method,
    COUNT(*) AS total_orders,
    SUM(total_sales) AS total_sales,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM adidas_data)) * 100, 2) AS percentage_of_orders,
    ROUND((SUM(total_sales) / (SELECT SUM(total_sales) FROM adidas_data)) * 100, 2) AS percentage_of_sales
FROM
    adidas_data
GROUP BY sales_method
ORDER BY percentage_of_orders DESC;

    
-- Rank each sales method based on total units sold, on a monthly basis

WITH sales_method_rank AS (
    SELECT
        sales_method,
        YEAR(invoice_date) AS sales_year,
        MONTH(invoice_date) AS sales_month,
        SUM(units_sold) AS total_quantity_sold,
        DENSE_RANK() OVER (PARTITION BY YEAR(invoice_date), MONTH(invoice_date) ORDER BY SUM(units_sold) DESC) AS method_dense_rank
    FROM
        adidas_data
    GROUP BY
        sales_method, sales_year, sales_month
)
SELECT
    sales_method,
    sales_year,
    sales_month,
    total_quantity_sold,
    method_dense_rank
FROM
    sales_method_rank
ORDER BY
    sales_year, sales_month, method_dense_rank;


-- Highlight sales method monthly revenue, followed by month over month revenue growth.

WITH sales_method_revenue AS (
    SELECT
        sales_method,
        YEAR(invoice_date) AS sales_year,
        MONTH(invoice_date) AS sales_month,
        SUM(total_sales) AS total_revenue,
        LAG(SUM(total_sales)) OVER (PARTITION BY sales_method ORDER BY YEAR(invoice_date), MONTH(invoice_date)) AS previous_month_revenue
    FROM
        adidas_data
    GROUP BY
        sales_method, sales_year, sales_month
)
SELECT
    sales_method,
    sales_year,
    sales_month,
    total_revenue,
    CASE
        WHEN previous_month_revenue IS NOT NULL THEN 
            ROUND(((total_revenue - previous_month_revenue) * 100.0 / previous_month_revenue), 2)
        ELSE NULL
    END AS mom_growth_percentage
FROM
    sales_method_revenue
ORDER BY
    CASE
        WHEN sales_method = 'online' THEN 1
        WHEN sales_method = 'in-store' THEN 2
        ELSE 3
    END,
    sales_year, 
    sales_month;


-- What sales method was most profitable?

SELECT
    sales_method,
    SUM(operating_profit) AS total_profit,
    ROUND(AVG(operating_margin), 2) AS average_operating_margin
FROM
    adidas_data
GROUP BY
    sales_method
ORDER BY
    average_operating_margin DESC;


-- For each retailer, show number of orders, total sales, units sold, sale % and units sold %

SELECT 
    retailer,
    COUNT(*) AS number_of_orders,
    SUM(total_sales) AS total_sales,
    ROUND((SUM(total_sales) / (SELECT SUM(total_sales) FROM adidas_data)) * 100, 2) AS sales_percent,
    SUM(units_sold) AS total_units_sold,
    ROUND((SUM(units_sold) / (SELECT SUM(units_sold) FROM adidas_data)) * 100, 2) AS units_sold_percent
FROM
    adidas_data
GROUP BY 
    retailer
ORDER BY 
    total_sales DESC;


-- Month over month growth for each retailer's total sales and units sold

WITH monthly_stats AS (
    SELECT 
        retailer,
        YEAR(invoice_date) AS sales_year,
        MONTH(invoice_date) AS sales_month,
        SUM(total_sales) AS total_sales,
        SUM(units_sold) AS total_units_sold
    FROM
        adidas_data
    GROUP BY 
        retailer, sales_year, sales_month
),
stats_with_growth AS (
    SELECT 
        retailer,
        sales_year,
        sales_month,
        total_sales,
        total_units_sold,
        LAG(total_sales) OVER (PARTITION BY retailer ORDER BY sales_year, sales_month) AS previous_month_sales,
        LAG(total_units_sold) OVER (PARTITION BY retailer ORDER BY sales_year, sales_month) AS previous_month_units
    FROM 
        monthly_stats
)
SELECT 
    retailer,
    sales_year,
    sales_month,
    total_sales,
    ROUND(
        CASE 
            WHEN previous_month_sales IS NOT NULL THEN 
                ((total_sales - previous_month_sales) * 100.0 / previous_month_sales)
            ELSE NULL
        END, 2
    ) AS sales_mom_growth,
    total_units_sold,
    ROUND(
        CASE 
            WHEN previous_month_units IS NOT NULL THEN 
                ((total_units_sold - previous_month_units) * 100.0 / previous_month_units)
            ELSE NULL
        END, 2
    ) AS units_mom_growth
FROM 
    stats_with_growth
ORDER BY 
    retailer, sales_year, sales_month;


-- What retailer was most profitable? 

SELECT
    retailer,
    SUM(operating_profit) AS total_profit,
    ROUND(AVG(operating_margin), 2) AS average_operating_margin
FROM
    adidas_data
GROUP BY
    retailer
ORDER BY
    average_operating_margin DESC;
