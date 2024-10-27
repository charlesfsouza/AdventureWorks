with
    pedidos as (
        select distinct
                fk_cartao_credito
        from {{ ref('stg_erp__salesorderheader') }}

    )
    ,cartao_credito as (
        select
            pk_cartao_credito
            ,dsc_tipo_cartao
        from {{ ref('stg_erp__creditcard') }}
    )
    ,joined as (
        select
            {{ dbt_utils.generate_surrogate_key(['pedidos.fk_cartao_credito']) }} as sk_cartao_credito
            ,nvl(pedidos.fk_cartao_credito,'-1') as fk_cartao_credito
            ,nvl(upper(cartao_credito.dsc_tipo_cartao),'NOT INFORMED') as dsc_tipo_cartao
        from
            pedidos
        left join cartao_credito on cartao_credito.pk_cartao_credito = pedidos.fk_cartao_credito
    )

 
select *
from joined