with
    pedidos_motivos as (
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
            pedidos_motivos.pk_motivo_pedido
            ,pedidos_motivos.fk_pedido
            ,motivos.dsc_motivo
            ,motivos.dsc_motivo_tipo as dsc_tipo
        from pedidos_motivos
        left join motivos on motivos.pk_motivo = pedidos_motivos.fk_motivo
    )
 
select *
from joined