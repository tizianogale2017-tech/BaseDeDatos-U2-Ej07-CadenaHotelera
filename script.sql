-- Base de Datos I - Unidad 4 - Ej07: CadenaHotelera
-- Script portable (SQLite / MySQL). En SQLite activar antes: PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS CONSUMO;
DROP TABLE IF EXISTS ESTANCIA;
DROP TABLE IF EXISTS reserva_habitacion;
DROP TABLE IF EXISTS RESERVA;
DROP TABLE IF EXISTS HUESPED;
DROP TABLE IF EXISTS HABITACION;
DROP TABLE IF EXISTS HOTEL;

CREATE TABLE HOTEL (
    id_hotel INT PRIMARY KEY,
    codigo_hotel VARCHAR(50) UNIQUE,
    nombre_hotel VARCHAR(50),
    direccion_hotel VARCHAR(100),
    ciudad VARCHAR(50),
    pais VARCHAR(100),
    categoria_estrellas INT
);

CREATE TABLE HABITACION (
    id_habitacion INT PRIMARY KEY,
    id_hotel INT,
    numero_habitacion INT,
    tipo_habitacion VARCHAR(50),
    piso INT,
    tarifa_diaria_base DECIMAL(12,2),
    estado_habitacion VARCHAR(100),
    FOREIGN KEY (id_hotel) REFERENCES HOTEL(id_hotel)
);

CREATE TABLE HUESPED (
    id_huesped INT PRIMARY KEY,
    tipo_documento VARCHAR(50),
    numero_documento VARCHAR(50),
    nombre_huesped VARCHAR(50),
    nacionalidad VARCHAR(50),
    direccion_huesped VARCHAR(100),
    email_contacto VARCHAR(100) UNIQUE
);

CREATE TABLE RESERVA (
    id_reserva INT PRIMARY KEY,
    id_hotel INT,
    id_huesped INT,
    codigo_reserva VARCHAR(50) UNIQUE,
    fecha_reserva DATE,
    fecha_inicio_estancia DATE,
    fecha_fin_estancia DATE,
    estado_reserva VARCHAR(50),
    FOREIGN KEY (id_hotel) REFERENCES HOTEL(id_hotel),
    FOREIGN KEY (id_huesped) REFERENCES HUESPED(id_huesped)
);

CREATE TABLE reserva_habitacion (
    id_res_hab INT PRIMARY KEY,
    id_reserva INT,
    id_habitacion INT,
    fecha_desde DATE,
    fecha_hasta DATE,
    tarifa_aplicada DECIMAL(12,2),
    FOREIGN KEY (id_reserva) REFERENCES RESERVA(id_reserva),
    FOREIGN KEY (id_habitacion) REFERENCES HABITACION(id_habitacion)
);

CREATE TABLE ESTANCIA (
    id_estancia INT PRIMARY KEY,
    id_reserva INT,
    codigo_estancia VARCHAR(50) UNIQUE,
    fecha_hora_checkin DATE,
    fecha_hora_checkout DATE,
    estado_estancia VARCHAR(50),
    importe_total DECIMAL(12,2),
    FOREIGN KEY (id_reserva) REFERENCES RESERVA(id_reserva)
);

CREATE TABLE CONSUMO (
    id_consumo INT PRIMARY KEY,
    id_estancia INT,
    codigo_consumo VARCHAR(100) UNIQUE,
    fecha_consumo DATE,
    descripcion_servicio VARCHAR(50),
    cantidad INT,
    costo_total DECIMAL(12,2),
    FOREIGN KEY (id_estancia) REFERENCES ESTANCIA(id_estancia)
);

-- Datos de HOTEL
INSERT INTO HOTEL (id_hotel, codigo_hotel, nombre_hotel, ciudad, categoria_estrellas) VALUES (1, 'HT-01', 'Gran Cuyo', 'Mendoza', 4);
INSERT INTO HOTEL (id_hotel, codigo_hotel, nombre_hotel, ciudad, categoria_estrellas) VALUES (2, 'HT-03', 'Patagonia Lodge', 'Bariloche', 5);
INSERT INTO HOTEL (id_hotel, codigo_hotel, nombre_hotel, ciudad, categoria_estrellas) VALUES (3, 'HT-04', 'Andes Plaza', 'San Juan', 4);
INSERT INTO HOTEL (id_hotel, codigo_hotel, nombre_hotel, ciudad, categoria_estrellas) VALUES (4, 'HT-05', 'Pampa Suites', 'Santa Rosa', 3);

