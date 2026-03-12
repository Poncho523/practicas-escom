CREATE TABLE CLIENTE (
	ID_CLIENTE SERIAL PRIMARY KEY, --LE AGREGA UN NUMERO EN SERIE 
	NOMBRE VARCHAR(100) NOT NULL,
	CORREO VARCHAR(100) UNIQUE NOT NULL, --EL CORREO DEBE SER UNICO Y NO PUEDE SER NULO
	CIUDAD VARCHAR(50) NOT NULL
);

CREATE TABLE PRODUCTO (
	ID_PRODUCTO SERIAL PRIMARY KEY,
	NOMBRE VARCHAR(100) NOT NULL,
	PRECIO NUMERIC(10, 2) NOT NULL,
	STOCK INTEGER NOT NULL
);

CREATE TABLE VENTA (
	ID_VENTA SERIAL PRIMARY KEY,
	FECHA DATE NOT NULL,
	ID_CLIENTE INTEGER NOT NULL,
	FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID_CLIENTE)
);

CREATE TABLE DETALLE_VENTA (
	ID_DETALLE SERIAL PRIMARY KEY,
	ID_VENTA INTEGER NOT NULL, --INTEGER ES ENTERO, LOL
	ID_PRODUCTO INTEGER NOT NULL,
	CANTIDAD INTEGER NOT NULL,
	FOREIGN KEY (ID_VENTA) REFERENCES VENTA (ID_VENTA),
	FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTO (ID_PRODUCTO)
);

INSERT INTO
	CLIENTE (NOMBRE, CORREO, CIUDAD)
VALUES
	('ANA LOPEZ', 'ANA@GMAIL.COM', 'CDMX'),
	('PONCHO MACHINE', 'PM@GMAIL.COM', 'TEXCOCO'),
	('MANDARINA PEQUEÑA', 'MANDARINA@GMAIL.COM', 'AZCAPOTZALCO');

INSERT INTO
	PRODUCTO (NOMBRE, PRECIO, STOCK)
VALUES
	('GALLETA', 10.00, 5),
	('CHOCOLATE', 5.00, 20),
	('PAPAS', 20.00, 3);
	
SELECT ID_CLIENTE, NOMBRE, CIUDAD FROM CLIENTE --SI NO SE LE PONE EL WHERE PS IMPRIME TODOS
WHERE NOMBRE='MANDARINA PEQUEÑA';

SELECT NOMBRE, PRECIO FROM PRODUCTO WHERE PRECIO > 10;

SELECT V.ID_VENTA, V.FECHA, C.NOMBRE
FROM VENTA V --AHORA SE VA A LLAMAR V VENTA 
JOIN CLIENTE C -- AHORA ES C CLIENTE
ON V.ID_CLIENTE=C.ID_CLIENTE;

insert into venta (fecha,id_cliente) values ('2025-05-21',1),
											('2025-06-2',2),
											('2025-05-25',3);
insert into detalle_venta (id_venta,id_producto,cantidad) values
						  (1,1,2), (2,1,1), (3,3,1);

select fecha,id_cliente from venta;
select id_venta,id_producto,cantidad from detalle_venta;

--nombre y correo del cliente, 
--asi como el nombre y precio del producto y 
--fecha de venta
select c.nombre as nombre_cliente,c.correo,p.nombre_p as nombre_producto,precio,fecha
from producto as p natural join detalle_venta natural join venta natural join cliente as c;

alter table producto rename column nombre to nombre_p;

select nombre, sum(precio*cantidad)
from cliente natural join venta natural join detalle_venta natural join producto
group by nombre;




