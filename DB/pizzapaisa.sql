-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-03-2025 a las 19:55:02
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pizzapaisaa`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingrediente`
--

CREATE TABLE `ingrediente` (
  `idIngrediente` varchar(30) NOT NULL,
  `Descripcion` varchar(40) NOT NULL,
  `Existenciaskg` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ingrediente`
--

INSERT INTO `ingrediente` (`idIngrediente`, `Descripcion`, `Existenciaskg`) VALUES
('Act', 'Aceitunas', 5),
('Cbll', 'Cebolla', 5),
('Cdr', 'Carne de Res', 14),
('Chpm', 'Champinones', 12),
('Chz', 'Chorizo', 5),
('Cra', 'Cereza Almibar', 5),
('Drl', 'Duraznos Almibar', 5),
('jlp', 'Jalapenos', 5),
('Jm', 'Jamon', 9),
('Mng', 'Mango', 5),
('Ms', 'Masa', 17),
('Mz', 'Maiz', 5),
('Pll', 'Pollo', 10),
('Plt', 'Platano', 5),
('Pmto', 'Pimiento', 5),
('Pna', 'Pina', 5),
('Pprn', 'Pepperoni', 11),
('Pst', 'Pasta de Tomate', 9),
('Qs', 'Queso', 17),
('sBBQ', 'Salsa BBQ', 36),
('Slch', 'Salchicha', 5),
('Tcn', 'Tocino', 5),
('Uvp', 'Uvas Pasas', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `linea`
--

CREATE TABLE `linea` (
  `idSabor` varchar(20) NOT NULL,
  `idPedido` int(6) NOT NULL,
  `NumeroPorciones` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `linea`
--

INSERT INTO `linea` (`idSabor`, `idPedido`, `NumeroPorciones`) VALUES
('Crt', 1, 1),
('PcBBQ', 2, 1),
('Pmx', 2, 1),
('Pllc', 3, 2),
('Pps', 4, 1),
('PcBBQ', 5, 1),
('Prh', 5, 1),
('Crt', 6, 1),
('PcBBQ', 6, 1),
('Pps', 6, 1),
('Phw', 7, 1),
('Pmx', 8, 1),
('Pmt', 8, 1),
('Phw', 8, 2),
('Phw', 8, 2),
('PcBBQ', 8, 3),
('Crt', 8, 2),
('Crt', 15, 1),
('Phw', 15, 2),
('Pllc', 15, 2),
('Phw', 15, 2),
('Phw', 17, 4),
('Phw', 18, 4),
('Phw', 19, 10),
('Phw', 20, 11),
('Phw', 21, 5),
('Pmx', 21, 3),
('Ptrp', 21, 3),
('Prh', 21, 2),
('Prh', 21, 2),
('Prh', 21, 2);

--
-- Disparadores `linea`
--
DELIMITER $$
CREATE TRIGGER `ingrediente` AFTER INSERT ON `linea` FOR EACH ROW update ingrediente, (select * from saboringrediente where idSabor = (select idSabor from linea order by idPedido desc limit 1)) as  Nuevo, (select * from linea order by idPedido desc limit 1) as linea set ingrediente.Existenciaskg = ingrediente.Existenciaskg - (Nuevo.Cantidadkg * linea.NumeroPorciones) where ingrediente.idIngrediente =Nuevo.idIngrediente
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ordendecompra`
--

CREATE TABLE `ordendecompra` (
  `idOrden` int(5) NOT NULL,
  `FechaPedido` date NOT NULL,
  `UsuarioDocumento` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ordendecompra`
--

INSERT INTO `ordendecompra` (`idOrden`, `FechaPedido`, `UsuarioDocumento`) VALUES
(3, '2024-07-23', '987654321'),
(4, '2024-07-24', '987654321'),
(5, '2024-07-25', '5566778899'),
(6, '2024-07-26', '987654321'),
(7, '2024-07-27', '5566778899'),
(8, '2025-03-16', '5566778899');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ordeningrediente`
--

CREATE TABLE `ordeningrediente` (
  `idOrden` int(5) NOT NULL,
  `idIngrediente` varchar(30) NOT NULL,
  `CantidadSolicitada` float NOT NULL,
  `idProveedor` int(6) NOT NULL,
  `CantidadComprada` float NOT NULL,
  `FechaCompra` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ordeningrediente`
--

INSERT INTO `ordeningrediente` (`idOrden`, `idIngrediente`, `CantidadSolicitada`, `idProveedor`, `CantidadComprada`, `FechaCompra`) VALUES
(3, 'Act', 5, 1, 5, '2024-07-24'),
(3, 'Cbll', 5, 1, 5, '2024-07-24'),
(3, 'Cdr', 5, 1, 5, '2024-07-24'),
(3, 'Chpm', 5, 1, 5, '2024-07-24'),
(3, 'Chz', 5, 1, 5, '2024-07-24'),
(3, 'Cra', 5, 1, 5, '2024-07-24'),
(3, 'Drl', 5, 1, 5, '2024-07-24'),
(3, 'jlp', 5, 1, 5, '2024-07-24'),
(3, 'Jm', 5, 1, 5, '2024-07-24'),
(3, 'Mng', 5, 1, 5, '2024-07-24'),
(3, 'Ms', 5, 1, 5, '2024-07-24'),
(3, 'Mz', 5, 1, 5, '2024-07-24'),
(4, 'Pll', 5, 2, 5, '2024-07-25'),
(4, 'Plt', 5, 2, 5, '2024-07-25'),
(4, 'Pmto', 5, 2, 5, '2024-07-25'),
(4, 'Pna', 5, 2, 5, '2024-07-25'),
(4, 'Pprn', 5, 2, 5, '2024-07-25'),
(4, 'Pst', 5, 2, 5, '2024-07-25'),
(4, 'Qs', 5, 2, 5, '2024-07-25'),
(4, 'sBBQ', 5, 2, 5, '2024-07-25'),
(4, 'Slch', 5, 2, 5, '2024-07-25'),
(4, 'Tcn', 5, 2, 5, '2024-07-25'),
(4, 'Uvp', 5, 2, 5, '2024-07-25'),
(5, 'Qs', 6, 3, 6, '2024-07-26'),
(5, 'Ms', 8, 3, 8, '2024-07-26'),
(5, 'Cdr', 4, 3, 4, '2024-07-26'),
(5, 'Pprn', 6, 3, 6, '2024-07-26'),
(6, 'Qs', 6, 1, 6, '2024-07-27'),
(6, 'Ms', 4, 1, 4, '2024-07-27'),
(6, 'Pst', 4, 1, 4, '2024-07-27'),
(6, 'sBBQ', 8, 1, 8, '2024-07-27'),
(7, 'Chpm', 7, 2, 7, '2024-07-27'),
(7, 'Pll', 5, 2, 5, '2024-07-27'),
(7, 'Jm', 4, 2, 4, '2024-07-27'),
(7, 'sBBQ', 3, 2, 3, '2024-07-27'),
(7, 'sBBQ', 20, 2, 20, '0000-00-00'),
(7, 'cdr', 5, 2, 5, '0000-00-00'),
(7, 'Uvp', 1, 2, 1, '2024-07-29');

--
-- Disparadores `ordeningrediente`
--
DELIMITER $$
CREATE TRIGGER `ingrediente_suma` AFTER INSERT ON `ordeningrediente` FOR EACH ROW update ingrediente i set Existenciaskg =(select SUM(oi.CantidadComprada) from ordeningrediente oi where i.idIngrediente = oi.idIngrediente) where idIngrediente = idIngrediente
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `idProveedor` int(6) NOT NULL,
  `NombreProveedor` varchar(40) NOT NULL,
  `NumeroTelefono` varchar(11) NOT NULL,
  `direccion` varchar(30) NOT NULL,
  `Barrio` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`idProveedor`, `NombreProveedor`, `NumeroTelefono`, `direccion`, `Barrio`) VALUES
(1, 'Lichigo el Mono', '456321', 'kr13 sur k', 'Perdomo'),
(2, 'Lichi la mona', '458541', 'kr18-nort-c', 'Candelaria'),
(3, 'FurvePaisita', '478541', 'kr8-tv-73', 'Madelena'),
(4, 'Lichigueria el pepe', '4566666', 'calle Villa Alsacia5', 'Villa Alsaci');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva`
--

CREATE TABLE `reserva` (
  `idPedido` int(6) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `Entregada` tinyint(1) NOT NULL,
  `FechaHoraEntrega` datetime NOT NULL,
  `PrecioTotal` int(20) NOT NULL,
  `UsuarioDocumento` varchar(12) NOT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reserva`
--

INSERT INTO `reserva` (`idPedido`, `created_at`, `Entregada`, `FechaHoraEntrega`, `PrecioTotal`, `UsuarioDocumento`, `updated_at`) VALUES
(1, '2024-07-25 03:47:00', 0, '2024-07-25 04:14:00', 0, '1122334455', NULL),
(2, '2024-07-25 04:40:00', 0, '2024-07-25 05:10:00', 0, '123456789', NULL),
(3, '2024-07-25 05:10:10', 0, '2024-07-25 05:40:15', 0, '4512754', NULL),
(4, '2024-07-25 06:00:00', 0, '2024-07-25 06:30:00', 0, '2233445566', NULL),
(5, '2024-07-25 06:10:00', 0, '2024-07-25 06:40:00', 0, '3344556677', NULL),
(6, '2024-07-25 06:25:00', 0, '2024-07-25 06:55:00', 0, '4455667788', NULL),
(7, '2024-07-25 07:00:00', 0, '2024-07-25 07:30:00', 0, '5566778890', NULL),
(8, '2024-07-25 07:40:00', 0, '2024-07-25 08:10:00', 0, '6677889901', NULL),
(9, '2024-07-30 07:00:00', 0, '2024-07-30 07:27:10', 0, '6677889901', NULL),
(10, '2024-07-30 08:52:00', 0, '2024-07-30 09:21:15', 0, '6677889901', NULL),
(12, '2024-10-08 15:24:00', 0, '2024-10-09 15:24:00', 0, '123456789', NULL),
(15, '2024-12-04 14:30:00', 0, '2024-12-04 15:30:00', 0, '6677889901', NULL),
(16, '2024-12-08 23:05:30', 0, '2024-07-25 04:14:00', 0, '1122334455', '2024-12-08 23:05:30'),
(17, '2024-12-08 23:09:30', 0, '2024-12-09 20:09:00', 52000, '1124217751', '2024-12-08 23:09:30'),
(18, '2024-12-08 23:13:28', 0, '2024-12-09 20:09:00', 52000, '1124217751', '2024-12-08 23:13:28'),
(19, '2024-12-09 19:44:49', 0, '2024-12-09 17:45:00', 130000, '1124217751', '2024-12-09 19:44:49'),
(20, '2024-12-09 19:46:07', 0, '2024-12-10 17:45:00', 143000, '1124217751', '2024-12-09 19:46:07'),
(21, '2024-12-09 21:45:23', 0, '2024-12-10 19:48:00', 70000, '1124217751', '2024-12-09 21:45:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sabor`
--

CREATE TABLE `sabor` (
  `idSabor` varchar(20) NOT NULL,
  `Nombre_Pizza` varchar(40) NOT NULL,
  `Precio_Porcion` smallint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sabor`
--

INSERT INTO `sabor` (`idSabor`, `Nombre_Pizza`, `Precio_Porcion`) VALUES
('Crt', 'Pizza Carne Tradicional', 14000),
('PcBBQ', 'Pizza de CarneBBQ', 14000),
('Phw', 'Pizza Hawaiana', 14000),
('Pllc', 'Pollo Champi?ones', 14000),
('Pm', 'Pizza de Maduro', 14000),
('Pmt', 'Pizaa MangoTocineta', 14000),
('Pmx', 'Pizza Mexicana', 14000),
('Pps', 'Pizza Paisa', 14000),
('Prh', 'Pizza Ranchera', 14000),
('Ptrp', 'Pizza Tropical', 14000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `saboringrediente`
--

CREATE TABLE `saboringrediente` (
  `idSabor` varchar(20) NOT NULL,
  `idIngrediente` varchar(30) NOT NULL,
  `Cantidadkg` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `saboringrediente`
--

INSERT INTO `saboringrediente` (`idSabor`, `idIngrediente`, `Cantidadkg`) VALUES
('Crt', 'Ms', 0.125),
('Crt', 'Pprn', 0.05),
('Crt', 'Cdr', 0.05),
('Crt', 'Pst', 0.05),
('Crt', 'Qs', 0.05),
('Crt', 'Slch', 0.0375),
('PcBBQ', 'Ms', 0.125),
('PcBBQ', 'Pprn', 0.05),
('PcBBQ', 'Cdr', 0.05),
('PcBBQ', 'Pst', 0.05),
('PcBBQ', 'Qs', 0.05),
('PcBBQ', 'sBBQ', 0.05),
('PcBBQ', 'Pmto', 0.025),
('Phw', 'Ms', 0.125),
('Phw', 'Jm', 0.0375),
('Phw', 'Pst', 0.05),
('Phw', 'Qs', 0.05),
('Phw', 'Pna', 0.0375),
('Pllc', 'Ms', 0.125),
('Pllc', 'Pll', 0.05),
('Pllc', 'Chpm', 0.05),
('Pllc', 'Pst', 0.05),
('Pllc', 'Qs', 0.05),
('Pm', 'Ms', 0.125),
('Pm', 'Cdr', 0.05),
('Pm', 'Plt', 0.05),
('Pm', 'Pst', 0.05),
('Pm', 'Qs', 0.05),
('Pmt', 'Ms', 0.125),
('Pmt', 'Mng', 0.0375),
('Pmt', 'Pst', 0.05),
('Pmt', 'Qs', 0.05),
('Pmt', 'Tcn', 0.0375),
('Pmx', 'Ms', 0.125),
('Pmx', 'Cdr', 0.05),
('Pmx', 'Pst', 0.05),
('Pmx', 'Qs', 0.05),
('Pmx', 'jlp', 0.025),
('Pmx', 'Pmto', 0.0125),
('Pmx', 'Cbll', 0.025),
('Pps', 'Ms', 0.125),
('Pps', 'Tcn', 0.0375),
('Pps', 'Pst', 0.05),
('Pps', 'Qs', 0.05),
('Pps', 'Cbll', 0.0375),
('Pps', 'Chz', 0.0375),
('Pps', 'Mz', 0.0375),
('Prh', 'Ms', 0.125),
('Prh', 'Cdr', 0.05),
('Prh', 'Pst', 0.05),
('Prh', 'Qs', 0.05),
('Prh', 'jlp', 0.025),
('Ptrp', 'Ms', 0.125),
('Ptrp', 'Uvp', 0.025),
('Ptrp', 'Pst', 0.05),
('Ptrp', 'Qs', 0.05),
('Ptrp', 'Pna', 0.0375),
('Ptrp', 'Drl', 0.025),
('Ptrp', 'Cra', 0.025);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipodocumento`
--

CREATE TABLE `tipodocumento` (
  `idTipoDocumento` int(6) NOT NULL,
  `tipoDocumento` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipodocumento`
--

INSERT INTO `tipodocumento` (`idTipoDocumento`, `tipoDocumento`) VALUES
(1, 'Cedula de Ciudadania'),
(2, 'Cedula de Extranjeria'),
(3, 'Numero de Pasaporte');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipousuario`
--

CREATE TABLE `tipousuario` (
  `idTipoUsuario` int(5) NOT NULL,
  `tipoUsuario` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipousuario`
--

INSERT INTO `tipousuario` (`idTipoUsuario`, `tipoUsuario`) VALUES
(1, 'Gerente'),
(2, 'Encargado de Reserva'),
(3, 'Cliente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `UsuarioDocumento` varchar(20) NOT NULL,
  `UsuarioTelefono` varchar(11) NOT NULL,
  `Contrasena` varchar(70) NOT NULL,
  `Correo` varchar(30) NOT NULL,
  `UsuarioPrimerNombre` varchar(40) NOT NULL,
  `UsuarioApellido` varchar(40) NOT NULL,
  `idTipoDocumento` int(5) NOT NULL,
  `idTipoUsuario` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`UsuarioDocumento`, `UsuarioTelefono`, `Contrasena`, `Correo`, `UsuarioPrimerNombre`, `UsuarioApellido`, `idTipoDocumento`, `idTipoUsuario`) VALUES
('1122334455', '12368451', '.....', 'Edison@gmial.com', 'Edison', 'Torres', 3, 3),
('1124217751', '3012864378', 'odmb7750', 'odmarulandab@unal.edu.co', 'Oscar', 'Marulanda', 1, 1),
('123456789', '1234575', 'lara1', 'lara@gmail.com', 'Lara', 'Carillo', 1, 3),
('15554', '32284566611', '', 'miguel@gmail.com', 'Miguel', 'Suarez', 1, 1),
('1564654', '4122353', '$2y$10$1LqbbwlmDGmGktTaIcPPbeO9EXoo6ycnUe4Vicwcyfp9hXLoK3Oci', 'Takeshi123@gmail.com', 'Eien', 'Takeshi12', 1, 1),
('221212', '33311', 'bravo123', 'bravo@gmail.com', 'juan', 'bravo', 1, 1),
('2233445566', '654321', 'Pedro12', 'Pedro@gmail.com', 'Pedro1515', 'Gonzalez', 1, 3),
('3230213123', '4122353', '$2y$10$UqVw8fW.fBUcJIQUD9M9iO.yQ6QbhAsb1SIzevouPSfPU53LnQYcG', 'Takeshi123@gmail.com', 'Eien', 'Takeshi12', 1, 1),
('3344556677', '765432', 'Ana34', 'Ana@gmail.com', 'Ana', 'Ramirez', 2, 3),
('4444444', '44445', 'agogo4', 'juanagogo@gmail.com', 'juan', 'agogo', 2, 3),
('4455667788', '87654', 'Luis56', 'Luis@gmail.com', 'Luis', 'Hernandez', 3, 3),
('4512324', '4123', 'Carlos12', 'Carlos@gmail.com', 'Carlos', 'Muro', 2, 3),
('4512754', '41478', 'Henry12', 'Henry@gmail.com', 'Henry', 'yabe', 2, 3),
('464545456', '322154587', 'deivison12', 'deiviso@gmail.com', 'deivison', 'ortega', 1, 1),
('5566778890', '9876541', 'Maria78', 'Maria@gmail.com', 'Maria', 'Lopez', 1, 3),
('5566778899', '123857', 'Juan12', 'Juan@gmial.com', 'Juan', 'Monroy', 1, 1),
('6677889901', '543210', 'Jose90', 'Jose@gmail.com', 'Jose', 'Martinez1', 2, 3),
('777777', '8888888', 'hola1111', 'hola1@gmail.com', 'hola', 'hola2', 1, 1),
('8889', '32154', 'juan123', 'estaban@gmail.com', 'esteban', 'ju', 2, 1),
('987654321', '12357854', 'Lautaro22', 'Lautaro@gmail.com', 'Lautaro', 'Lescano2', 2, 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ingrediente`
--
ALTER TABLE `ingrediente`
  ADD PRIMARY KEY (`idIngrediente`);

--
-- Indices de la tabla `linea`
--
ALTER TABLE `linea`
  ADD KEY `idSabor` (`idSabor`),
  ADD KEY `idPedido` (`idPedido`);

--
-- Indices de la tabla `ordendecompra`
--
ALTER TABLE `ordendecompra`
  ADD PRIMARY KEY (`idOrden`),
  ADD KEY `UsuarioTelefono` (`UsuarioDocumento`);

--
-- Indices de la tabla `ordeningrediente`
--
ALTER TABLE `ordeningrediente`
  ADD KEY `idOrden` (`idOrden`),
  ADD KEY `idIngrediente` (`idIngrediente`),
  ADD KEY `fk_ordeningrediente_proveedor` (`idProveedor`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`idProveedor`);

--
-- Indices de la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD PRIMARY KEY (`idPedido`),
  ADD KEY `UsuarioTelefono` (`UsuarioDocumento`);

--
-- Indices de la tabla `sabor`
--
ALTER TABLE `sabor`
  ADD PRIMARY KEY (`idSabor`);

--
-- Indices de la tabla `saboringrediente`
--
ALTER TABLE `saboringrediente`
  ADD KEY `idSabor` (`idSabor`),
  ADD KEY `idIngrediente` (`idIngrediente`);

--
-- Indices de la tabla `tipodocumento`
--
ALTER TABLE `tipodocumento`
  ADD PRIMARY KEY (`idTipoDocumento`);

--
-- Indices de la tabla `tipousuario`
--
ALTER TABLE `tipousuario`
  ADD PRIMARY KEY (`idTipoUsuario`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`UsuarioDocumento`),
  ADD KEY `idTipoDocumento` (`idTipoDocumento`),
  ADD KEY `idTipoUsuario` (`idTipoUsuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ordendecompra`
--
ALTER TABLE `ordendecompra`
  MODIFY `idOrden` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `idProveedor` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `reserva`
--
ALTER TABLE `reserva`
  MODIFY `idPedido` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `tipodocumento`
--
ALTER TABLE `tipodocumento`
  MODIFY `idTipoDocumento` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipousuario`
--
ALTER TABLE `tipousuario`
  MODIFY `idTipoUsuario` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `linea`
--
ALTER TABLE `linea`
  ADD CONSTRAINT `linea` FOREIGN KEY (`idSabor`) REFERENCES `sabor` (`idSabor`),
  ADD CONSTRAINT `linea_ibfk_1` FOREIGN KEY (`idPedido`) REFERENCES `reserva` (`idPedido`);

--
-- Filtros para la tabla `ordendecompra`
--
ALTER TABLE `ordendecompra`
  ADD CONSTRAINT `ordendecompra_ibfk_1` FOREIGN KEY (`UsuarioDocumento`) REFERENCES `usuario` (`UsuarioDocumento`);

--
-- Filtros para la tabla `ordeningrediente`
--
ALTER TABLE `ordeningrediente`
  ADD CONSTRAINT `fk_ordeningrediente_proveedor` FOREIGN KEY (`idProveedor`) REFERENCES `proveedor` (`idProveedor`),
  ADD CONSTRAINT `ordeningrediente_ibfk_1` FOREIGN KEY (`idOrden`) REFERENCES `ordendecompra` (`idOrden`),
  ADD CONSTRAINT `ordeningrediente_ibfk_2` FOREIGN KEY (`idIngrediente`) REFERENCES `ingrediente` (`idIngrediente`);

--
-- Filtros para la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD CONSTRAINT `reserva_ibfk_1` FOREIGN KEY (`UsuarioDocumento`) REFERENCES `usuario` (`UsuarioDocumento`);

--
-- Filtros para la tabla `saboringrediente`
--
ALTER TABLE `saboringrediente`
  ADD CONSTRAINT `saboringrediente_ibfk_1` FOREIGN KEY (`idSabor`) REFERENCES `sabor` (`idSabor`),
  ADD CONSTRAINT `saboringrediente_ibfk_2` FOREIGN KEY (`idIngrediente`) REFERENCES `ingrediente` (`idIngrediente`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`idTipoDocumento`) REFERENCES `tipodocumento` (`idTipoDocumento`),
  ADD CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`idTipoUsuario`) REFERENCES `tipousuario` (`idTipoUsuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
