with
    fonte_motivos as (
        select *
        from {{ source('erp_adventureworks', 'salesreason') }}
     )   

     ,renomeacao as (
        select

            cast(salesreasonid as int)  as pk_motivo
            ,cast(name as string) as dsc_motivo
            ,cast(reasontype as string) as dsc_motivo_tipo
       
        from fonte_motivos
     )

select *
from renomeacao



