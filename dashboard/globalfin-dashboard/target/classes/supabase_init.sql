-- Script SQL para crear tablas e insertar datos de prueba en Supabase
-- Ejecutar en el SQL Editor de Supabase

-- Eliminar tablas existentes si hay conflictos de esquema
DROP TABLE IF EXISTS transacciones CASCADE;
DROP TABLE IF EXISTS operaciones CASCADE;
DROP TABLE IF EXISTS clientes CASCADE;

-- Crear tabla clientes
CREATE TABLE clientes (
    id TEXT PRIMARY KEY,
    nombre TEXT NOT NULL,
    apellido TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    telefono TEXT,
    saldo NUMERIC(15, 2) DEFAULT 0.00,
    estado TEXT DEFAULT 'activo',
    fecha_registro TIMESTAMP DEFAULT NOW()
);

-- Crear tabla operaciones
CREATE TABLE operaciones (
    id TEXT PRIMARY KEY,
    id_cliente TEXT NOT NULL REFERENCES clientes(id),
    monto NUMERIC(15, 2) NOT NULL,
    tipo TEXT NOT NULL CHECK (tipo IN ('TRANSFER', 'BIZUM', 'PAYMENT', 'WITHDRAWAL', 'DEPOSIT')),
    estado TEXT NOT NULL DEFAULT 'pending' CHECK (estado IN ('pending', 'completed', 'reviewing', 'suspicious', 'rejected')),
    nivel_riesgo TEXT NOT NULL DEFAULT 'low' CHECK (nivel_riesgo IN ('low', 'medium', 'high')),
    canal TEXT DEFAULT 'web',
    descripcion TEXT,
    fecha_creacion TIMESTAMP DEFAULT NOW()
);

-- Crear tabla transacciones
CREATE TABLE transacciones (
    id TEXT PRIMARY KEY,
    id_cliente TEXT NOT NULL REFERENCES clientes(id),
    id_operacion TEXT REFERENCES operaciones(id),
    monto NUMERIC(15, 2) NOT NULL,
    tipo TEXT NOT NULL,
    descripcion TEXT,
    remitente TEXT,
    destinatario TEXT,
    estado TEXT DEFAULT 'completed',
    fecha TIMESTAMP DEFAULT NOW()
);

-- Insertar datos de prueba en clientes
INSERT INTO clientes (id, nombre, apellido, email, telefono, saldo) VALUES
('CLI-5421', 'Ana', 'García López', 'ana.garcia@email.com', '+34 666 111 222', 15000.00),
('CLI-8832', 'Carlos', 'Ruiz Fernández', 'carlos.ruiz@email.com', '+34 666 333 444', 8500.00),
('CLI-3298', 'María', 'Martínez Sánchez', 'maria.martinez@email.com', '+34 666 555 666', 42000.00),
('CLI-7654', 'Juan', 'López Torres', 'juan.lopez@email.com', '+34 666 777 888', 5200.00),
('CLI-9021', 'Laura', 'Gómez Díaz', 'laura.gomez@email.com', '+34 666 999 000', 12500.00),
('CLI-4432', 'Pedro', 'Sánchez Ruiz', 'pedro.sanchez@email.com', '+34 777 111 222', 3000.00),
('CLI-6678', 'Elena', 'Rodríguez Pérez', 'elena.rodriguez@email.com', '+34 777 333 444', 18000.00),
('CLI-1123', 'Miguel', 'Fernández García', 'miguel.fernandez@email.com', '+34 777 555 666', 25000.00),
('CLI-8845', 'Isabel', 'Torres López', 'isabel.torres@email.com', '+34 777 777 888', 7500.00),
('CLI-3367', 'Francisco', 'Jiménez Mora', 'francisco.jimenez@email.com', '+34 777 999 000', 50000.00);

