with
    produtos as (
        select *
        from {{ ref('stg_erp__product') }}
    )
    ,categorias as (
        select *
        from {{ ref('stg_erp__productcategory') }}
    )
    ,subcategorias as (
        select *
        from {{ ref('stg_erp__productsubcategory') }}
    )
    ,joined as (
        select  
            produtos.*
            ,categorias.dsc_produto_categoria as dsc_categoria
            ,subcategorias.dsc_produto_subcategoria as dsc_sub_categoria
        from produtos
        left join subcategorias on subcategorias.pk_produto_subcategoria = produtos.fk_produto_subcategoria
        left join categorias on categorias.pk_produto_categoria = fk_produto_categoria

    )
 
select *
from joined