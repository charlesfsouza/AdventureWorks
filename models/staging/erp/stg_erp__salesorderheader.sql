with
    fonte_pedidos as (
        select *
        from {{ source('erp_adventureworks', 'salesorderheader') }}
     )   

     ,renomeacao as (
        select

            cast(salesorderid as int) as pk_pedido
            ,cast(status as int) as fk_status_pedido
            ,cast(customerid as int) as fk_cliente
            ,cast(territoryid as int) as fk_regiao
            ,cast(creditcardid as int) as fk_cartao_credito
            ,cast(orderdate as date) as fk_dat_pedido
            ,cast(duedate as date) fk_dat_vencimento
            ,cast(shipdate as date) fk_dat_envio
            ,1 as qtd_pedido
        
        from fonte_pedidos
     )

select *
from renomeacao



