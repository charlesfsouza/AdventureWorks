with
    pedidos as (
        select distinct
                fk_cliente
        from {{ ref('stg_erp__salesorderheader') }}

    )
    ,clientes as (
        select
            pk_cliente
            ,fk_pessoa
            ,fk_loja
            ,fk_territorio
        from {{ ref('stg_erp__customer') }}
    )
    ,lojas as (
        select 
            pk_loja
            ,fk_vendedor
            ,dsc_loja
        from {{ ref('stg_erp__store') }}
    )
    ,pessoas as (
        select 
            pk_pessoa
            ,nom_pessoa
            ,sgl_tipo_pessoa
        from {{ ref('stg_erp__person') }}
    )
 
    ,joined as (
        select
           {{ dbt_utils.generate_surrogate_key(['pedidos.fk_cliente']) }} as sk_cliente 
           ,pedidos.fk_cliente
           ,nlv(clientes.fk_pessoa,'-1') as fk_pessoa
           ,nvl(upper(pessoas.nom_pessoa),'NOT INFORMED') as nom_cliente
           ,nvl(upper(lojas.dsc_loja),'NOT INFORMED') as nom_loja

        from
            pedidos
        left join clientes on clientes.pk_cliente = pedidos.fk_cliente    
        left join pessoas on pessoas.pk_pessoa = clientes.fk_pessoa
        left join lojas on lojas.pk_loja = clientes.fk_loja      
    )
 
select *
from joined