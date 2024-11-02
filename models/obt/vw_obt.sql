--criacao de one big table pois o looker studio nao permite uniao de mais de 5 tabelas
with
    fct_pedidos as (
        select *
        from {{ ref('fct_pedidos') }}

    ),
    dim_cartao_credito as (
        select *
        from {{ ref('dim_cartao_credito') }}

    ),    
    dim_cliente as (
        select *
        from {{ ref('dim_cliente') }}

    ),       
    dim_data as (
        select *
        from {{ ref('dim_data') }}

    ), 
    dim_endereco as (
        select *
        from {{ ref('dim_endereco') }}

    ),     
    dim_motivo_pedido as (
        select 
            sk_pedido_motivo
            ,pk_pedido_motivo
            ,fk_motivo
            ,dsc_motivo
            ,dsc_tipo
        from {{ ref('dim_motivo_pedido') }}

    ), 
    dim_produto as (
        select *
        from {{ ref('dim_produto') }}

    ),     
    dim_status as (
        select *
        from {{ ref('dim_status') }}

    ),
    joined as (
        select * from fct_pedidos 
            left join dim_cartao_credito on dim_cartao_credito.pk_cartao_credito = fct_pedidos.fk_cartao_credito
            left join dim_cliente on dim_cliente.pk_cliente = fct_pedidos.fk_cliente
            left join dim_data on dim_data.pk_data = fct_pedidos.fk_dat_pedido
            left join dim_endereco on dim_endereco.pk_endereco = fct_pedidos.fk_endereco_envio
            left join dim_motivo_pedido on dim_motivo_pedido.pk_pedido_motivo = fct_pedidos.fk_pedido_motivo
            left join dim_produto on dim_produto.pk_produto = fct_pedidos.fk_produto
            left join dim_status on dim_status.pk_status = fct_pedidos.fk_status_pedido
    )
select 
    sk_pedido_item
    ,pk_pedido_item
    ,fk_pedido
    ,fk_produto
    ,fk_status_pedido
    ,fk_cliente
    ,fk_endereco_envio
    ,fk_cartao_credito
    ,fk_pedido_motivo
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
    ,sk_cartao_credito
    ,pk_cartao_credito
    ,dsc_tipo_cartao
    ,sk_cliente
    ,pk_cliente
    ,fk_pessoa
    ,nom_cliente
    ,nom_loja
    ,pk_data
    ,data_anterior
    ,data_proxima
    ,dia_da_semana
    ,dsc_dia_da_semana
    ,dia_do_mes
    ,dia_do_ano
    ,semana_do_ano
    ,mes_do_ano
    ,dsc_mes_do_ano
    ,quadrimestre
    ,ano
    ,sk_endereco
    ,pk_endereco
    ,nom_cidade
    ,nom_provincia_estado
    ,nom_territorio
    ,nom_continente
    ,sgl_pais
    ,nom_pais
    ,nvl(dsc_motivo,'NOT INFORMED') as dsc_motivo
    ,nvl(dsc_tipo,'NOT INFORMED') as dsc_tipo
    ,sk_produto
    ,pk_produto
    ,dsc_produto
    ,dsc_categoria
    ,dsc_sub_categoria
    ,sk_status
    ,pk_status
    ,dsc_status 
from joined

