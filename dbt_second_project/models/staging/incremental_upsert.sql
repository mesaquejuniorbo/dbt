{{
    config(
        materialized='incremental',
        unique_key='id'
    )
}}

with atualizacoes as (
    select
        id,
        cliente_id,
        endereco_id,
        data_pedido,
        status
    from {{ source('ecommerce', 'pedidos') }}
    {% if is_incremental() %}
        where data_pedido >= (select max(data_pedido) from {{this}} )
    {% endif %}
)

select
    *
from atualizacoes
