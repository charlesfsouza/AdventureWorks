with
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
    ,detalhes as (
        select
            pk_pedido_item
            ,fk_pedido
            ,fk_produto
            ,qtd_pedido_item
            ,vlr_item
            ,pct_desconto_item
        from {{ ref('stg_erp__salesorderdetail') }}
    )
    ,motivo_pedido as (
        select
            pk_motivo_pedido
            ,fk_motivo
            ,fk_pedido
        from {{ ref('stg_erp__salesorderheadersalesreason') }}
    )
    ,qtd_motivo_por_pedido as (
        select
            pk_pedido
            ,qtd_motivo
        from {{ ref('int_qtd_motivo_por_pedido') }}
    )
    ,qtd_itens_por_pedido as (
        select
            detalhes.fk_pedido
            ,sum(detalhes.qtd_pedido_item) as qtd_itens_por_pedido
        from detalhes
        group by detalhes.fk_pedido 

    )

    , metricas as (
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
            ,detalhes.pk_pedido_item as fk_pedido_item
            ,detalhes.fk_produto as fk_produto


            ,(pedidos.qtd_pedido / qtd_itens_por_pedido.qtd_itens_por_pedido) as qtd_pedido
            ,detalhes.qtd_pedido_item as qtd_item

            ,detalhes.vlr_item
            ,(detalhes.vlr_item * detalhes.pct_desconto_item) as vlr_desc
            ,(detalhes.vlr_item * detalhes.qtd_pedido_item) as vlr_negoc
            ,(detalhes.vlr_item * detalhes.qtd_pedido_item) * (1-detalhes.pct_desconto_item) as vlr_negoc_liq

          
            ,nvl(qtd_motivo_por_pedido.qtd_motivo,1) as qtd_pm

            ,nvl(motivo_pedido.pk_motivo_pedido,'-1') as fk_motivo_pedido


        from
            pedidos
        left join detalhes on detalhes.fk_pedido = pedidos.pk_pedido
        left join qtd_itens_por_pedido on qtd_itens_por_pedido.fk_pedido = pedidos.pk_pedido
        left join qtd_motivo_por_pedido on qtd_motivo_por_pedido.pk_pedido = pedidos.pk_pedido
        left join motivo_pedido on motivo_pedido.fk_pedido = pedidos.pk_pedido
      
    )
    , metricas_pm as ( -- criando as metricas por quantidade de motivo para calculo dos valores quando for feito join com a dimensao de motivos de pedido
        select 
            metricas.*
            , (metricas.qtd_pedido / metricas.qtd_pm) as qtd_pedido_pm
            , (metricas.qtd_item / metricas.qtd_pm) as qtd_item_pm
            , (metricas.vlr_desc / metricas.qtd_pm) as vlr_desc_pm
            , (metricas.vlr_negoc / metricas.qtd_pm) as vlr_negoc_pm
            , (metricas.vlr_negoc_liq / metricas.qtd_pm) as vlr_negoc_liq_pm

            
        from metricas


    )

    ,final as (
        select
             {{ dbt_utils.generate_surrogate_key(['pk_pedido','fk_pedido_item','fk_produto','fk_cliente'])}} as sk_pedido_item
            ,fk_pedido_item as pk_pedido_item
            ,pk_pedido as fk_pedido
            ,fk_produto
            ,fk_status_pedido
            ,fk_cliente
            ,fk_regiao
            ,fk_endereco_envio
            ,fk_cartao_credito
            ,fk_motivo_pedido

            ,fk_dat_pedido
            ,fk_dat_vencimento
            ,fk_dat_envio

            ,qtd_pedido
            ,qtd_item

            ,qtd_pedido_pm
            ,qtd_item_pm

            ,vlr_item
            ,vlr_desc
            ,vlr_negoc
            ,vlr_negoc_liq

            ,vlr_desc_pm
            ,vlr_negoc_pm
            ,vlr_negoc_liq_pm

        from metricas_pm
    )


select *
from final