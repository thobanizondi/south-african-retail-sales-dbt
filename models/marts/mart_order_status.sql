
{{ config(materialized = 'table') }}

SELECT
    order_status,

    COUNT(*) AS total_orders,
    SUM(total_sales) AS total_sales_value,
    AVG(total_sales) AS average_order_value,

    ROUND(
        SAFE_DIVIDE(
            COUNT(*) * 100.0,
            SUM(COUNT(*)) OVER ()
        ),
        2
    ) AS percentage_of_orders

FROM {{ ref('fct_retail_sales') }}
GROUP BY order_status
