select
    {{ dbt_utils.star(from=source('ecommerce', 'clientes'), except=['id']) }}
from {{ source('ecommerce', 'clientes') }}
