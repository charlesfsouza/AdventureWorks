/*  
    Teste para verificar se o valor negociado / vendas brutas  segregada está compativel com o valor original
    Por conta do arredondamento, como referencia, a quantidade de pedidos nao pode ser superior a 0.09

*/

{{ config (
        severity = 'error'
    )
}}

with
    dado_original as (
        select 
            1 as id
            ,round(sum(qtd_pedido_item * vlr_item),2) as vlr_negoc
        from {{ ref('stg_erp__salesorderdetail') }}
    ) 
    ,dado_transformado as (
        select
            1 as id
            ,round(sum(vlr_negoc),2) as vlr_negoc
        from {{ ref('int_preparacao_fato_pedidos') }}   
    )
    ,resultado as (
        select
            abs(dado_original.vlr_negoc - dado_transformado.vlr_negoc) as dif
        from dado_original
        inner join dado_transformado on dado_transformado.id = dado_original.id
    ) 
    select dif
    from resultado
    where dif not between 0.00 and 0.09
