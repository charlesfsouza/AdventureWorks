with
    fonte_pessoas as (
        select *
        from {{ source('erp_adventureworks', 'person') }}
     )   

     ,renomeacao as (
        select

            cast(businessentityid as int)  as pk_pessoa
            ,firstname || ' ' || middlename || ' ' || lastname as nom_pessoa
            ,persontype  as sgl_tipo_pessoa     
       
        from fonte_pessoas
     )

select *
from renomeacao



