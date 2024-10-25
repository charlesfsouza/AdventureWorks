with
    fonte_pessoas as (
        select *
        from {{ source('erp_adventureworks', 'person') }}
     )   

     ,renomeacao as (
        select

            cast(businessentityid as int)  as pk_pessoa
            ,cast(firstname as character) as nome_primeiro_pessoa
            ,cast(middlename as character) as nome_meio_pessoa
            ,cast(lastname as character) as nome_ultimo_pessoa
            ,cast(persontype as character) as sgl_tipo_pessoa           
       
        from fonte_pessoas
     )

select *
from renomeacao



