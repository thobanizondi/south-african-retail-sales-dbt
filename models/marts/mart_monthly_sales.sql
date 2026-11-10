{{ config(materialized = 'table') }}

SELECT
    DATE_TRUNC(order_date, MONTH) AS sales_month,
    sales_region,
    sales_channel,
    product_category,

    COUNT(*) AS total_orders,
    SUM(quantity) AS total_units_sold,
    SUM(total_sales) AS total_sales_value,
    AVG(total_sales) AS average_order_value

FROM {{ ref('fct_retail_sales') }}
GROUP BY
    sales_month,
    sales_region,
    sales_channel,
    product_category