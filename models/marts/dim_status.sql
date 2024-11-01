with
    pedidos as (
        select distinct
            fk_status_pedido
        from {{ ref('stg_erp__salesorderheader') }}

    )
    ,status as (
        select
            pk_status
            ,dsc_status
        from {{ ref('int_status_construcao') }}
    )
    ,joined as (
        select
            {{ dbt_utils.generate_surrogate_key(['pedidos.fk_status_pedido']) }} as sk_status            
            ,nvl(pedidos.fk_status_pedido,'-1') as pk_status
            ,nvl(upper(dsc_status),'NOT INFORMED') as dsc_status
        from
            pedidos
        left join status on status.pk_status = pedidos.fk_status_pedido
    )

 
select *
from joined