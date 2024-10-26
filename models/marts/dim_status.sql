with
    status as (
        select
            fk_status
            ,dsc_status
        from {{ ref('int_status_construcao') }}
    )
    ,transformado as (
        select
            fk_status
            ,upper(dsc_status) as dsc_status
        from
            status
    )

 
select *
from transformado