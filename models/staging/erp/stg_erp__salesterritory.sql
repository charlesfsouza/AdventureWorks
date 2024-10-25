with
    fonte_territorio_vendas as (
        select *
        from {{ source('erp_adventureworks', 'salesterritory') }}
     )   

     ,renomeacao as (
        select

            cast(territoryid as int)  as pk_territorio
            ,cast(countryregioncode as string) as fk_pais
            ,cast(name as string) as nom_territorio
            ,cast("group" as string) as nom_continente

       
        from fonte_territorio_vendas
     )

select *
from renomeacao



