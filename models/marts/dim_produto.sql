with
    produtos as (
        select
            pk_produto
            ,dsc_produto
            ,dsc_categoria
            ,dsc_sub_categoria
        from {{ ref('int_produtos_preparacao') }}
    )
    ,transformado as (
        select
            pk_produto
            ,upper(dsc_produto) as dsc_produto
            ,upper(dsc_categoria) as dsc_categoria
            ,upper(dsc_sub_categoria) as dsc_sub_categoria
        from
            produtos
    )

 
select *
from transformado