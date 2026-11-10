# South African Retail Sales Analytics Pipeline

## Project Overview

This project demonstrates a retail analytics ELT pipeline using Google BigQuery and dbt Cloud.

The objective is to take a messy retail sales dataset, clean and transform the data, apply data quality checks, and build analytical models that support business reporting and decision-making.

The dataset contains South African retail sales information, including orders, customers, products, sales regions, sales channels and order statuses.

## Technologies Used

- Google BigQuery - Cloud data warehouse and SQL execution.
- dbt Cloud - Data transformation, modelling and testing.
- SQL - Data cleaning, validation, transformation and aggregation.
- GitHub - Version control and project documentation.
- Power BI - Planned reporting and visualisation stage.

## Data Pipeline Architecture

The project follows an ELT approach:

1. Extract the raw retail sales CSV dataset.
2. Load the source data into a raw BigQuery table.
3. Transform and clean the data using dbt.
4. Apply data quality tests.
5. Build fact and analytical mart tables for reporting.

## Data Cleaning and Quality

The raw dataset contains common data quality issues:

- Duplicate records.
- Missing values.
- Invalid date formats.
- Non-numeric and invalid quantities.
- Invalid unit prices.
- Inconsistent naming and casing.
- Inconsistent sales region and channel values.
- Missing and unknown order statuses.

The staging model applies:

- Exact duplicate removal.
- Filtering of the imported CSV header row.
- Text standardisation.
- Safe date parsing.
- Safe numeric casting.
- Total sales calculation.
- Data quality status classification.

Invalid records are retained in staging for investigation rather than silently discarded.

The fact model includes records classified as valid under the defined data quality rules.

## dbt Data Models

### Staging

| Model | Description |
|---|---|
| `stg_retail_sales` | Cleans, standardises and validates raw retail sales data. |

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

| Data quality status | Records |
|---|---:|
| Valid | 2,387 |
| Invalid unit price | 30 |
| Missing product name | 29 |
| Invalid quantity | 29 |
| Invalid order date | 25 |
| **Total** | **2,500** |

The classifications use a priority-based CASE statement. Each record receives its first matching issue, so the categories are mutually exclusive.

## Custom SQL Tests

Standalone SQL tests are maintained in the `tests/` directory. These tests return failing records when a business rule is violated. A test passes when it returns zero rows.

| Test file | Validation |
|---|---|
| `assert_positive_sales.sql` | Checks that quantities, unit prices and total sales are positive. |
| `assert_required_sales_fields.sql` | Checks that required fact table fields are populated. |
| `assert_sales_calculation.sql` | Checks that total sales equals quantity multiplied by unit price. |
| `assert_valid_sales_channels.sql` | Checks standardised sales channel values. |
| `assert_valid_sales_regions.sql` | Checks standardised sales region values. |
| `assert_valid_order_statuses.sql` | Checks allowed order status values. |

The project also includes YAML-based dbt tests for source and staging model validation.

## Business Insights

The fact model contains 2,387 records classified as valid under the project's data quality rules.

Key findings:

- Recorded sales value: R121,488,702.88.
- Average sales value per record: R50,895.98.
- Total units sold: 9,566.
- Highest sales value by region: Limpopo, R25,828,856.27.
- Highest sales value by product category: Electronics, R32,188,506.50.
- Highest sales value by sales channel: Online, R32,858,587.70.
- Strongest month: June 2025, with R13,679,464.44 in recorded sales value.

These are recorded sales values across different order statuses, including completed, pending, cancelled and returned orders. They should not be interpreted as recognised revenue.

## Model Validation Results

The five fact and mart models were successfully materialised and checked in BigQuery.

| Model | Records |
|---|---:|
| `fct_retail_sales` | 2,387 |
| `mart_monthly_sales` | 810 |
| `mart_product_performance` | 51 |
| `mart_order_status` | 6 |
| `mart_sales_overview` | 1 |

## Future Improvements

- Connect analytical marts to Power BI.
- Build an interactive sales performance dashboard.
- Expand automated data quality testing.
- Add dbt documentation and model lineage.
- Improve data quality monitoring.

## Skills Demonstrated

SQL development, Google BigQuery, dbt Cloud, ELT pipelines, data cleaning, data quality validation, dimensional modelling, analytical data marts, business analysis and GitHub version control.

