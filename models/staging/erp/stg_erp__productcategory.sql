with
    fonte_produtos_categorias as (
        select *
        from {{ source('erp_adventureworks', 'productcategory') }}
     )   

     ,renomeacao as (
        select

            cast(productcategoryid as int)  as pk_produto_categoria
            ,cast(name as string) as dsc_produto_categoria
       
        from fonte_produtos_categorias
     )

select *
from renomeacao



