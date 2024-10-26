with
    cartao_credito as (
        select
            pk_cartao_credito
            ,dsc_tipo_cartao
        from {{ ref('stg_erp__creditcard') }}
    )
    ,transformado as (
        select
            pk_cartao_credito
            ,upper(dsc_tipo_cartao) as dsc_tipo_cartao
        from
            cartao_credito
    )

 
select *
from transformado