
{{ config(materialized = 'table') }}

SELECT
    product_name,
    product_category,

    COUNT(*) AS total_orders,
    SUM(quantity) AS total_units_sold,
    SUM(total_sales) AS total_sales_value,
    AVG(total_sales) AS average_order_value,
    AVG(unit_price) AS average_unit_price

FROM {{ ref('fct_retail_sales') }}
GROUP BY
    product_name,
    product_category
