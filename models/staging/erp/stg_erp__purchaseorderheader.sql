with
    fonte as (
        select *
        from {{ source('erp_adventureworks', 'purchaseorderheader') }}
     )   

     ,renomeacao as (
        select

            cast(purchaseorderid as int)  as pk_ordem_compra
            ,cast(status as int) as fk_status_venda
       
        from fonte
     )

select *
from renomeacao



