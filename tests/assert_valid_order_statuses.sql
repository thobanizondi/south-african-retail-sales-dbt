
SELECT *
FROM {{ ref('fct_retail_sales') }}

WHERE order_status NOT IN (
    'COMPLETED',
    'PENDING',
    'CANCELLED',
    'RETURNED',
    'UNKNOWN',
    'MISSING'
)
OR order_status IS NULL
