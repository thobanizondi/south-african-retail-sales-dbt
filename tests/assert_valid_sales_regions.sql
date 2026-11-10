
SELECT *
FROM {{ ref('fct_retail_sales') }}

WHERE sales_region NOT IN (
    'Gauteng',
    'Limpopo',
    'Western Cape',
    'Eastern Cape',
    'KwaZulu-Natal',
    'Unknown'
)
OR sales_region IS NULL
