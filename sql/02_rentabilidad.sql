--que categoria tiene el flete mas caro en proporción a su valor  = ninguno todos estan en 5% de costo 
    SELECT product_category,
    COUNT(*) AS Envios,
    SUM(freight_cost) AS costo_flete_total,
    ROUND(100.0 *(SUM(freight_cost)/SUM(value)), 1) AS porcentaje_costo_envio
    from shipment
    GROUP BY product_category
    ORDER BY porcentaje_costo_envio DESC;   

-- se nota que costo esta estandarizado todos aparecen con 5%
-- consumer goods es una mercancia barata por la cantidad de envios y el costo de flete  total
--industrial es la mercancia mas cara y con menos envios 



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

--  la mayoria de dias el combustible esta en medio 
-- de bajo a alto el retraso casi se duplica puede ser correlacion  mas no causalidad 
-- son poco datos para sacar conclusiones



-- ¿Cuáles son las 3 rutas más caras de enviar?
WITH  rutas_costos_flete  AS (
    select origin ,destination, 
    count(*) AS cantidad_envios,
    ROUND(AVG(freight_cost), 2) AS costo_promedio_envio
    FROM shipment
    group by origin, destination
)SELECT Origin, destination, cantidad_envios, costo_promedio_envio,
    RANK() OVER(ORDER BY costo_promedio_envio DESC) AS ranking
    FROM rutas_costos_flete
    order by ranking
    limit 3
;
-- las rutas mas caras son de mumbai
-- yokohama a mumbai es la mas cara
-- el flete es 5 del valor entonces no es la ruta cara son productos caros
-- mumbai parece como el centro de todo
