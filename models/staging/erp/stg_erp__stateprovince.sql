with
    fonte_provincia_estado as (
        select *
        from {{ source('erp_adventureworks', 'stateprovince') }}
     )   

     ,renomeacao as (
        select

            cast(STATEPROVINCEID as int)  as pk_provincia_estado
            ,cast(TERRITORYID as int) as fk_territorio
            ,cast(STATEPROVINCECODE as int) as sgl_provincia_estado
            ,cast(COUNTRYREGIONCODE as character) as sgl_regiao_pais
            ,cast(NAME as character) as dsc_provincia_estado


       
        from fonte_provincia_estado
     )

select *
from renomeacao



