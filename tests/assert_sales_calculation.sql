
SELECT
    order_id,
    quantity,
    unit_price,
    total_sales

FROM {{ ref('fct_retail_sales') }}

WHERE total_sales != quantity * unit_price
   OR total_sales IS NULL
