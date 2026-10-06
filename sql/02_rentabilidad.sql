--que categoría tiene el flete más caro en proporción a su valor
    SELECT product_category,
    COUNT(*) AS Envios,
    SUM(freight_cost) AS costo_flete_total,
    ROUND(100.0 *(SUM(freight_cost)/SUM(value)), 1) AS porcentaje_costo_envio
    from shipment
    GROUP BY product_category
    ORDER BY porcentaje_costo_envio DESC;   

--precio del combustible influye en los retrasos?
SELECT
    CASE
        WHEN fuel_price_usd_per_barrel < 80 THEN '1. Bajo'
        WHEN fuel_price_usd_per_barrel < 85 THEN '2. Medio'
        ELSE '3. Alto'
    END AS rango_precio_combustible,
    COUNT(*) AS dias,
    ROUND(AVG(fuel_price_usd_per_barrel), 2) AS precio_combustible_promedio,
    Round(aVG(delay_hours_avg),2) AS retraso_promedio
    From logistics
    group by rango_precio_combustible
    order by rango_precio_combustible;

select * FROM logistics;

WITH  rutas_costos_flete  AS (
    select origin ,destination, 
    count(*) AS cantidad_envios,
    ROUND(AVG(freight_cost), 2) AS costo_promedio_envio
    FROM shipment
    group by origin, destination
)SELECT Origin, destination, cantidad_envios, costo_promedio_envio,
    RANK() OVER(ORDER BY costo_promedio_envio DESC) AS ranking
    WHERE ranking <= 3
 FROM rutas_costos_flete;
