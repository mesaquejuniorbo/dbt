{{
    config(
        tags=['commercial'],
        docs={'node_color': '#0099ff'}
    )
}}

with sales as (
    select
        *
    from {{ ref('int_sales')}}
)

select
    *
from sales
