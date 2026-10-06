SELECT product_category FROM shipment;

--Qué categoría de producto tiene mas retrasos
SELECT product_category,
 COUNT(*) AS Envios,
 SUM(delivery_status =  'Delayed') AS retardo,
 ROUND(100.0 * SUM(delivery_status =  'Delayed') / COUNT(*), 1) AS porcentaje_retardo,
 ROUND(AVG(customs_clearance_time_days), 2 ) AS dias_aduana_promedio
 FROM shipment
 GROUP BY product_category
 ORDER BY porcentaje_retardo DESC;

--quE categoría tiene más retrasos
WITH por_categoia AS (
    SELECT 
        product_category,
        type,
        COUNT(*) AS Envios,
        ROUND(100.0 * SUM(delivery_status =  'Delayed') / COUNT(*), 1) AS porcentaje_retardo
    FROM shipment
    GROUP BY product_category, type
)
SELECT
    product_category,
    type,
    envios,
    porcentaje_retardo,
    RANK() OVER(PARTITION BY type ORDER BY porcentaje_retardo DESC) AS ranking
FROM por_categoia
ORDER BY type ranking;

