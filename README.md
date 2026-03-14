# dbt Course Projects

This repository contains two dbt projects developed as part of a dbt course, using **BigQuery** as the data warehouse.

## Prerequisites

- Python 3.x
- dbt-core
- dbt-bigquery

Install dependencies:

```bash
pip install -r requirements.txt
```

---

## Project 1: dbt_core_course

A foundational project covering core dbt concepts using the **Northwind** dataset.

### Structure

```
dbt_core_course/
├── models/
│   ├── staging/northwind/        # Source data preparation
│   │   └── stg_orders.sql        # Orders with shipping status logic
│   ├── intermediate/commercial/  # Business logic (ephemeral)
│   │   └── int_sales.sql         # Monthly freight aggregation
│   └── marts/commercial/         # Final consumption layer
│       ├── dimensions/
│       │   └── dim_clients.sql   # Client dimension
│       └── facts/
│           └── fct_sales.sql     # Sales fact table
├── seeds/                        # 15 CSV files (Northwind ERP data)
└── packages.yml                  # dbt_utils dependency
```

### Key Concepts Covered

- **Materializations:** `table` (staging/marts) and `ephemeral` (intermediate)
- **Sources:** Northwind data from BigQuery (`dat_seeds` schema)
- **Seeds:** Northwind reference data (customers, products, orders, employees, etc.)
- **Testing:** Schema tests (`unique`, `not_null`, `accepted_values`) and `dbt_utils.expression_is_true`
- **Packages:** `dbt-labs/dbt_utils`
- **Tags:** Layer-based tagging (`staging`, `intermediate`, `marts`, `commercial`, `seeds`)

---

## Project 2: dbt_second_project

An **e-commerce** data project demonstrating advanced dbt features.

### Structure

```
dbt_second_project/
├── models/
│   ├── staging/                      # Source preparation layer
│   │   ├── stg_avaliacoes.sql        # Product reviews
│   │   ├── stg_carrinho.sql          # Shopping cart
│   │   ├── stg_categorias.sql        # Product categories
│   │   ├── stg_clientes.sql          # Customers
│   │   ├── stg_itens_pedidos.sql     # Order items
│   │   ├── stg_pagamentos.sql        # Payments
│   │   ├── stg_pedidos.sql           # Orders (incremental)
│   │   ├── stg_produtos.sql          # Products
│   │   ├── var_example.sql           # Variable usage example
│   │   ├── hooks_example.sql         # Pre/post hooks example
│   │   ├── incremental_example.sql   # Basic incremental model
│   │   └── incremental_upsert.sql    # Incremental with upsert
│   ├── intermediate/
│   │   └── int_pedidos_realizados.sql  # Orders enrichment (joins)
│   └── marts/
│       └── fct_pedidos_realizados.sql  # Realized orders fact table
├── snapshots/
│   ├── clientes_phone.sql            # SCD Type 2 (timestamp strategy)
│   └── vendas.sql                    # SCD Type 2 (check strategy)
├── seeds/                            # 9 CSV files (e-commerce data)
└── tests/
    └── generic/
        └── test_valid_email.sql      # Custom email validation test
```

### Key Concepts Covered

#### Incremental Models
- **Append strategy:** `incremental_example.sql` — loads only new records based on last modified date
- **Upsert strategy:** `incremental_upsert.sql` — uses `unique_key` to update existing records or insert new ones
- **Incremental staging:** `stg_pedidos.sql` — real-world incremental pattern for orders

#### Snapshots (Slowly Changing Dimensions - Type 2)
- **Timestamp strategy:** `clientes_phone.sql` — tracks customer phone changes using `data_registro` column
- **Check strategy:** `vendas.sql` — detects changes by comparing all columns

#### Hooks
- **Pre-hook:** Creates a temporary staging table before model execution
- **Post-hook:** Drops the temporary table after model completion

#### Variables
- `environment` — controls environment-specific behavior (default: `development`)
- `minimal_date` — date filter for incremental loading (default: `2023-01-01`)

#### Custom Tests
- `test_valid_email` — generic test validating email format using SQL pattern matching

#### Data Modeling
- Full e-commerce pipeline: customers → orders → items → payments → reviews
- Intermediate model joins 6 source tables into a denormalized orders dataset

---

## Common Commands

```bash
# Run all models
dbt run

# Run a specific project
dbt run --project-dir dbt_core_course
dbt run --project-dir dbt_second_project

# Load seed data
dbt seed

# Run tests
dbt test

# Run snapshots
dbt snapshot

# Run models by tag
dbt run --select tag:staging

# Run a specific model
dbt run -s fct_sales

# Run all staging models
dbt run -s models/staging/*.sql

# Run incremental models in full-refresh mode
dbt run --full-refresh --select incremental_example

# Check connection and configuration
dbt debug

# Compile SQL without executing
dbt compile

# Build (run + test + snapshot + seed)
dbt build

# Install packages
dbt deps

# Clean target and dbt_packages directories
dbt clean

# Generate and serve documentation
dbt docs generate
dbt docs serve --host 127.0.0.1
```

---

## Resources

- [dbt Documentation](https://docs.getdbt.com/docs/introduction)
- [dbt Discourse](https://discourse.getdbt.com/)
- [dbt Community Slack](https://community.getdbt.com/)
