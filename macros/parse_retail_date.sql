
{% macro parse_retail_date(column_name) %}

    COALESCE(
        SAFE.PARSE_DATE('%Y-%m-%d', TRIM({{ column_name }})),
        SAFE.PARSE_DATE('%d/%m/%Y', TRIM({{ column_name }})),
        SAFE.PARSE_DATE('%m/%d/%Y', TRIM({{ column_name }}))
    )

{% endmacro %}
