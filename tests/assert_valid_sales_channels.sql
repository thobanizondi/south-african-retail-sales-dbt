
SELECT
    sales_channel

FROM {{ ref('fct_retail_sales') }}

WHERE sales_channel IS NULL
   OR sales_channel NOT IN (
       'Online',
       'Partner',
       'Call Centre',
       'In-Store',
       'Unknown'
   )
