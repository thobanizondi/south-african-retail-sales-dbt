# South African Retail Sales Analytics Pipeline

## Project Overview

This project demonstrates an end-to-end retail analytics pipeline using Google BigQuery and dbt Cloud.

The goal was to take an intentionally messy retail sales dataset, clean and transform the data, apply data quality checks, and build analytical models that support business reporting and decision-making.

The dataset contains South African retail sales information, including orders, customers, products, sales regions, sales channels and order statuses.

## Technologies Used

- **Google BigQuery** - Cloud data warehouse and SQL execution.
- **dbt Cloud** - Data transformation, modelling and testing.
- **SQL** - Data cleaning, validation, transformation and aggregation.
- **GitHub** - Version control and project documentation.
- **Power BI** - Planned for the reporting and visualisation stage.

## Data Pipeline Architecture

The project follows a simple ELT (Extract, Load, Transform) approach:

1. **Extract:** Obtain the raw retail sales CSV dataset.
2. **Load:** Load the source data into a raw BigQuery table.
3. **Transform:** Use dbt to clean, standardise and transform the data.
4. **Test:** Apply data quality tests to validate key fields and quality classifications.
5. **Model:** Build fact and analytical mart tables for reporting.

## Data Cleaning and Quality

The raw dataset contains common data quality issues, including:

- Duplicate records.
- Missing values.
- Invalid date formats.
- Non-numeric and invalid quantities.
- Invalid unit prices.
- Inconsistent naming and casing.
- Inconsistent sales region and channel values.
- Missing and unknown order statuses.

The staging model applies transformations such as:

- Removing exact duplicate records.
- Filtering out the accidentally imported CSV header row.
- Standardising text fields.
- Converting dates using safe date parsing.
- Converting numeric fields using safe casting.
- Calculating total sales values.
- Assigning data quality statuses to records.

Invalid records are retained in the staging layer for investigation rather than silently discarded.

The fact model includes records classified as valid by the defined data quality rules.

## dbt Data Models

### Staging

| Model | Description |
|---|---|
| `stg_retail_sales` | Cleans, standardises and validates the raw retail sales data. |

### Fact and Analytical Marts

| Model | Description |
|---|---|
| `fct_retail_sales` | Stores cleaned sales records for analytical use. |
| `mart_monthly_sales` | Summarises sales by month, region, channel and product category. |
| `mart_product_performance` | Provides product-level sales and quantity metrics. |
| `mart_order_status` | Analyses sales records by order status. |
| `mart_sales_overview` | Provides overall sales and business performance KPIs. |

## Data Quality Results

After removing exact duplicates and the imported header row, the staging model contained 2,500 records.

The data quality classification produced the following results:

| Data quality status | Records |
|---|---:|
| Valid | 2,387 |
| Invalid unit price | 30 |
| Missing product name | 29 |
| Invalid quantity | 29 |
| Invalid order date | 25 |
| **Total** | **2,500** |

The classifications follow a priority-based CASE statement. Each record receives its first matching issue, so the categories are mutually exclusive.

## Business Insights

The fact model contains 2,387 records classified as valid under the project's data quality rules.

Key findings include:

- **Recorded sales value:** R121,488,702.88.
- **Average sales value per record:** R50,895.98.
- **Units sold:** 9,566.
- **Top-performing region by recorded sales value:** Limpopo, with R25,828,856.27.
- **Top-performing product category:** Electronics, with R32,188,506.50.
- **Top-performing sales channel:** Online, with R32,858,587.70.
- **Strongest month:** June 2025, with R13,679,464.44 in recorded sales value.

These are recorded sales values across different order statuses, including completed, pending, cancelled and returned orders. They should not be interpreted as recognised revenue.

## Validation and Testing

dbt data tests were executed successfully.

The configured tests include:

- `not_null` validation for the staging order ID.
- `accepted_values` validation for data quality status classifications.
- Source-level order ID validation.

**Test result:** 3 tests passed with no failures.

All five fact and mart models were also successfully materialised and checked in BigQuery.

## Project Results

| Model | Records |
|---|---:|
| `fct_retail_sales` | 2,387 |
| `mart_monthly_sales` | 810 |
| `mart_product_performance` | 51 |
| `mart_order_status` | 6 |
| `mart_sales_overview` | 1 |

## Future Improvements

- Connect the analytical marts to Power BI.
- Build an interactive sales performance dashboard.
- Expand dbt tests across the fact and mart models.
- Add dbt documentation and model lineage.
- Improve monitoring of data quality issues.

## Skills Demonstrated

SQL development, Google BigQuery, dbt Cloud, ELT pipelines, data cleaning, data quality validation, dimensional modelling, analytical data marts, business analysis and GitHub version control.

