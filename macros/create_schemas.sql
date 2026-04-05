{% macro create_schemas() %}
  {% set schemas = ['staging', 'intermediate', 'marts'] %}
  {% for schema in schemas %}
    {% do run_query("CREATE SCHEMA IF NOT EXISTS " ~ schema) %}
  {% endfor %}
{% endmacro %}
