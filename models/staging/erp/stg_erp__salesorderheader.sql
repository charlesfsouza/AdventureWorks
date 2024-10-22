with
    fonte_pedidos as (
        select *
        from {{ source('erp_adventureworks', 'salesorderheader') }}
     )   

     ,renomeacao as (
        select

            cast(SALESORDERID as int) as pk_pedido
            ,cast(STATUS as int) as fk_status_pedido
            ,cast(CUSTOMERID as int) as fk_cliente
            ,cast(TERRITORYID as int) as fk_regiao
            ,cast(CREDITCARDID as int) as fk_cartao_credito
            ,cast(ORDERDATE as date) as fk_dat_pedido
            ,cast(DUEDATE as date) fk_dat_vencimento
            ,cast(SHIPDATE as date) fk_dat_envio
            ,1 as qtd_pedido
        
        from fonte_pedidos
     )

select *
from renomeacao



