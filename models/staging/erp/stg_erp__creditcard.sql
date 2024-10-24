with
    fonte_cartoes_credito as (
        select *
        from {{ source('erp_adventureworks', 'creditcard') }}
     )   

     ,renomeacao as (
        select

            cast(creditcardid as int)  as pk_cartao_credito
            ,cast(cardtype as character) as dsc_tipo_cartao

       
        from fonte_cartoes_credito
     )

select *
from renomeacao



