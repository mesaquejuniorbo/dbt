{{
    config(
        tags=['vendas']
    )
}}

with pedidos as (
    select
        *
    from {{ ref('stg_pedidos') }}
),

clientes as (
    select 
        *
    from {{ ref('stg_clientes') }}
),

itens_pedidos as (
    select
        *
    from {{ ref('stg_itens_pedidos') }}
),

produtos as (
    select
        *
    from {{ ref('stg_produtos') }}
),

pagamentos as (
    select
        *
    from {{ ref('stg_pagamentos') }}
),

categorias as (
    select
        *
    from {{ ref('stg_categorias') }}
),

joined as (
    select
        pe.data_pedido,
        cl.nome as nome_cliente,
        cl.email,
        pg.valor,
        pg.metodo,
        pg.status,
        pg.data_pagamento,
        pr.nome as nome_produto,
        ct.nome as nome_categoria,
        ip.quantidade,
        ip.preco_unitario
    from pedidos pe
    left join clientes cl on pe.cliente_id = cl.id
    left join pagamentos pg on pe.id = pg.pedido_id
    left join itens_pedidos ip on pe.id = ip.pedido_id
    left join produtos pr on ip.produto_id = pr.id
    left join categorias ct on pr.categoria_id = ct.id
)

select
    *
from joined
