with
    fonte_pessoas as (
        select *
        from {{ source('erp_adventureworks', 'person') }}
     )   

     ,renomeacao as (
        select

            cast(businessentityid as int)  as pk_pessoa
            ,cast(firstname || ' ' || middlename || ' ' || lastname as string) as nom_pessoa
            ,cast(persontype as string)  as sgl_tipo_pessoa     
       
        from fonte_pessoas
     )

select *
from renomeacao



