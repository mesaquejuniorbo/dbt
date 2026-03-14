{{
    config(
        pre_hook=[
            "CREATE TABLE IF NOT EXISTS {{ this.database }}.{{ this.schema }}.temp_clientes AS SELECT * FROM {{ ref('stg_clientes') }}"
        ],
        post_hook=[
            "DROP TABLE IF EXISTS {{ this.database }}.{{ this.schema }}.temp_clientes"
        ]
    )
}}

select
    *
from {{ this.database }}.{{ this.schema }}.temp_clientes
