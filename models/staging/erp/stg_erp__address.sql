with
    fonte_enderecos as (
        select *
        from {{ source('erp_adventureworks', 'address') }}
     )   

     ,renomeacao as (
        select

            cast(addressid as int)  as pk_endereco
            ,cast(stateprovinceid as int) as fk_provincia_estado
            ,cast(city as character) as dsc_cidade

       
        from fonte_enderecos
     )

select *
from renomeacao



