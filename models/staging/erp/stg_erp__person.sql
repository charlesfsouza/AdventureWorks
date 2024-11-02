with
    fonte_pessoas as (
        select *
        from {{ source('erp_adventureworks', 'person') }}

     )   

     ,renomeacao as (
        select
            businessentityid as pk_pessoa
            ,upper(concat(ifnull(firstname,' '),' ',ifnull(middlename,' '),' ',ifnull(lastname,' '))) as nom_pessoa
            ,cast(persontype as string)  as sgl_tipo_pessoa     
       
        from fonte_pessoas
     )

select *
from renomeacao



