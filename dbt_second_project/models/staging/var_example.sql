select
    *
from {{ source('ecommerce', 'pedidos') }}
where data_pedido >= '{{ var("minimal_date", "2023-01-01") }}'
