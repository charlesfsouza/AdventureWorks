with
    /* 
    As tabelas 'detalhes do pedido' (salesorderdetail) e 'motivos do pedido' (salesorderheadersalesreason) 
    estão relacionadas a uma tabela principal de 'pedidos de venda' (stg_erp__salesorderheader) de forma que 
    um pedido pode ter múltiplos itens e motivos. 
    Ao calcular métricas como o valor total das vendas, é crucial evitar a dupla contagem de pedidos. 
    Para isso, é necessário aplicar método para segregar as métricas / medidas, de forma que
    a soma das quantidades agregadas resultem em valores corretos
    
    */
    pedidos as (
        select
            pk_pedido
            ,fk_status_pedido
            ,fk_cliente
            ,fk_regiao
            ,fk_endereco_envio
            ,fk_cartao_credito
            ,fk_dat_pedido
            ,fk_dat_vencimento
            ,fk_dat_envio
            ,qtd_pedido
        from {{ ref('stg_erp__salesorderheader') }}

    )
    ,itens_pedido as (
        select
            pk_pedido_item
            ,fk_pedido
            ,fk_produto
            ,qtd_pedido_item
            ,vlr_item
            ,pct_desconto_item
        from {{ ref('stg_erp__salesorderdetail') }}
    )
    ,motivos_pedido as (
        select
            --pk_motivo_pedido
            fk_motivo
            ,fk_pedido
        from {{ ref('stg_erp__salesorderheadersalesreason') }}
    )

    ,qtd_itens_por_pedido as (
        select
            fk_pedido
            ,count(distinct pk_pedido_item) as qtd_item
        from itens_pedido
        group by fk_pedido 

    )
    ,qtd_motivos_por_pedido as (
        select
            fk_pedido
            ,count(distinct fk_motivo) qtd_motivo
        from motivos_pedido
        group by fk_pedido
    )

    ,joined as (

        select
            pedidos.pk_pedido
           ,pedidos.fk_status_pedido
           ,pedidos.fk_cliente
           ,pedidos.fk_regiao
           ,pedidos.fk_endereco_envio
           ,pedidos.fk_cartao_credito
           ,pedidos.fk_dat_pedido
           ,pedidos.fk_dat_vencimento
           ,pedidos.fk_dat_envio
           ,pedidos.qtd_pedido

           ,nvl(itens_pedido.pk_pedido_item,'-1') as fk_pedido_item
           ,nvl(itens_pedido.fk_produto,'-1') as fk_produto
           ,nvl(itens_pedido.qtd_pedido_item,'0') as qtd_item
           ,nvl(itens_pedido.vlr_item,'0') as vlr_unitario
           ,nvl(itens_pedido.pct_desconto_item,'0') as pct_desconto_item

           ,nvl(qtd_itens_por_pedido.qtd_item,'-1') as qtd_item_pedido            
           ,nvl(motivos_pedido.fk_pedido,'-1') as fk_pedido_motivo         
           ,nvl(qtd_motivos_por_pedido.qtd_motivo,'1') as qtd_motivo_pedido

        from
            pedidos
        left join itens_pedido on itens_pedido.fk_pedido = pedidos.pk_pedido
        left join motivos_pedido on motivos_pedido.fk_pedido = pedidos.pk_pedido
        left join qtd_itens_por_pedido on qtd_itens_por_pedido.fk_pedido = pedidos.pk_pedido
        left join qtd_motivos_por_pedido on qtd_motivos_por_pedido.fk_pedido = pedidos.pk_pedido


    )

    ,metricas_por_item as (
        select
            joined.*
            ,(qtd_pedido / qtd_item_pedido) as qtd_pedido_pi
        from joined
    )

    ,metricas_por_motivo as (
        select
            metricas_por_item.*
            ,(qtd_pedido_pi / qtd_motivo_pedido) qtd_pedido_pm
            ,(qtd_item / qtd_motivo_pedido) as qtd_item_pm
            --,(vlr_unitario / qtd_motivo_pedido) as vlr_unitario_pm

         from
            metricas_por_item
    )
    ,metricas_compostas as (
        select
            metricas_por_motivo.*
            ,(vlr_unitario * pct_desconto_item) as vlr_desc_pm
            ,(vlr_unitario * qtd_item_pm) as vlr_negoc_pm
            ,((vlr_unitario * qtd_item_pm) * (1-pct_desconto_item)) as vlr_negoc_liq_pm

        from 
            metricas_por_motivo

    )

    ,final as (
        select
             {{ dbt_utils.generate_surrogate_key(['pk_pedido','fk_pedido_item','fk_produto','fk_cliente','fk_pedido_motivo','fk_motivo'])}} as sk_pedido_item
            ,fk_pedido_item as pk_pedido_item
            ,pk_pedido as fk_pedido
            ,fk_produto
            ,fk_status_pedido
            ,fk_cliente
            ,fk_endereco_envio
            ,fk_cartao_credito
            ,fk_pedido_motivo

            ,fk_dat_pedido
            ,fk_dat_vencimento
            ,fk_dat_envio


            ,qtd_pedido_pm as qtd_pedido
            ,qtd_item_pm as qtd_item

            ,vlr_unitario
            ,pct_desconto_item

            ,vlr_desc_pm as vlr_desc
            ,vlr_negoc_pm as vlr_negoc
            ,vlr_negoc_liq_pm vlr_negoc_liq

        from metricas_compostas
    )


select *
from final