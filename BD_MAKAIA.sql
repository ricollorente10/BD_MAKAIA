DROP SCHEMA IF EXISTS makaia;

CREATE SCHEMA IF NOT EXISTS makaia;

USE makaia;

-- Tabla de Oficinas
CREATE TABLE Oficinas (
    CodigoOficina INT AUTO_INCREMENT PRIMARY KEY,
    Ciudad VARCHAR(100) NOT NULL,
    Pais VARCHAR(100) NOT NULL,
    Region VARCHAR(100) NOT NULL,
    CodigoPostal VARCHAR(20) NOT NULL,
    Telefono VARCHAR(20) NOT NULL UNIQUE,
    Direccion VARCHAR(255) NOT NULL
);

-- Tabla de Puestos
CREATE TABLE puestos(
	CodigoPuesto INT AUTO_INCREMENT PRIMARY KEY,
    Puesto VARCHAR(255) NOT NULL,
    Descripcion TEXT NOT NULL
);

-- Tabla de Empleados
CREATE TABLE Empleados (
    CodigoEmpleado INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Apellido1 VARCHAR(100) NOT NULL,
    Apellido2 VARCHAR(100) NOT NULL,
    Extension VARCHAR(20),
    Email VARCHAR(255) NOT NULL UNIQUE,
    CodigoOficina INT NOT NULL,
    CodigoJefe INT,
    CodigoPuesto INT NOT NULL,
    FOREIGN KEY (CodigoOficina) REFERENCES Oficinas(CodigoOficina) ON DELETE CASCADE,
    FOREIGN KEY (CodigoJefe) REFERENCES Empleados(CodigoEmpleado) ON DELETE SET NULL,
    FOREIGN KEY (CodigoPuesto) REFERENCES Puestos(CodigoPuesto) ON DELETE RESTRICT
);

-- Tabla de Clientes
CREATE TABLE Clientes (
    CodigoCliente INT AUTO_INCREMENT PRIMARY KEY,
    NombreCliente VARCHAR(255) NOT NULL,
    NombreContacto VARCHAR(255) NOT NULL,
    ApellidoContacto VARCHAR(255) NOT NULL,
    Telefono VARCHAR(20) NOT NULL UNIQUE,
    Fax VARCHAR(20),
    Direccion1 VARCHAR(255) NOT NULL,
    Direccion2 VARCHAR(255),
    Ciudad VARCHAR(100) NOT NULL,
    Region VARCHAR(100) NOT NULL,
    Pais VARCHAR(100) NOT NULL,
    CodigoPostal VARCHAR(20) NOT NULL,
    LimiteCredito DECIMAL(10, 2) NOT NULL,
    CodigoEmpleado INT,
    FOREIGN KEY (CodigoEmpleado) REFERENCES Empleados(CodigoEmpleado) ON DELETE SET NULL
);

-- Tabla de Pedidos
CREATE TABLE Pedidos (
    CodigoPedido INT AUTO_INCREMENT PRIMARY KEY,
    FechaPedido DATETIME NOT NULL,
    FechaEsperada DATE NOT NULL,
    FechaEntrega DATETIME,
    Estado VARCHAR(50) NOT NULL,
    Comentarios TEXT,
    CodigoCliente INT,
    FOREIGN KEY (CodigoCliente) REFERENCES Clientes(CodigoCliente) ON DELETE SET NULL
);

-- Tabla de Pagos
CREATE TABLE Pagos (
    CodigoPago INT AUTO_INCREMENT PRIMARY KEY,
    CodigoCliente INT,
    FormaPago VARCHAR(50) NOT NULL,
    IDTransaccion VARCHAR(100),
    FechaPago DATETIME NOT NULL,
    TotalPago DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CodigoCliente) REFERENCES Clientes(CodigoCliente) ON DELETE SET NULL
);

-- Tabla de Gamas de Productos
CREATE TABLE GamasDeProductos (
    Gama VARCHAR(100) NOT NULL UNIQUE PRIMARY KEY,
    Descripcion TEXT NOT NULL,
    ImagenAsociada TEXT
);

-- Tabla de Proveedores
CREATE TABLE Proveedores(
	CodigoProveedor INT AUTO_INCREMENT PRIMARY KEY,
    NombreProveedor VARCHAR(255) NOT NULL,
    Direccion VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20) NOT NULL UNIQUE
);

-- Tabla de Productos
CREATE TABLE Productos (
    CodigoProducto INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Gama VARCHAR(100),
    Dimensiones VARCHAR(100),
    CodigoPorveedor INT,
    Descripcion TEXT NOT NULL,
    CantidadEnStock INT NOT NULL,
    PrecioVenta DECIMAL(10, 2) NOT NULL,
    PrecioProveedor DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (Gama) REFERENCES GamasDeProductos(Gama),
    FOREIGN KEY (CodigoPorveedor) REFERENCES Proveedores(CodigoProveedor) ON DELETE SET NULL
);

-- Tabla de Detalle de Pedido (para representar los productos en cada pedido)
CREATE TABLE DetalleDePedido (
    CodigoPedido INT,
    CodigoProducto INT,
    Cantidad INT NOT NULL,
    PrecioPorUnidad DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (CodigoPedido, CodigoProducto),
    FOREIGN KEY (CodigoPedido) REFERENCES Pedidos(CodigoPedido),
    FOREIGN KEY (CodigoProducto) REFERENCES Productos(CodigoProducto)
);
