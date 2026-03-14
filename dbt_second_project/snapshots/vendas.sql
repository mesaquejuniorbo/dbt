{% snapshot vendas_snapshot %}

{{
    config(
        schema='snapshots',
        tags=['snapshots'],
        strategy='check',
        unique_key='id',
        check_cols='all'
    )
}}

select
    id,
    data_pedido,
    status,
    endereco_id
from {{ source('ecommerce', 'pedidos') }}

{% endsnapshot %}


