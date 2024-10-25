with
    fonte_pessoas as (
        select *
        from {{ source('erp_adventureworks', 'person') }}
     )   

     ,renomeacao as (
        select

            cast(businessentityid as int)  as pk_pessoa
            ,cast(firstname || ' ' || middlename || ' ' || lastname as character) as nom_pessoa
            ,cast(persontype as character) as sgl_tipo_pessoa           
       
        from fonte_pessoas
     )

select *
from renomeacao



