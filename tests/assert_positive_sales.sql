
SELECT
    order_id,
    quantity,
    unit_price,
    total_sales

FROM {{ ref('fct_retail_sales') }}
WHERE
    quantity <= 0
    OR unit_price <= 0
    OR total_sales <= 0
    OR total_sales IS NULL
