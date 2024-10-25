with
    status_pedidos as (
        select distinct fk_status_pedido as fk_status
        from {{ ref('stg_erp__salesorderheader') }}
    )
    ,status_ordem_compra as (
        select distinct fk_status_ordem_compra as fk_status
        from {{ ref('stg_erp__purchaseorderheader') }}
    )
    ,uniao as (
        select fk_status from status_pedidos
        union all select fk_status from status_ordem_compra
    )
    , status_tratado as (
        select distinct
            fk_status
            ,case 
                when fk_status = 1 then 'In process'
                when fk_status = 2 then 'Approved'
                when fk_status = 3 then 'Backordered'
                when fk_status = 4 then 'Rejected'
                when fk_status = 5 then 'Shipped'
                when fk_status = 6 then 'Cancelled'
                else 'Not informed'
            end dsc_status
        from uniao

    )

select *
from status_tratado