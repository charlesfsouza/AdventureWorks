with
    fonte_motivo_pedido as (
        select *
        from {{ source('erp_adventureworks', 'salesorderheadersalesreason') }}
     )   

     ,renomeacao as (
        select

            cast(salesorderid || salesreasonid as int) pk_motivo_pedido
            ,cast(salesreasonid as int)  as fk_motivo
            ,cast(salesorderid as int) as fk_pedido
       
        from fonte_motivo_pedido
     )

select *
from renomeacao



