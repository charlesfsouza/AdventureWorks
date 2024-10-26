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
            pk_territorio
            ,fk_pais
            ,nom_territorio
            ,nom_continente
        from {{ ref('stg_erp__salesterritory') }}
    )
    ,paises as (
        select
            pk_pais
            ,nom_pais
        from {{ ref('stg_erp__countryregion') }}        
    )
    ,joined as (
        select
            {{ dbt_utils.generate_surrogate_key(['pedidos.fk_endereco_envio']) }} as sk_endereco
            ,pedidos.fk_endereco_envio as pk_endereco
            ,upper(enderecos.nom_cidade) as nom_cidade
            ,upper(estados.nom_provincia_estado) as nom_provincia_estado
            ,upper(pedidos_territorio.nom_territorio) as nom_territorio
            ,upper(pedidos_territorio.nom_continente) as nom_continente
            ,upper(paises.pk_pais) as sgl_pais
            ,upper(paises.nom_pais) as nom_pais
        from
            pedidos
        left join enderecos on enderecos.pk_endereco = pedidos.fk_endereco_envio
        left join estados on estados.pk_provincia_estado = enderecos.fk_provincia_estado
        left join pedidos_territorio on pedidos_territorio.pk_territorio = pedidos.fk_regiao
        left join paises on paises.pk_pais = pedidos_territorio.fk_pais
    )

 
select *
from joined