{{
    config (
        tags=['commercial']
    )
}}

with orders as (
    select
        extract(month from order_date) as month,
        extract(year from order_date) as year,
        freight as total_freight
    from {{ ref('stg_orders') }}
),

sales as (
    select
        month,
        year,
        sum(total_freight) as total_freight
    from orders
    group by month, year
)

select
    *
from sales
