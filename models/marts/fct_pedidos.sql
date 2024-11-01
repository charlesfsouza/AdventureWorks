with
    prep_pedidos as (
        select
             sk_pedido_item
            ,pk_pedido_item
            ,fk_pedido
            ,fk_produto
            ,fk_status_pedido
            ,fk_cliente
            ,fk_endereco_envio
            ,fk_cartao_credito
            ,fk_motivo_pedido
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