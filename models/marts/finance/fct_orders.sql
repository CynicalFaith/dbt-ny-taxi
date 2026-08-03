with orders as (

select *
from {{ ref('stg_jaffle_shop__orders') }}

),

payments as (
select
order_id,
sum(amount) as amount
from {{ ref('stg_stripe__payments') }}
where status = 'success'
group by order_id
)

select

   o.order_id,
    o.customer_id,
    p.amount

from orders o
left join payments p
on o.order_id = p.order_id