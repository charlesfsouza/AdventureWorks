with
    fonte_pedido_item as (
        select *
        from {{ source('erp_adventureworks', 'salesorderdetail') }}
     )   

     ,renomeacao as (
        select

            cast(salesorderdetailid as int)  as pk_pedido_item
            ,cast(salesorderid as int) as fk_pedido
            ,cast(productid as int) as fk_produto
            ,cast(orderqty as int) as qtd_pedido_item
            ,cast(unitprice as float) as vlr_item
            ,cast(unitpricediscount as float) as pct_desconto_item
        
        from fonte_pedidos_detalhes
     )

select *
from renomeacao



