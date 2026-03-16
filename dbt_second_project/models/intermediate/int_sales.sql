{{
    config(
        tags=['sales']
    )
}}
with pedidos as (
    select
        *
    from {{ ref('stg_pedidos') }}
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
)
select
    ip.pedido_id,
    ip.produto_id,
    pr.nome as nome_produto,
    ip.quantidade,
    ip.preco_unitario,
    (ip.quantidade * ip.preco_unitario) as preco_total
from pedidos pd
join itens_pedidos ip on pd.id = ip.pedido_id
join produtos pr on ip.produto_id = pr.id
