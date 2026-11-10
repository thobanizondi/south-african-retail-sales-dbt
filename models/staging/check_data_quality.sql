SELECT
    data_quality_status,
    COUNT(*) AS total_records
FROM `gen-lang-client-0468502932.dbt_tzondi_sa.stg_retail_sales`
GROUP BY data_quality_status
ORDER BY total_records DESC;