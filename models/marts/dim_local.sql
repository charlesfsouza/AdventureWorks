with
    pedidos as (
        select
            distinct
                billtoaddressid
                ,
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
            enderecos
    )

 
select *
from joined