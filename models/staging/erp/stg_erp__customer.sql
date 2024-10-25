with
    fonte_clientes as (
        select *
        from {{ source('erp_adventureworks', 'customer') }}
     )   

     ,renomeacao as (
        select

            cast(customerid as int)  as pk_cliente
            ,cast(personid as int) as pk_pessoa
            ,cast(storeid as int) as fk_loja
            ,cast(territoryid as character) as fk_territorio            
       
        from fonte_clientes
     )

select *
from renomeacao



