with
    pedidos as (
        select distinct
                fk_endereco_envio
                ,fk_regiao
        from {{ ref('stg_erp__salesorderheader') }}

    )
    ,enderecos as (
        select
            pk_endereco
            ,fk_provincia_estado
            ,nom_cidade
        from {{ ref('stg_erp__address') }}     
    )
    ,estados as (
        select
            pk_provincia_estado
            ,fk_territorio
            ,fk_pais
            ,sgl_provincia_estado
            ,nom_provincia_estado
        from {{ ref('stg_erp__stateprovince') }}        
    )
    ,pedidos_territorio as (
        select
            *
        from {{ ref('stg_erp__salesterritory') }}
    )
    ,paises as (
        select
            *
        from {{ ref('stg_erp__countryregion') }}        
    )
    ,joined as (
        select
            {{ dbt_utils.generate_surrogate_key(['stg_erp__salesorderheader.fk_endereco_envio']) }} as sk_local
            ,pedidos.fk_endereco_envio as pk_endereco
            ,upper(enderecos.nom_cidade) as nom_cidade
            ,upper(estados.nom_provincia_estado) as nom_provincia_estado
        from
            pedidos
        left join enderecos on enderecos.pk_endereco = pedidos.fk_endereco_envio
        left join estados on estados.pk_provincia_estado = enderecos.fk_provincia_estado
    )

 
select *
from joined