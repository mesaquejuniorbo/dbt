{{
    config(
        tags=['vendas']
    )
}}

with pedidos as (
    select
        *
    from {{ ref('int_pedidos_realizados') }}
)

select
    *
from pedidos
