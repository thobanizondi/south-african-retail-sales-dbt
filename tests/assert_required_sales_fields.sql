
SELECT *
FROM {{ ref('fct_retail_sales') }}
WHERE
    order_id IS NULL
    OR order_date IS NULL
    OR product_name IS NULL
    OR quantity IS NULL
    OR unit_price IS NULL
