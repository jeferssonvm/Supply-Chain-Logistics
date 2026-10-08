SELECT * FROM customer;
--Qué segmento de mercado tiene la mejor satisfacción y menos tickets de soporte?
select market_segment , 
    COUNT(*) AS cantidad_clientes, 
    ROUND(AVG(satisfaction_score), 2) AS promedio_satisfaccion,
    ROUND(AVG(support_tickets), 2) AS promedio_tickets_soporte,
    ROUND(100.0 * SUM(support_tickets > 0) / COUNT(*), 1) AS porcentaje_clientes_con_tickets
from customer
group by    MARKET_SEGMENT
ORDER BY promedio_satisfaccion DESC;


select 
    case
        when lead_time_days < 14 then '1 rapido'
        when lead_time_days <= 18 THEN '2 normal'
        else '3 lento'
    end as lead_time,
    COUNT(*) AS cantidad_clientes,
    ROUND(AVG(satisfaction_score), 2) AS promedio_satisfaccion
from customer
group by lead_time
order by lead_time;

select market_segment, 
    cOUNT(*) AS cantidad_clientes,
   round(AVG(julianday(payment_date) - julianday(order_date)), 2) AS promedio_pago
from customer
group by market_segment
ORDER BY promedio_pago DESC;
