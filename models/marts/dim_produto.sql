with 
    detalhe_pedidos as (
        select distinct
            fk_produto
        from {{ ref('stg_erp__salesorderdetail') }}

    )
    ,produtos as (
        select *
        from {{ ref('stg_erp__product') }}
    )
    ,categorias as (
        select 
            pk_produto_categoria
            ,dsc_produto_categoria
        from {{ ref('stg_erp__productcategory') }}
    )
    ,subcategorias as (
        select 
            pk_produto_subcategoria
            ,fk_produto_categoria
            ,dsc_produto_subcategoria
        from {{ ref('stg_erp__productsubcategory') }}
    )
    ,joined as (
        select
            {{ dbt_utils.generate_surrogate_key(['detalhe_pedidos.fk_produto']) }} as sk_produto
            ,nvl(detalhe_pedidos.fk_produto,'-1') as pk_produto
            ,nvl(upper(produtos.dsc_produto),'NOT INFORMED') as dsc_produto
            ,nvl(upper(categorias.dsc_produto_categoria),'NOT INFORMED') as dsc_categoria
            ,nvl(upper(subcategorias.dsc_produto_subcategoria),'NOT INFORMED') as dsc_sub_categoria
        from
            detalhe_pedidos
        left join produtos on produtos.pk_produto = detalhe_pedidos.fk_produto
        left join subcategorias on subcategorias.pk_produto_subcategoria = produtos.fk_produto_subcategoria
        left join categorias on categorias.pk_produto_categoria = subcategorias.fk_produto_categoria
    )

select *
from joined