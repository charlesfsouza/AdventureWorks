with
    datas as (
        select
            fk_data 
            ,data_anterior
            ,data_proxima
            ,dia_da_semana
            ,dsc_dia_da_semana
            ,dia_do_mes
            ,dia_do_ano
            ,semana_do_ano
            ,mes_do_ano
            ,dsc_mes_do_ano
            ,quadrimestre
            ,ano
        from {{ ref('int_preparacao_dim_data') }}
    )

 
select *
from datas