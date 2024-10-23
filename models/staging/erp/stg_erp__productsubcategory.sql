with
    fonte_produtos_subcategorias as (
        select *
        from {{ source('erp_adventureworks', 'productsubcategory') }}
     )   

     ,renomeacao as (
        select

            cast(productsubcategoryid as int)  as pk_produto_subcategoria
            ,cast(productcategory as int) as fk_produto_categoria
            ,cast(name as character) as dsc_produto_subcategoria
       
        from fonte_produtos_subcategorias
     )

select *
from renomeacao



