with
    status as (
        select distinct fk_status_pedido
        from {{ ref('stg_erp__salesorderheader') }}
    )

    , status_tratado as (
        select
            fk_status_pedido as fk_status
            ,case 
                when fk_status_pedido = 1 then 'In process'
                when fk_status_pedido = 2 then 'Approved'
                when fk_status_pedido = 3 then 'Backordered'
                when fk_status_pedido = 4 then 'Rejected'
                when fk_status_pedido = 5 then 'Shipped'
                when fk_status_pedido = 6 then 'Cancelled'
                else 'Not informed'
            end dsc_status
        from status

    )

select *
from status_tratado