with
    pedidos as (
        select distinct
                fk_endereco_envio
                ,fk_regiao
        from {{ ref('stg_erp__salesorderheader') }}

    )
    ,pedidos_territorio as (
        select
            *
        from {{ ref('stg_erp__salesterritory') }}
    )
    ,enderecos as (
        select
            *
        from {{ ref('stg_erp__address') }}        
    )
    ,estados as (
        select
            *
        from {{ ref('stg_erp__stateprovince') }}        
    )
    ,paises as (
        select
            *
        from {{ ref('stg_erp__countryregion') }}        
    )
    ,joined as (
        select
            *
        from
            pedidos
    )

 
select *
from joined