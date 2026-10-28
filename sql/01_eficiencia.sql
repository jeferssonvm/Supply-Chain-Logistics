
--Que categoría de producto tiene mas retrasos = consumer goods con mas retrasos 17.5% y electronics con menos retrasos 13.4%
SELECT product_category,
 COUNT(*) AS Envios,
 SUM(delivery_status =  'Delayed') AS retardo,
 ROUND(100.0 * SUM(delivery_status =  'Delayed') / COUNT(*), 1) AS porcentaje_retardo,
 ROUND(AVG(customs_clearance_time_days), 2 ) AS dias_aduana_promedio
 FROM shipment
 GROUP BY product_category
 ORDER BY porcentaje_retardo DESC;

 -- electronics tiene los mismos envios que consumer goods pero se retrasa menos 13.4 es el mejor

--que categoria tiene mas retrasos
--diferencia entre todos es poca todos estan cerca del 16 general
--la aduana no explica los retrasos
-- industrial es el que mas dura en aduana 4.45 y no es el peor

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
ORDER BY type, ranking;


-- consumer goods export es el peor 18.4
-- la importacionde electronica se retrasa demasiado con 16,7.posible mejoras
-- seria bueno mirar que tecnicas o sistemas implementa en electronicas la exportacion para que  sea  una buena ruta 
-- importacion casi no hay diferencia  entre todos