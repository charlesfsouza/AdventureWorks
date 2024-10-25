with
    fonte_pais as (
        select *
        from {{ source('erp_adventureworks', 'countryregion') }}
     )   

     ,renomeacao as (
        select

            cast(countryregioncode as int)  as pk_pais
            ,cast(name as string) as nom_pais


       
        from fonte_pais
     )

select *
from renomeacao



