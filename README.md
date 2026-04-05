# Data Warehouse with dbt and DuckDB

A SQL-focused data warehouse project using dbt and DuckDB for SaaS/Telemetry analytics.

## Architecture

```
models/
├── staging/         # Raw source data (views)
├── intermediate/   # Enriched data models
└── marts/          # Business metrics (tables)
    ├── dim_*.sql   # Dimension tables
    └── fact_*.sql  # Fact tables
```

## Quick Start

```bash
# Install dependencies
pip install dbt-duckdb

# Initialize dbt
dbt init

# Load seed data
dbt seed

# Run models
dbt run

# Run tests
dbt test

# Generate docs
dbt docs generate
dbt docs serve
```

## Models

| Model | Type | Description |
|-------|------|-------------|
| stg_events | View | Staged events |
| stg_users | View | Staged users |
| stg_subscriptions | View | Staged subscriptions |
| int_events_enriched | View | Events with user data |
| int_users_with_subscriptions | View | Users with subscription info |
| dim_users | Table | User dimension |
| dim_subscriptions | Table | Subscription dimension |
| dim_events | Table | Event dimension |
| fact_events | Table | Event fact table |
| fact_daily_metrics | Table | Daily aggregated metrics |

## Testing

```bash
dbt test                    # Run all tests
dbt test --select dim_users # Run specific tests
```