-- Datos de HABITACION
INSERT INTO HABITACION (id_habitacion, id_hotel, numero_habitacion, tipo_habitacion, piso) VALUES (1, 1, 101, 'Simple', 1);
INSERT INTO HABITACION (id_habitacion, id_hotel, numero_habitacion, tipo_habitacion, piso) VALUES (2, 1, 102, 'Doble', 1);
INSERT INTO HABITACION (id_habitacion, id_hotel, numero_habitacion, tipo_habitacion, piso) VALUES (3, 2, 201, 'Doble', 2);
INSERT INTO HABITACION (id_habitacion, id_hotel, numero_habitacion, tipo_habitacion, piso) VALUES (4, 3, 305, 'Triple', 3);

-- Datos de HUESPED
INSERT INTO HUESPED (id_huesped, tipo_documento, numero_documento, nombre_huesped, nacionalidad) VALUES (1, 'DNI', '30111222', 'Laura Méndez', 'Argentina');
INSERT INTO HUESPED (id_huesped, tipo_documento, numero_documento, nombre_huesped, nacionalidad) VALUES (2, 'DNI', '28999111', 'Pedro Sosa', 'Argentina');
INSERT INTO HUESPED (id_huesped, tipo_documento, numero_documento, nombre_huesped, nacionalidad) VALUES (3, 'DNI', '33444555', 'Marta Ruiz', 'Argentina');
INSERT INTO HUESPED (id_huesped, tipo_documento, numero_documento, nombre_huesped, nacionalidad) VALUES (4, 'Pasaporte', 'BB654321', 'Anna Weber', 'Alemana');

-- Datos de RESERVA
INSERT INTO RESERVA (id_reserva, id_hotel, id_huesped, codigo_reserva, estado_reserva) VALUES (1, 1, 1, 'R-0001', 'Finalizada');
INSERT INTO RESERVA (id_reserva, id_hotel, id_huesped, codigo_reserva, estado_reserva) VALUES (2, 1, 2, 'R-0002', 'Finalizada');
INSERT INTO RESERVA (id_reserva, id_hotel, id_huesped, codigo_reserva, estado_reserva) VALUES (3, 2, 3, 'R-0004', 'Confirmada');
INSERT INTO RESERVA (id_reserva, id_hotel, id_huesped, codigo_reserva, estado_reserva) VALUES (4, 3, 4, 'R-0005', 'Finalizada');

-- Datos de reserva_habitacion
INSERT INTO reserva_habitacion (id_res_hab, id_reserva, id_habitacion, tarifa_aplicada, fecha_desde) VALUES (1, 1, 1, 45000, '2026-08-10');
INSERT INTO reserva_habitacion (id_res_hab, id_reserva, id_habitacion, tarifa_aplicada, fecha_desde) VALUES (2, 2, 2, 45000, '2026-08-10');
INSERT INTO reserva_habitacion (id_res_hab, id_reserva, id_habitacion, tarifa_aplicada, fecha_desde) VALUES (3, 3, 3, 60000, '2026-09-01');
INSERT INTO reserva_habitacion (id_res_hab, id_reserva, id_habitacion, tarifa_aplicada, fecha_desde) VALUES (4, 4, 4, 80000, '2026-09-05');

-- Datos de ESTANCIA
INSERT INTO ESTANCIA (id_estancia, id_reserva, codigo_estancia, estado_estancia, importe_total) VALUES (1, 1, 'E-01', 'Finalizada', 45000);
INSERT INTO ESTANCIA (id_estancia, id_reserva, codigo_estancia, estado_estancia, importe_total) VALUES (2, 2, 'E-02', 'Finalizada', 45000);
INSERT INTO ESTANCIA (id_estancia, id_reserva, codigo_estancia, estado_estancia, importe_total) VALUES (3, 3, 'E-04', 'En curso', 60000);
INSERT INTO ESTANCIA (id_estancia, id_reserva, codigo_estancia, estado_estancia, importe_total) VALUES (4, 4, 'E-05', 'Finalizada', 80000);

-- Datos de CONSUMO
INSERT INTO CONSUMO (id_consumo, id_estancia, descripcion_servicio, costo_total, cantidad) VALUES (1, 1, 'Spa', 22000, 1);
INSERT INTO CONSUMO (id_consumo, id_estancia, descripcion_servicio, costo_total, cantidad) VALUES (2, 2, 'Desayuno extra', 6000, 2);
INSERT INTO CONSUMO (id_consumo, id_estancia, descripcion_servicio, costo_total, cantidad) VALUES (3, 3, 'Lavandería', 3500, 1);
INSERT INTO CONSUMO (id_consumo, id_estancia, descripcion_servicio, costo_total, cantidad) VALUES (4, 4, 'Room service', 15000, 1);