-- Insertar datos de prueba en operaciones
INSERT INTO operaciones (id, id_cliente, monto, tipo, estado, nivel_riesgo, canal) VALUES
('OP-10245', 'CLI-5421', 12500.00, 'TRANSFER', 'pending', 'medium', 'Web'),
('OP-10246', 'CLI-8832', 450.00, 'BIZUM', 'completed', 'low', 'Móvil'),
('OP-10247', 'CLI-3298', 75000.00, 'TRANSFER', 'reviewing', 'high', 'Oficina'),
('OP-10248', 'CLI-7654', 230.50, 'PAYMENT', 'completed', 'low', 'Web'),
('OP-10249', 'CLI-9021', 8900.00, 'WITHDRAWAL', 'suspicious', 'high', 'Cajero'),
('OP-10250', 'CLI-4432', 1500.00, 'TRANSFER', 'pending', 'low', 'Móvil'),
('OP-10251', 'CLI-6678', 320.00, 'BIZUM', 'rejected', 'medium', 'Web'),
('OP-10252', 'CLI-1123', 25000.00, 'DEPOSIT', 'pending', 'medium', 'Oficina'),
('OP-10253', 'CLI-8845', 680.00, 'PAYMENT', 'completed', 'low', 'Web'),
('OP-10254', 'CLI-3367', 15600.00, 'TRANSFER', 'reviewing', 'high', 'Móvil');

-- Insertar datos de prueba en transacciones
INSERT INTO transacciones (id, id_cliente, id_operacion, monto, tipo, descripcion, remitente, destinatario, estado) VALUES
('TRX-20001', 'CLI-5421', 'OP-10245', 12500.00, 'Transfer', 'Pago factura noviembre', 'Ana García', 'ABC Utilities', 'completed'),
('TRX-20002', 'CLI-8832', 'OP-10246', 450.00, 'Bizum', 'Dinero a amigo', 'Carlos Ruiz', 'Pedro Gómez', 'completed'),
('TRX-20003', 'CLI-3298', 'OP-10247', 75000.00, 'Transfer', 'Inversión inmueble', 'María Martínez', 'Banco Hipotecario', 'completed'),
('TRX-20004', 'CLI-7654', 'OP-10248', 230.50, 'Payment', 'Compra online', 'Juan López', 'Amazon', 'completed'),
('TRX-20005', 'CLI-9021', 'OP-10249', 8900.00, 'Withdrawal', 'Retirada efectivo', 'Laura Gómez', 'Cajero ATM', 'completed'),
('TRX-20006', 'CLI-4432', 'OP-10250', 1500.00, 'Transfer', 'Envío familiar', 'Pedro Sánchez', 'Familia Ruiz', 'pending'),
('TRX-20007', 'CLI-6678', 'OP-10251', 320.00, 'Bizum', 'Pago cena', 'Elena Rodríguez', 'Restaurant Plaza', 'rejected'),
('TRX-20008', 'CLI-1123', 'OP-10252', 25000.00, 'Deposit', 'Ingreso salario', 'Empresa Tech S.L.', 'Miguel Fernández', 'completed'),
('TRX-20009', 'CLI-8845', 'OP-10253', 680.00, 'Payment', 'Suscripción streaming', 'Isabel Torres', 'Netflix', 'completed'),
('TRX-20010', 'CLI-3367', 'OP-10254', 15600.00, 'Transfer', 'Pago proveedor', 'Francisco Jiménez', 'Suministros B2B', 'completed');

-- Habilitar Row Level Security solo si es necesario
-- ALTER TABLE clientes ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE operaciones ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE transacciones ENABLE ROW LEVEL SECURITY;

-- Crear políticas públic de lectura (todo el mundo puede leer)
-- CREATE POLICY "Public read access" ON clientes FOR SELECT USING (true);
-- CREATE POLICY "Public read access" ON operaciones FOR SELECT USING (true);
-- CREATE POLICY "Public read access" ON transacciones FOR SELECT USING (true);
