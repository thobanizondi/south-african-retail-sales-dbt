
{{ config(materialized = 'table') }}

SELECT

    order_id,
    order_date,
    product_name,

    COALESCE(product_category, 'Unknown') AS product_category,

    quantity,
    unit_price,
    total_sales,

    CASE
    WHEN LOWER(
        REPLACE(
            REPLACE(TRIM(sales_region), '-', ''),
            ' ',
            ''
        )
    ) = 'kwazulunatal'
        THEN 'KwaZulu-Natal'

    WHEN sales_region IS NULL
        THEN 'Unknown'

    ELSE sales_region
    END AS sales_region,

    CASE
    WHEN LOWER(TRIM(sales_channel)) IN ('web', 'online')
        THEN 'Online'
    WHEN sales_channel IS NULL
        THEN 'Unknown'
    ELSE sales_channel
    END AS sales_channel,
    COALESCE(order_status, 'MISSING') AS order_status,
    COALESCE(sales_rep, 'Unknown') AS sales_rep

FROM {{ ref('stg_retail_sales') }}

WHERE data_quality_status = 'Valid'

