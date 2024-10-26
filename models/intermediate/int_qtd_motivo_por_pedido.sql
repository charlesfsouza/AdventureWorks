with
    -- a ideia é criar medidas distribuidas pela quantidade de motivos de cada pedido, para que ao fazer o join com a dimensao de pedidos
    -- a quantidade não ficar duplicada. 
    -- 

    qtd_motivo_por_pedido as (
        select 
            fk_pedido as pk_pedido
            ,count(distinct fk_motivo) qtd_motivo
        from {{ ref('stg_erp__salesorderheadersalesreason') }}
        group by 
            fk_pedido
    )

 
select *
from qtd_motivo_por_pedido