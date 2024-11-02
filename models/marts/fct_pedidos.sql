with
    prep_pedidos as (
        select
             sk_pedido_item
            ,pk_pedido_item
            ,fk_pedido
            ,nvl(fk_produto,'-1') as fk_produto
            ,nvl(fk_status_pedido,'-1') as fk_status_pedido
            ,nvl(fk_cliente,'-1') as fk_cliente
            ,nvl(fk_endereco_envio,'-1') as fk_endereco_envio 
            ,nvl(fk_cartao_credito,'-1') as fk_cartao_credito 
            ,nvl(fk_motivo_pedido,'-1') as fk_motivo_pedido
            ,fk_dat_pedido
            ,fk_dat_vencimento
            ,fk_dat_envio
            ,qtd_pedido
            ,qtd_item
            ,vlr_unitario
            ,pct_desconto_item
            ,vlr_desc
            ,vlr_negoc
            ,vlr_negoc_liq
        from {{ ref('int_preparacao_fato_pedidos') }}

    )

select *
from prep_pedidos