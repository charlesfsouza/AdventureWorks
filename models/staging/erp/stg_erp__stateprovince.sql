with
    fonte_provincia_estado as (
        select *
        from {{ source('erp_adventureworks', 'stateprovince') }}
     )   

     ,renomeacao as (
        select

            cast(stateprovinceid as int)  as pk_provincia_estado
            ,cast(territoryid as int) as fk_territorio
            ,cast(countryregioncode as character) as fk_pais            
            ,cast(stateprovincecode as int) as sgl_provincia_estado
            ,cast(name as character) as dsc_provincia_estado


       
        from fonte_provincia_estado
     )

select *
from renomeacao



