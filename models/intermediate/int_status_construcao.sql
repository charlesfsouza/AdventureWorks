with
    status_pedidos as (
        select distinct fk_status_pedido
        from {{ ref('stg_erp__salesorderheader') }}
    )
    ,status_ordem_compra as (
        select distinct fk_status_ordem_compra
        from {{ ref('stg_erp__purchaseorderheader') }}
    )
    ,uniao as (
        select distinct fk_status_pedido as fk_status from status_pedidos
        union all select distinct fk_status_ordem_compra as fk_status from status_ordem_compra
    )
    , status_tratado as (
        select distinct
            fk_status
            ,case 
                when fk_status_pedido = 1 then 'In process'
                when fk_status_pedido = 2 then 'Approved'
                when fk_status_pedido = 3 then 'Backordered'
                when fk_status_pedido = 4 then 'Rejected'
                when fk_status_pedido = 5 then 'Shipped'
                when fk_status_pedido = 6 then 'Cancelled'
                else 'Not informed'
            end dsc_status
        from uniao

    )

select *
from status_tratado