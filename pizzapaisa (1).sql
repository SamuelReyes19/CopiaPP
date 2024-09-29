-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-09-2024 a las 02:55:04
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pizzapaisa`
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
('Cdr', 'Carne de Res', 18.5),
('Chpm', 'Champinones', 12),
('Chz', 'Chorizo', 5),
('Cra', 'Cereza Almibar', 5),
('Drl', 'Duraznos Almibar', 5),
('jlp', 'Jalapenos', 5),
('Jm', 'Jamon', 8.25),
('Mng', 'Mango', 5),
('Ms', 'Masa', 13.25),
('Mz', 'Maiz', 5),
('Pll', 'Pollo', 9),
('Plt', 'Platano', 5),
('Pmto', 'Pimiento', 5),
('Pna', 'Pina', 4.25),
('Pprn', 'Pepperoni', 10.5),
('Pst', 'Pasta de Tomate', 7.5),
('Qs', 'Queso', 15.5),
('sBBQ', 'Salsa BBQ', 36),
('Slch', 'Salchicha', 4.625),
('Tcn', 'Tocino', 5),
('Uvp', 'Uvas Pasas', 5);

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
('Crt', 9, 4),
('Ptrp', 8, 4),
('Pmx', 8, 1),
('Pllc', 8, 3),
('Pm', 8, 1);

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
(7, '2024-07-27', '5566778899');

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
(7, 'Pll', 4, 2, 4, '2024-07-27'),
(7, 'Jm', 4, 2, 4, '2024-07-27'),
(7, 'sBBQ', 3, 2, 3, '2024-07-27'),
(7, 'sBBQ', 20, 2, 20, '0000-00-00'),
(7, 'cdr', 5, 2, 5, '0000-00-00');

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
(3, 'FurvePaisita', '478541', 'kr8-tv-73', 'Madelena');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva`
--

CREATE TABLE `reserva` (
  `idPedido` int(6) NOT NULL,
  `FechaHoraRealizacio` datetime NOT NULL,
  `Entregada` tinyint(1) NOT NULL,
  `FechaHoraEntrega` datetime NOT NULL,
  `PrecioTotal` int(20) NOT NULL,
  `UsuarioDocumento` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reserva`
--

INSERT INTO `reserva` (`idPedido`, `FechaHoraRealizacio`, `Entregada`, `FechaHoraEntrega`, `PrecioTotal`, `UsuarioDocumento`) VALUES
(1, '2024-07-25 03:47:00', 0, '2024-07-25 04:14:15', 0, '1122334455'),
(2, '2024-07-25 04:40:00', 0, '2024-07-25 05:10:00', 0, '123456789'),
(3, '2024-07-25 05:10:10', 0, '2024-07-25 05:40:15', 0, '4512754'),
(4, '2024-07-25 06:00:00', 0, '2024-07-25 06:30:00', 0, '2233445566'),
(5, '2024-07-25 06:10:00', 0, '2024-07-25 06:40:00', 0, '3344556677'),
(6, '2024-07-25 06:25:00', 0, '2024-07-25 06:55:00', 0, '4455667788'),
(7, '2024-07-25 07:00:00', 0, '2024-07-25 07:30:00', 0, '5566778890'),
(8, '2024-07-25 07:40:00', 0, '2024-07-25 08:10:00', 0, '6677889901'),
(9, '2024-07-30 07:00:00', 0, '2024-07-30 07:27:10', 0, '6677889901'),
(10, '2024-07-30 08:52:00', 0, '2024-07-30 09:21:15', 0, '6677889901'),
(12, '2024-09-24 16:12:00', 0, '2024-09-24 16:44:00', 0, '7464564');

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
  `Contrasena` varchar(60) DEFAULT NULL,
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
('1122334455', '123684', 'Edison12', 'Edison@gmial.com', 'Edison', 'Torres1', 3, 3),
('123456789', '123457', 'lara1', 'lara@gmail.com', 'Lara', 'Carillo', 1, 3),
('2233445566', '654321', 'Pedro12', 'Pedro@gmail.com', 'Pedro', 'Gonzalez', 1, 3),
('23256', '3227327267', 'tryetyet', 'sisi@gmail.com', 'tal diego', 'Monroy', 1, 3),
('3344556677', '765432', 'Ana34', 'Ana@gmail.com', 'Ana', 'Ramirez', 2, 3),
('4455667788', '876543', 'Luis56', 'Luis1@gmail.com', 'Luis', 'Hernandez', 3, 3),
('44655644', '13456654', '$2y$10$JBZjK8Rqd86ninQ9cBaAOuAjqLooKV4nqsCKpl.55IfPvISIJ2UW.', 'Oscar@gmail.com', 'Oscar', 'Marulanda', 1, 1),
('4512324', '4123', 'Carlos12', 'Carlos@gmail.com', 'Carlos', 'Muro', 2, 3),
('4512754', '414783', 'Henry12', 'Henry@gmail.com', 'Henry', 'yabe', 2, 3),
('465464545', '123454', '$2y$10$/.ICg3WLI4NBsS2ZNmFIC.hlTy4HzuEFH', 'Takeshi@gmial.com', 'Eien', 'Takeshi', 1, 3),
('46546645', '4156465', '$2y$10$CD8TzSYYtDSmMxybQphWcuOR/mAQu3UUSjqvZZwUVJCO57e2XvsoW', 'cediel@gmail.com', 'Felipe', 'Cediel', 1, 3),
('46654', '4456465', '$2y$10$um8kdNbMKJLIHt1V0ZmP2eJ3HA5fA.WVUQDaZ/7cWUu4lHgTckxXG', 'Coco@gmail.com', 'Coco', 'dada', 2, 3),
('5456', '45654', '$2y$10$IoKHf7xnlQLFL6pmDtgIw.xTnXoQV.kOFebVY83ZCHwkl7fkduQhy', 'samuel@gmail.com', 'Samuel', 'Santiago', 1, 3),
('54646546', '1654654', '$2y$10$aBTlos8DqIBo.BJ3HK8sVuTf3R.hnV/PKZGCfEZLDhpCJp5ZtCZ/m', 'Darwing@gmail.com', 'Darwin', 'Balles', 2, 3),
('5566778890', '987654', 'Maria78', 'Maria@gmail.com', 'Maria', 'Lopez', 1, 3),
('5566778899', '123857', 'Juan12', 'Juan@gmial.com', 'Juan', 'Monroy', 1, 1),
('6677889901', '543210', 'Jose90', 'Jose@gmail.com', 'Jose', 'Martinez', 2, 3),
('7464564', '154654654', '$2y$10$p0FHLom1wQYsYswglGGEVegMUiFco6GwS', 'Oscar12@gmail.com', 'Oscar', 'Monroy', 3, 3),
('87897564', '313600658', '4510jk', 'salsedo@gmail.com', 'felipe', 'salsedo', 3, 3),
('88888', '11321132', '', 'lizzzet@gmal.com', 'LIZ', 'Torres', 1, 1),
('987654321', '12357854', 'Lautaro22', 'Lautaro@gmail.com', 'Lautaro', 'Lescano', 1, 2);

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
  MODIFY `idOrden` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `idProveedor` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `reserva`
--
ALTER TABLE `reserva`
  MODIFY `idPedido` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
