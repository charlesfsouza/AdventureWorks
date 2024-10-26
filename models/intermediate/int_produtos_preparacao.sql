with
    produtos as (
        select *
        from {{ ref('stg_erp__product') }}
    )
    ,categorias as (
        select 
            pk_produto_categoria
            ,dsc_produto_categoria
        from {{ ref('stg_erp__productcategory') }}
    )
    ,categoria_not_informed as (
        select '-1' as pk_produto_categoria
        , 'Not informed' as dsc_produto_categoria
    )
    ,nova_categoria as (
        select 
            categorias.* 
        from categorias
        union all
        select 
            categoria_not_informed.* 
        from categoria_not_informed
    )
    ,subcategorias as (
        select 
            pk_produto_subcategoria
            ,fk_produto_categoria
            ,dsc_produto_subcategoria
        from {{ ref('stg_erp__productsubcategory') }}
    )
    ,subcategoria_not_informed as (
        select '-1' as pk_produto_subcategoria
        , '-1' as fk_produto_categoria
        , 'Not informed' as dsc_produto_subcategoria
    )
    ,nova_subcategoria as(
        select 
            subcategorias.* 
        from subcategorias
        union all
        select 
            subcategoria_not_informed.* 
        from subcategoria_not_informed
    )
    ,joined as (
        select  
            produtos.pk_produto
            ,produtos.dsc_produto
            ,nova_categoria.dsc_produto_categoria as dsc_categoria
            ,nova_subcategoria.dsc_produto_subcategoria as dsc_sub_categoria
        from produtos
        left join nova_subcategoria on nova_subcategoria.pk_produto_subcategoria = produtos.fk_produto_subcategoria
        left join nova_categoria on nova_categoria.pk_produto_categoria = nova_subcategoria.fk_produto_categoria

    )
 
select *
from joined