--Cuáles son los principales flujos de comercio entre países
SELECT  
    TRIM(o_country) AS pais_origen,
    TRIM(d_country) AS pais_destino,
    COUNT(*) AS total_envios, 
    SUM(value) AS valor_total,
    ROUND(AVG(VALUE), 2) AS valor_promedio_envio
FROM shipment
GROUP BY pais_origen, pais_destino
ORDER BY total_envios DESC;

-- todo pasa por india o sale de india o llega a india
--no hay envios entre otros paises
-- india a usa es la ruta con mas envios 74
-- south korea a india es la que mas plata
-- india exporta barato e importa caro

SELECT 
    COUNT(*) AS dias_registrados,
    region, 
    carrier,
    ROUND(AVG(delay_hours_avg), 2) AS retraso_promedio
FROM logistics
GROUP BY region, carrier
ORDER BY retraso_promedio ASC; 
-- oceanexpress es 4.38 horas de retraso
-- north america se veia inconsistente en el eda son dos 
 -- asia solo tiene oceanexpress no hay con quien comparar
 -- reliablelogistics es el mejor 1.17


select 
    market_segment,
    COUNT(*) AS total_clientes,
    ROUND(AVG(acquisition_cost_usd), 2) AS costo_adquisicion_promedio,
    ROUND(AVG(order_value_usd), 2) AS valor_orden_promedio,
    ROUND(100.0 * SUM(acquisition_cost_usd) / SUM(order_value_usd), 1) AS porcentaje_costo_adquisicion    FROM customer 
    GROUP BY market_segment 
    ORDER BY porcentaje_costo_adquisicion ASC;

    -- conseguir un cliente cuesta lo mismo en todos lados entre 874 y 887
    -- en asia el cliente cuesta 4 de lo que compra es el mas rentable
    -- conviene buscar clientes en asia y north america