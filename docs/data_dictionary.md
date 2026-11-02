# Diccionario de datos

Descripción de las columnas de las 3 tablas, después de la limpieza (`data/processed/`). Las tablas no tienen llaves en común, por lo cual no se pueden unir entre sí.

## customer

Una fila por cliente, con su primer pedido. 750 filas.

| Columna | Tipo | Descripción | Valores |
|---|---|---|---|
| `customer_id` | texto | Identificador del cliente | CUST-001 a CUST-750 |
| `acquisition_date` | fecha | Fecha en que se consiguió el cliente | 05/01/2024 a 24/01/2026 |
| `acquisition_cost_usd` | entero | Costo de conseguir el cliente, en dólares | 790 a 960 |
| `market_segment` | texto | Región del cliente | Africa, Asia-Pacific, Europe, Middle East, North America |
| `supplier_id` | texto | Proveedor que atiende al cliente | SUP-A a SUP-G |
| `order_id` | texto | Identificador del pedido | ORD-1001 a ORD-1750 |
| `order_date` | fecha | Fecha del pedido | 15/01/2024 a 12/04/2029 |
| `order_value_usd` | entero | Valor del pedido, en dólares | 5.000 a 25.000 |
| `payment_date` | fecha | Fecha de pago (casi siempre 40 días después del pedido) | 18/02/2024 a 22/05/2029 |
| `satisfaction_score` | entero | Calificación del cliente | 3, 4 o 5 |
| `support_tickets` | entero | Cantidad de tickets de soporte | 0 a 3 |
| `lead_time_days` | entero | Días desde el pedido hasta la entrega | 12 a 20 |

## shipment

Una fila por envío. 728 filas.

| Columna | Tipo | Descripción | Valores |
|---|---|---|---|
| `shipment_id` | texto | Identificador del envío | SHP-2024-0001 a SHP-2025-0364 |
| `type` | texto | Tipo de envío, visto desde India | Export, Import |
| `date` | fecha | Fecha del envío | 02/01/2024 a 31/12/2025 |
| `product_category` | texto | Categoría del producto | Consumer Goods, Electronics, Industrial Equipment, Textiles |
| `origin` | texto | Ciudad de origen | Ej. Mumbai, Yokohama |
| `o_country` | texto | País de origen | Ej. India, Japan |
| `destination` | texto | Ciudad de destino | Ej. New York, Cairo |
| `d_country` | texto | País de destino | Ej. USA, Egypt |
| `value` | decimal | Valor de la mercancía, en dólares | 35.000 a 415.000 |
| `freight_cost` | decimal | Costo del flete, en dólares (siempre el 5 % de `value`) | 1.750 a 20.750 |
| `customs_clearance_time_days` | decimal | Días en aduana | 1,5 a 5,9 |
| `delivery_status` | texto | Estado de la entrega | On-Time, Delayed |

Nota: en los datos originales 24 filas de la ruta Mumbai → Singapore venían corridas una columna. Se corrigieron en `notebook/eda.ipynb`.

## logistics

Una fila por día y transportista. 100 filas (25 días de junio de 2024 × 4 transportistas).

| Columna | Tipo | Descripción | Valores |
|---|---|---|---|
| `date` | fecha | Día del registro | 01/06/2024 a 25/06/2024 |
| `region` | texto | Región donde opera el transportista | Asia-Pacific, Europe, North America |
| `carrier` | texto | Transportista | FastShip, GlobalConnect, OceanExpress, ReliableLogistics |
| `shipments_processed` | entero | Envíos procesados en el día | 850 a 2.370 |
| `delay_hours_avg` | decimal | Retraso promedio del día, en horas | 0,9 a 5,0 |
| `fuel_price_usd_per_barrel` | decimal | Precio del combustible, en dólares por barril | 78,2 a 88,3 |
| `warehouse_utilization_percent` | entero | Ocupación del almacén, en porcentaje | 58 a 94 |
| `damage_claims_count` | entero | Reclamos por daño en el día | 0 a 20 |

Nota: cada transportista opera en una sola región. Norteamérica tiene dos (FastShip y ReliableLogistics); África y Medio Oriente no tienen datos en esta tabla.
