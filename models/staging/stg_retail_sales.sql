
{{ config(materialized = 'view') }}

WITH cte_Source_data AS (

    SELECT DISTINCT *
    FROM {{ source('retail_source', 'raw_retail_sales') }}
    WHERE TRIM(order_id) != 'order_id'

),

cte_Cleaned_data AS (

    SELECT
        NULLIF(TRIM(order_id), '') AS order_id,

        {{ parse_retail_date('order_date') }} AS order_date,

        NULLIF(TRIM(customer_name), '') AS customer_name,
        LOWER(NULLIF(TRIM(customer_email), '')) AS customer_email,
        NULLIF(TRIM(product_name), '') AS product_name,
        INITCAP(NULLIF(TRIM(product_category), '')) AS product_category,

        SAFE_CAST(
            NULLIF(TRIM(quantity), '') AS NUMERIC
        ) AS quantity,

        SAFE_CAST(
            NULLIF(TRIM(unit_price), '') AS NUMERIC
        ) AS unit_price,

        INITCAP(NULLIF(TRIM(sales_region), '')) AS sales_region,
        INITCAP(NULLIF(TRIM(sales_channel), '')) AS sales_channel,
        UPPER(NULLIF(TRIM(order_status), '')) AS order_status,
        INITCAP(NULLIF(TRIM(sales_rep), '')) AS sales_rep

    FROM cte_Source_data

)

SELECT
    *,
    quantity * unit_price AS total_sales,

    CASE
        WHEN order_id IS NULL THEN 'Missing order ID'
        WHEN order_date IS NULL THEN 'Invalid order date'
        WHEN quantity IS NULL OR quantity <= 0 THEN 'Invalid quantity'
        WHEN unit_price IS NULL OR unit_price <= 0 THEN 'Invalid unit price'
        WHEN product_name IS NULL THEN 'Missing product name'
        ELSE 'Valid'
    END AS data_quality_status

FROM cte_Cleaned_data
