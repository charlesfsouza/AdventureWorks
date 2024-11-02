with
    pedidos as (
        select distinct
            pk_pedido
        from {{ ref('stg_erp__salesorderheader') }}

    )
    ,pedidos_motivos as (
        select
            pk_motivo_pedido
            ,fk_motivo
            ,fk_pedido
        from {{ ref('stg_erp__salesorderheadersalesreason') }}
    )
    ,motivos as (
        select 
            pk_motivo
            ,dsc_motivo
            ,dsc_motivo_tipo
        from {{ ref('stg_erp__salesreason') }}
    )
    ,joined as (
        select
            {{ dbt_utils.generate_surrogate_key(['pedidos_motivos.pk_motivo_pedido']) }} as sk_pedido_motivo
            --,pedidos_motivos.pk_motivo_pedido as fk_motivo_pedido
            ,pedidos.pk_pedido as pk_pedido_motivo
            ,nvl(motivos.pk_motivo,'-1') as fk_motivo
            ,nvl(upper(motivos.dsc_motivo),'NOT INFORMED') as dsc_motivo
            ,nvl(upper(motivos.dsc_motivo_tipo),'NOT INFORMED') as dsc_tipo
        from pedidos
        left join pedidos_motivos on pedidos_motivos.fk_pedido = pedidos.pk_pedido
        left join motivos on motivos.pk_motivo = pedidos_motivos.fk_motivo
    )
 
select *
from joined