
{{ config(materialized = 'table') }}

SELECT

    COUNT(*) AS total_orders,

    SUM(total_sales) AS total_sales_value,

    AVG(total_sales) AS average_order_value,

    SUM(quantity) AS total_units_sold,

    COUNT(DISTINCT sales_region) AS total_sales_regions,

    COUNT(DISTINCT sales_channel) AS total_sales_channels,

    COUNT(DISTINCT product_category) AS total_product_categories

FROM {{ ref('fct_retail_sales') }}
