with
    fonte_produtos as (
        select *
        from {{ source('erp_adventureworks', 'product') }}
     )   

     ,renomeacao as (
        select

            cast(productid as int)  as pk_produto
            ,nvl(cast(productsubcategoryid as int),-1) as fk_produto_subcategoria
            ,cast(name as string) as dsc_produto
       
        from fonte_produtos
     )

select *
from renomeacao



