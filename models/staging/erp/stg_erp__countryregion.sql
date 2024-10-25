with
    fonte_pais as (
        select *
        from {{ source('erp_adventureworks', 'countryregion') }}
     )   

     ,renomeacao as (
        select

            cast(COUNTRYREGIONCODE as int)  as pk_pais
            ,cast(name as character) as dsc_pais


       
        from fonte_pais
     )

select *
from renomeacao



