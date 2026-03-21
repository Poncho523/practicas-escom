#Importara biblioteca
import pandas as pd

#Extraer archivos a dataframes
clientes = pd.read_csv("clientes.csv")
productos=pd.read_csv("productos.csv")
ventas = pd.read_csv("ventas.csv")

print(clientes.info())
print(productos.info())
print(ventas.info())

#Concatenar el nombre y quitarle los espacios
#.str sirve para acceder a cada uno de los elementos de la serie
clientes["nombre_completo"]=clientes["nombre"].str.strip()+" "+ clientes["apellido"].str.strip()

#Hacemos minuscula y eliminamos los espacios en blanco a los correos
clientes["correo"]=clientes["correo"].str.lower().str.strip()


clientes["ciudad"]=clientes["ciudad"].str.strip()

#Datetime sirve para cambiarlo esa seria a una serie de fecha
clientes["fecha_registro"] = pd.to_datetime(clientes["fecha_registro"], format = 'mixed')

## -- Productos

productos["categoria"]=productos["categoria"].str.strip()

productos["precio"]=pd.to_numeric(productos["precio"])

productos["stock"] = pd.to_numeric(productos["stock"])

## -- Ventas
ventas["fecha_venta"] = pd.to_datetime(ventas["fecha_venta"], format='mixed')
ventas["cantidad"] = pd.to_numeric(ventas["cantidad"])
ventas["metodo_pago"] = ventas["metodo_pago"].str.lower()
ventas["sucursal"] = ventas["sucursal"].str.strip()

## --Crear objetos dimensionales
dim_tiempo= pd.DataFrame({"fecha":ventas["fecha_venta"].drop_duplicates().sort_values()})

dim_tiempo["anio"]=dim_tiempo["fecha"].dt.year
dim_tiempo["mes"]=dim_tiempo["fecha"].dt.month
dim_tiempo["dia"]=dim_tiempo["fecha"].dt.day
dim_tiempo["nombre_mes"]=dim_tiempo["fecha"].dt.month_name(locale="es_ES") if False else dim_tiempo["fecha"].dt.strftime("%B")

## --Calcular total de ventas
ventas=ventas.merge(productos[["id_producto","precio"]], on = "id_producto", how="left")
ventas["total_ventas"]=ventas["cantidad"]*ventas["precio"]

"""En productos transformados tenemos registros como los siguientes:
107,Cable HDMI 2m,Accesorios,-150.0,30
108,Webcam HD,Cámaras,850.0,-5
Los cuales tienen números negativos en los campos de precio y stock respectivamente.
Por consiguiente buscamos corregir y proponer una solución, para que no se siga suscitando este problema.
"""
productos_cuarentena=productos[(productos['precio'] <0.0 )| (productos['stock'] < 0)]
productos=productos[(productos['precio']>=0.0) & (productos['stock']>=0)]

"""Asimismo en la tabla contenida de clientes_transformados.csv, exite el siguiente registro:
3,Sofia Ramirez,sofia.ramirezmail.com,5556781234,Ciudad de México,2025-02-01
El cual no cuenta con arroba en el correo electronico por lo tanto no podemos saber con exactitud a que dominio nos referimos
Buscamos aislar este registro para posteriormente buscar una solución"""

clientes_cuarentena=clientes[~(clientes['correo'].str.contains('@', na=False))]
clientes=clientes[clientes['correo'].str.contains('@', na=False)]

"""Podemos ver el registro de Carlos Perez repetido, en primera instancia la mejor solución, seria eliminar uno
y implementar una solución para que no existan tuplas repetidas."""

clientes=clientes.drop_duplicates()

"""Es necesario hacer una limpieza de los datos y estandarizarlos a un mismo formato, ya que existen registros como el siguiente:
1,Ana López,ana.lopez@gmail.com,55-1234-5678,cdmx,2025-10-01
que es el único que tiene el número escrito con guiones medios, a diferencia de las demas tuplas que no los tienen."""

clientes['telefono']=clientes['telefono'].str.replace('-','', regex=False)
"""De igual manera veo necesario estandarizar palabras como cdmx y Ciudad de México, ya que semánticamente son iguales."""

clientes['ciudad']=clientes['ciudad'].str.replace('cdmx','Ciudad De México')
"""De igual manera veo necesario estandarizar la parte de tipo de producto, ya que semánticamente, Accesorios y accesorios
son lo mismo. """
productos['categoria']=productos['categoria'].str.replace('accesorios','Accesorios', case=False, regex=True)

# --Objetos limpios transformados
clientes_final=clientes[["id_cliente","nombre_completo","correo","telefono","ciudad","fecha_registro"]]

productos_final=productos[["id_producto","nombre_producto","categoria","precio","stock"]]

ventas_final=ventas[["id_venta","id_cliente","id_producto","fecha_venta","cantidad","metodo_pago","sucursal","total_ventas"]]

## Persistir

clientes_final.to_csv("clientes_transformados.csv",index=False)
productos_final.to_csv("productos_transformados.csv",index=False)
ventas_final.to_csv("ventas_transformadas.csv",index=False)
dim_tiempo.to_csv("dim_tiempo.csv",index=False)
productos_cuarentena.to_csv("productos_cuarentena.csv", index=False)
clientes_cuarentena.to_csv("cliente_cuarentena.csv", index=False)

