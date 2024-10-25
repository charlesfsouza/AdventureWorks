with
    fonte_lojas as (
        select *
        from {{ source('erp_adventureworks', 'store') }}
     )   

     ,renomeacao as (
        select

            cast(businessentityid as int)  as pk_loja
            ,cast(salespersonid as int) as fk_vendedor
            ,cast(name as character) as dsc_loja           
       
        from fonte_lojas
     )

select *
from renomeacao



