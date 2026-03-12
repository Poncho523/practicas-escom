CREATE DATABASE laboratorio_etl;
CREATE TABLE IF NOT EXISTS stg_clientes (
    id_cliente INTEGER,
    nombre TEXT,
    apellido TEXT,
    correo TEXT,
    telefono TEXT,
    ciudad TEXT,
    fecha_registro TEXT
);
CREATE TABLE IF NOT EXISTS stg_productos(
    id_producto INTEGER,
    nombre_producto TEXT,
    categoria TEXT,
    precio TEXT,
    stock TEXT
);
CREATE TABLE IF NOT EXISTS stg_ventas (
    id_venta INTEGER,
    id_cliente INTEGER,
    id_producto INTEGER,
    fecha_venta TEXT,
    cantidad TEXT,
    metodo_pago TEXT,
    sucursal TEXT
);
--Pasar estas tablas a SQL
--Cambiar las fecha de Text a Date, Poner el id como llave primaria no nula seriada, cambiar los text necesarios a varchar
CREATE TABLE IF NOT EXISTS dim_clientes (
    sk_cliente SERIAL PRIMARY KEY,
    sk_cliente_origen INTEGER UNIQUE NOT NULL,
    nombre_completo VARCHAR(150) NOT NULL, --En caso de uso es mejor que lo separemos como nombre y apellido
    correo VARCHAR(150),
    telefono VARCHAR(20),
    ciudad VARCHAR(80),
    fecha_registro DATE
);
CREATE TABLE IF NOT EXISTS dim_productos (
    sk_producto SERIAL PRIMARY KEY,
    id_producto_origen INTEGER UNIQUE NOT NULL,
    nombre_producto varchar(100) NOT NULL,
    categoria varchar(80),
    precio NUMERIC(10,2), --Los tipos de dato numeric recibe el tamaño entero y el tamaño decimal
    stock INTEGER
);
CREATE TABLE IF NOT EXISTS dim_tiempo(
    sk_tiempo SERIAL PRIMARY KEY,
    fecha DATE UNIQUE NOT NULL,
    anio INTEGER NOT NULL,
    mes INTEGER NOT NULL,
    dia INTEGER NOT NULL,
    nombre_mes varchar(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS dim_ventas(
    sk_venta INTEGER PRIMARY KEY,
    sk_cliente INTEGER NOT NULL REFERENCES dim_clientes(sk_cliente)
    sk_producto INTEGER NOT NULL REFERENCES dim_productos(sk_productos)
    sk_tiempo INTEGER NOT NULL REFERENCES dim_tiempo(sk_tiempo)
    cantidad INTEGER NOT NULL,
    metodo_pago varchar(30),
    sucursal varchar(100)
    total_venta NUMERIC(12,2) NOT NULL
);

select id_producto,nombre_producto,categoria,precio,stock from stg_productos;
select id_venta,id_cliente,id_producto,fecha_venta,cantidad,metodo_pago,sucursal from stg_ventas;
select id_cliente, nombre, apellido, correo, telefono, ciudad, fecha_registro from stg_clientes;
