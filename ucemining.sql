-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 07-06-2024 a las 09:28:15
-- Versión del servidor: 8.0.36-0ubuntu0.20.04.1
-- Versión de PHP: 7.4.3-4ubuntu2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ucemining`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin`
--

CREATE TABLE `admin` (
  `id` int NOT NULL,
  `admin` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `rol` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Volcado de datos para la tabla `admin`
--

INSERT INTO `admin` (`id`, `admin`, `password`, `rol`) VALUES
(1, 'admin', 'pbkdf2:sha256:150000$VeLSFTFz$f04f320a64f5f6e0f684051700ce0136d2ba8c630557f6345b4ecaf88f09a9f9', 'admin');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `company`
--

CREATE TABLE `company` (
  `id` int NOT NULL,
  `empresa` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `rol` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Volcado de datos para la tabla `company`
--

INSERT INTO `company` (`id`, `empresa`, `email`, `password`, `rol`) VALUES
(1, 'company', 'company@email.com', 'pbkdf2:sha256:150000$VeLSFTFz$f04f320a64f5f6e0f684051700ce0136d2ba8c630557f6345b4ecaf88f09a9f9', 'company'),
(2, 'comp1', 'admin@mail.com', 'pbkdf2:sha256:150000$GmdMReLi$a85013ce331d1803f1546af3060df520da27fde8100c226dd96372e70f3cfd0a', 'empresa'),
(3, 'Nicolás Silva', 'nasilvap@uce.udu.ec', 'pbkdf2:sha256:150000$PxPE4SLH$b78d267b7a262fb467786d651c80c5f4f7717c37d84c0f9258627a66658ef4f9', 'empresa'),
(4, '1804782157', 'juanmesi9520@gmail.com', 'pbkdf2:sha256:150000$LpHXnuFd$f17c96cf8dc8400f527d1accfb175738535b1ec57ad15aa1dbe00e2ca7a6c877', 'empresa');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `course`
--

CREATE TABLE `course` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `description` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `area` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `time` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Volcado de datos para la tabla `course`
--

INSERT INTO `course` (`id`, `user_id`, `description`, `area`, `start_date`, `end_date`, `time`) VALUES
(2, 3, 'Micromine', 'Software Técnico', '2019-09-30', '2019-09-30', 40),
(4, 4, 'Impuestos en Minería', 'Legislación Minera', '2021-09-10', '2021-09-15', 20),
(9, 13, 'Simulación en JK Simblast 2D BENCH (Software para voladura a Cielo Abierto)', 'Software Técnico', '2020-07-24', '2020-07-27', 8),
(10, 10, 'Uso y Manejo de Software CIVIL3D', 'Software Técnico', '2010-01-01', '2010-01-05', 40),
(11, 9, 'DIAGRAMACION DE VOLADURA', 'Seguridad Minera', '2021-12-01', '2021-12-03', 12),
(12, 10, 'Uso y manejo del software SGEM\'s', 'Software Técnico', '2020-01-01', '2020-01-06', 40),
(13, 1, 'rtk', 'Software Técnico', '2024-06-02', '2024-06-07', 40);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `education`
--

CREATE TABLE `education` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `level_education` enum('Primaria','Secundaria','Preparatoria/Bachillerato','Universitaria/Tecnologia/Licenciatura','Especialidad','Maestria','Doctorado') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `name_institution` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `degree` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Volcado de datos para la tabla `education`
--

INSERT INTO `education` (`id`, `user_id`, `level_education`, `name_institution`, `start_date`, `end_date`, `degree`) VALUES
(1, 1, 'Universitaria/Tecnologia/Licenciatura', 'Universidad Central del Ecuador', '2014-04-24', '2022-03-30', 'Ingeniero de Minas'),
(2, 3, 'Preparatoria/Bachillerato', 'Unidad Educativa Salesiana Domingo Savio', '2002-09-01', '2014-08-10', 'Ciencias Generales'),
(3, 3, 'Universitaria/Tecnologia/Licenciatura', 'Universidad Central del Ecuador', '2016-09-14', NULL, 'Ingeniería de Minas'),
(4, 4, 'Secundaria', 'Insituto Nacional Mejía', '2011-10-01', '2017-07-01', 'Bachiller en Ciencias'),
(5, 4, 'Universitaria/Tecnologia/Licenciatura', 'Universidad Central del Ecuador', '2017-09-01', NULL, 'Ingeniero de Minas'),
(6, 5, 'Preparatoria/Bachillerato', 'Unidad Educativa \"ConsejoProvincial de Pichincha\"', '2011-09-05', '2016-07-26', 'Bachiller en Contabilidad'),
(7, 5, 'Universitaria/Tecnologia/Licenciatura', 'Universidad Central del Ecuador', '2016-10-03', NULL, 'Ingeniero de Minas'),
(8, 8, 'Preparatoria/Bachillerato', 'Colegio Nacional Experimental Juan Pío Montufar', '2010-01-09', '2010-03-06', 'Ciencias'),
(11, 13, 'Preparatoria/Bachillerato', 'Unidad Educativa Fiscomisional \"Nuestra Señora de Pompeya\"', '2012-09-03', '2015-07-31', 'Bachiller en Ciencias'),
(12, 13, 'Universitaria/Tecnologia/Licenciatura', 'Universidad Central del Ecuador', '2016-04-04', NULL, 'Ingeniero de Minas'),
(13, 20, 'Preparatoria/Bachillerato', 'Unidad Educativa Municipal Eugenio Espejo', '2008-09-18', '2014-07-18', 'Bachiller en Ciencias '),
(14, 20, 'Universitaria/Tecnologia/Licenciatura', 'Universidad Central del Ecuador - Facultad de Ingeniería en Geología, Minas, Petróleos y Ambiental ', '2015-03-18', NULL, 'Ingeniero de Minas '),
(15, 15, 'Preparatoria/Bachillerato', 'Unidad Educativa \"San Vicente de Paúl\"', '2016-09-01', '2017-06-16', 'Bachiller en ciencias'),
(17, 9, 'Universitaria/Tecnologia/Licenciatura', 'UNIVERSIDAD CENTRAL DEL ECUADOR', '2014-04-01', '2021-12-01', 'INGENIERO DE MINAS'),
(18, 10, 'Primaria', 'UNIDAD EDUCATIVA \"SANTO TOMÁS APÓSTOL\"', '2003-09-01', '2010-06-01', 'Educación General Básica'),
(19, 10, 'Secundaria', 'UNIDAD EDUCATIVA \"SANTO TOMÁS APÓSTOL\"', '2010-09-01', '2013-06-01', 'Educación General'),
(20, 10, 'Preparatoria/Bachillerato', 'UNIDAD EDUCATIVA \"SANTO TOMÁS APÓSTOL\"', '2010-06-01', '2016-06-01', 'Bachillerato General Unificado'),
(21, 10, 'Universitaria/Tecnologia/Licenciatura', 'UNIVERSIDAD CENTRAL DEL ECUADOR', '2016-09-01', NULL, 'Ingeniero de Minas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `experience`
--

CREATE TABLE `experience` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `company` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `area_e` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `possition` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `start_date_e` date DEFAULT NULL,
  `end_date_e` date DEFAULT NULL,
  `time_e` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Volcado de datos para la tabla `experience`
--

INSERT INTO `experience` (`id`, `user_id`, `company`, `area_e`, `possition`, `start_date_e`, `end_date_e`, `time_e`) VALUES
(2, 10, 'Municipio de Cayambe', 'Manejo Ambiental', 'Pasante', '2010-01-01', '2012-01-01', 2),
(3, 10, 'CEVALLOS CALISTO CÍA. LTDA.', 'Planificación Minera', 'Pasante', '2021-05-01', '2021-07-01', 1),
(4, 1, 'jjjjjj', 'Seguridad Minera', 'j', '2024-06-11', '2024-06-11', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `language`
--

CREATE TABLE `language` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `language` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `level` enum('Lengua Materna','Elemental - A1','Elemental Superior - A2','Intermedio - B1','Intermedio Superior - B2','Avanzado - C1','Avanzando Superior - C2') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `study_center` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Volcado de datos para la tabla `language`
--

INSERT INTO `language` (`id`, `user_id`, `language`, `level`, `study_center`) VALUES
(1, 3, 'Inglés', 'Elemental Superior - A2', 'Universidad Central del Ecuador'),
(2, 4, 'Inglés', 'Intermedio Superior - B2', 'SECAP'),
(4, 6, 'Español', 'Lengua Materna', ''),
(5, 6, 'Inglés', 'Elemental Superior - A2', 'Centro de Idiomas, Universidad Central del Ecuador '),
(6, 20, 'Inglés', 'Elemental Superior - A2', 'Universidad Central del Ecuador '),
(7, 13, 'Español', 'Lengua Materna', ''),
(8, 13, 'Inglés', 'Elemental Superior - A2', 'Universidad Central del Ecuador'),
(9, 10, 'Español', 'Lengua Materna', 'Centro de Idiomas - Universidad Central del Ecuador'),
(11, 1, 'Español', 'Lengua Materna', '1'),
(12, 1, 'Inglés', 'Elemental Superior - A2', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyectos`
--

CREATE TABLE `proyectos` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `empresa_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `publication`
--

CREATE TABLE `publication` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `pub_date` date DEFAULT NULL,
  `link` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `description` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Volcado de datos para la tabla `publication`
--

INSERT INTO `publication` (`id`, `user_id`, `title`, `pub_date`, `link`, `description`) VALUES
(1, 10, 'Métodos Empíricos en la Definición de Unidades Básicas de Explotación', '2010-01-01', 'https://doi.org/10.7440/res19.2004.07', 'El ensayo argumentativo es un tipo de texto que se introduce en los últimos años de la escolaridad. En el medio universitario constituye un texto de enorme importancia. Las constantes quejas de quienes tienen que vérselas con este tipo de producciones por parte de sus estudiantes y la experiencia de la enseñanza de éste en un colegio privado de alto nivel académico de Bogotá, impulsa esta revisión que busca identificar elementos teóricos y experiencias que incidan favorablemente en su escritura. La confianza en que sí es posible aprender a escribir se ve reforzada por las propuestas que se hacen desde concepciones cognitivistas que validan el proceso de aprendizaje a través de diversos mecanismos como estrategias o instrucciones y desde concepciones socioculturales que impulsan la inmersión en situaciones que promuevan el análisis, la discusión y la confrontación de puntos de vista diferentes.'),
(2, 9, 'RIO COCA', '2021-09-01', '', ''),
(3, 1, 'jjjj', '2024-06-12', '1222', '1222');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `referencep`
--

CREATE TABLE `referencep` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `name_rp` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `profession_rp` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `relation_rp` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `number_rp` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `mail_rp` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Volcado de datos para la tabla `referencep`
--

INSERT INTO `referencep` (`id`, `user_id`, `name_rp`, `profession_rp`, `relation_rp`, `number_rp`, `mail_rp`) VALUES
(2, 4, 'Benjamín Saltos', 'Ingeniero de Mina', 'Compañero/a de Estudio', '+593987316209', 'basaltos@uce.edu.ec'),
(4, 13, 'Dangela Toqueton', 'Ingeniera de Minas', 'Familiar', '(+593) 0959937261', 'dangela.toqueton@gmail.com'),
(5, 10, 'Valeria Ulcuango', 'Ingeniera de Minas', 'Compañero/a de Estudio', '0969532622', 'vaulcuango@uce.edu.ec'),
(6, 1, 'sssss', 'sssss', 'Compañero/a Laboral', '09', '09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `referencew`
--

CREATE TABLE `referencew` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `name_rw` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `profession_rw` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `company_rw` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `position_rw` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `number_rw` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `mail_rw` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Volcado de datos para la tabla `referencew`
--

INSERT INTO `referencew` (`id`, `user_id`, `name_rw`, `profession_rw`, `company_rw`, `position_rw`, `number_rw`, `mail_rw`) VALUES
(6, 10, 'Andrés Cevallos', 'Ingeniero de Minas', 'HOLCIM S.A.', 'Jefe de Mina', '0988836703', 'nasilvap@uce.edu.ec'),
(7, 9, '', '', '', '', '', ''),
(8, 10, 'Edgar Romero', 'Ingeniero Geólogo', 'Ing. Edgar Romero / Servicios Profesionales', 'Gerente Propietario', '0988836703', 'edgar_vromero@gmail.com'),
(9, 1, 'juan', 'sss', 'assss', 'ssss', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `firstname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `career` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `rol` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `photo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `cv` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `age` int DEFAULT NULL,
  `user_type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `contact` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `mail_sec` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `about_me` varchar(1500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `habilitie` varchar(1500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `interest` varchar(1500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `linkendin` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `instagram` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `facebook` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `twitter` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `username`, `email`, `password`, `career`, `create_date`, `rol`, `photo`, `cv`, `age`, `user_type`, `contact`, `mail_sec`, `about_me`, `habilitie`, `interest`, `linkendin`, `instagram`, `facebook`, `twitter`) VALUES
(1, 'José Benjamín', 'Saltos Mancheno', '1724496623', 'jbsaltosm@gmail.com', 'pbkdf2:sha256:150000$VeLSFTFz$f04f320a64f5f6e0f684051700ce0136d2ba8c630557f6345b4ecaf88f09a9f9', 'Ingeniería de Minas', '2021-10-24 01:21:13', 'user', '1724496623', '1724496623', 26, 'Egresado', '+593987316209', 'jbsaltos@acroming.com', 'Persona dedicada que trata de alcanzar sus metas.', 'Responsable\r\nRespetuoso\r\nHonesto', 'CEO de ACROMING ECUADOR', 'https://www.linkedin.com/in/bn1ja', 'https://instagram.com/bn1ja', 'https://www.facebook.com/bn1ja', 'https://twitter.com/bn1ja'),
(2, 'Jessica Fernanda', 'Reinoso Topa', '1720744356', 'benja_89_@hotmail.es', 'pbkdf2:sha256:150000$XGAyNo1x$9a1162913d3ec86db38b56981e19ae938b55d9827749eba6d4c6d1dfc3cacb66', 'Ingeniería de Minas', '2021-11-11 02:53:30', 'user', 'u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'Valeria Alexandra', 'Ulcuango Berrones', '1726109943', 'vaulcuango@uce.edu.ec', 'pbkdf2:sha256:150000$1uuWrnl4$f085ae63e9a209916904124a454529ce2dfdc2f168d1ed4e067b001c6a08aa49', 'Ingeniería de Minas', '2021-11-11 03:11:52', 'user', '1726109943', NULL, 25, 'Estudiante', '0969532622', 'vaulcuango@uce.edu.ec', '', '', '', '', '', '', ''),
(4, 'Luis Angel', 'Perez Bellini', '1717872699', 'luisperes1998@hotmail.com', 'pbkdf2:sha256:150000$a4rKD2cd$571a137902d1eba914f457abf7495cbbcc2843ebf2b53ec9bc6dcd16814e4faf', 'Ingeniería de Minas', '2021-11-12 00:06:43', 'user', '1717872699', '1717872699', 23, 'Estudiante', '+593998779070', 'laperez@uce.edu.ec', 'Me gusta la minería', 'Ingeniería\r\nLiderazgo\r\nGestión y Control', 'Planificación\r\nPerforación y Voladura Subterránea\r\nAuditoría Minera\r\nMetalurgia', 'https://www.linkedin.com/in/luis-p%C3%A9rez-bellini-916885121/', '', '', ''),
(5, 'Kelly Stephanía ', 'Guamán Alarcón ', '1750166256', 'kelly.guaman@hotmail.com', 'pbkdf2:sha256:150000$l1I8YDCu$e75aee3e88a2dbee3d9405a5046c08c7b09fd547b969e7ffb88f0627642a2005', 'Ingeniería de Minas', '2021-11-12 16:28:00', 'user', 'u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 'Andrea Karina', 'Carrión Cabrera', '1719128264', 'akcc.carrion@gmail.com', 'pbkdf2:sha256:150000$6CcHBtlL$62191f03d4c8bd7f4fa69d318bf61aa2c0e02a366eb6c766e694ddce5b648494', 'Ingeniería de Minas', '2021-11-12 17:21:43', 'user', '1719128264', '1719128264', 25, 'Estudiante', '(+593) 93 977 5619', 'akcc.carrion@gmail.com/akcarrion@uce.edu.ec', '', '', '', 'https://www.linkedin.com/in/andrea-carri%C3%B3n-cabrera-103767125/', 'https://www.instagram.com/andre_kcc/?hl=es-la', 'https://www.facebook.com/andrea.carrion.180/', ''),
(7, 'Carlos', 'Perez', '1726181686', 'perez19982009@gmail.com', 'pbkdf2:sha256:150000$okYlvCVQ$10ccb58a3442c30b20a09f76574900ecd3896a5204af91a58c0fe0749b0c3743', 'Ingeniería de Minas', '2021-11-12 17:53:12', 'user', 'u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 'Kevin', 'Santacruz', '1750136499', 'kisantacruz@uce.edu.ec', 'pbkdf2:sha256:150000$cxLCCj5k$8373e1e3459ca8ae6205c637a0a0444d212c017e3e85d81cad48aee9a3cd0f00', 'Ingeniería de Minas', '2021-11-12 18:07:10', 'user', 'u', '1750136499', 23, 'Estudiante', '0962716180', 'kisantacruz@uce.edu.ec', '', '', '', '', '', '', ''),
(9, 'JUAN MESIAS', 'NUÑEZ FREIRE', '1804782157', 'jmnunezf@uce.edu.ec', 'pbkdf2:sha256:150000$OHCmeftV$08a992ed3500c0b3bb778fbc45e5117b0dfacf9ce82274ae99916ad5bcf987ef', 'Ingeniería de Minas', '2021-11-18 20:35:40', 'user', '1804782157', NULL, 26, 'Estudiante', '000000000', '', '', '', '', '', '', '', ''),
(10, 'Nicolás Andrés', 'Silva Palmay', '0604402628', 'nasilvap@uce.edu.ec', 'pbkdf2:sha256:150000$ccT3IWi1$dd5d081cd9ab88062faf8ff3c3b7e915c2c6eec042d680b49acf26f4bbdb0231', 'Ingeniería de Minas', '2021-11-18 22:39:39', 'user', '0604402628', '0604402628', 23, 'Egresado', '(+593) 988836703', 'nasilvapy@gmail.com', 'Soy un estudiante de la FIGEMPA', 'Estoy sumamente interesado en generar un desarrollo profesional completo que brinde las prestaciones adecuadas a los grupos empresariales', 'Software técnico\r\nInglés técnico\r\nLiderazgo empresarial', 'https://www.linkedin.com/in/nasilvapy/', '', '', ''),
(11, 'David Hassan ', 'Chiriboga Garnica', '1400732986', 'dhchiribogag@gmail.com', 'pbkdf2:sha256:150000$vDLC2nTv$4c5d7634de34ddf397e4f0445d3008c8bf013af7ac2938596447b23165ff182b', 'Ingeniería de Minas', '2021-11-18 23:19:32', 'user', '1400732986', NULL, 22, 'Estudiante', '0992031166', 'dhchiribogag@gmail.com', '', '', '', 'https://www.linkedin.com/in/hassan-chiriboga-bab158194/', 'https://www.instagram.com/hassanchiri99/', 'https://www.facebook.com/hassan.chiriboga', 'https://twitter.com/HassanChiriboga'),
(12, 'Christian Daniel', 'Chazo Amaya', '1727288324', 'cdchazo@uce.edu.ec', 'pbkdf2:sha256:150000$fjkYmHVy$19c0384c1003056ecb4614424789f49d17b71c9f5270835f38ddbaccf8984544', 'Ingeniería de Minas', '2021-11-18 23:19:32', 'user', 'u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 'Jayack Ariel', 'Toqueton Tacoaman', '1600650640', 'jayack.toque@gmail.com', 'pbkdf2:sha256:150000$dbvnRRsX$41d679d45fa6ab0d8cc5293ece844b7d96395fa321f11e0ed69270aa37985399', 'Ingeniería de Minas', '2021-11-18 23:19:47', 'user', 'u', NULL, 23, 'Estudiante', '(+593)0992618049', 'jayack.toque@gmail.com', '', '', '', 'www.linkedin.com/in/jayack-toqueton/', 'https://www.instagram.com/jayackt/', '', ''),
(14, 'Leydi Elizabeth', 'Noroña Rosas', '0503760654', 'noroa.leydi@gmail.com', 'pbkdf2:sha256:150000$7mhODPKm$3153e2f077a3e52e47d7e1bc20580a24c114e7b6bf26e2dab7ea407c98e046d4', 'Ingeniería de Minas', '2021-11-18 23:21:00', 'user', 'u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, 'Steven Fernando', 'Toapanta Delgado', '1718198649', 'stevenfernando51@gmail.com', 'pbkdf2:sha256:150000$SlFVhIkt$e129b78bb9fe9d92c719b16416a5846aa9fa4c8d042239709a2a615aa2522056', 'Ingeniería de Minas', '2021-11-18 23:21:56', 'user', 'u', NULL, 22, 'Estudiante', '(+593) 988989535', 'stevenfernando51@gmail.com', '', '', '', '', '', '', ''),
(16, 'Luis Angel', 'Pérez Belllini', '6666666666', 'laperez@uce.edu.ec', 'pbkdf2:sha256:150000$5bqEg8QI$b2405459ff444db4d3167303479d301cbb6c5fb4a2e438770a480075227f1e8d', 'Ingeniería de Minas', '2021-11-18 23:22:46', 'user', 'u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, 'Bryan Alejandro', 'Analuisa', '1400946388', 'bareyesa@uce.edu.ec', 'pbkdf2:sha256:150000$mrwFjXCq$df7201ecd95e1e9187b8c77a75f531cfba18e49e905dfc94181869e9c12f4b71', 'Ingeniería de Minas', '2021-11-18 23:23:39', 'user', 'u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(18, 'Cynthia Estefanía ', 'Saltos García ', '1726875972', 'estefaniasaltos16@hotmail.com', 'pbkdf2:sha256:150000$gqwZbojP$5bae0dd40aa60f40982d42dcfae4125457b40b217ae424058a6d6fc2ee6ac68d', 'Ingeniería de Minas', '2021-11-18 23:25:10', 'user', 'u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(19, 'Andrea Sofía', 'Córdova Nájera', '1723095178', 'ascordovan@uce.edu.ec', 'pbkdf2:sha256:150000$NCxmuYXp$77ada266e552d543403d5daa7ae84935a350cea51ed582f94e6c51aba1aa6c46', 'Ingeniería de Minas', '2021-11-18 23:26:52', 'user', 'u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(20, 'Juan Francisco', 'Cabrera Valladares ', '1723453310', 'panchocabm@gmail.com', 'pbkdf2:sha256:150000$BPs0lVAu$388eb10b9642bf9e7347549e9398219fd33e596dcf8edfaef6f7717d6ebb4887', 'Ingeniería de Minas', '2021-11-18 23:58:40', 'user', 'u', '1723453310', 25, 'Egresado', '+593958777532', 'panchocabm@gmail.com ', 'Soy egresado de ingeniería de minas, próximo a titularse en la búsqueda de una oportunidad para ejercer mi profesión.  Me caracteriza mi puntualidad, proactividad y compromiso con mi trabajo. ', 'Manejo eficiente de software de diseño, planificación de minas y simulación de operaciones mineras. Facilidad para relacionarme con las personas, adaptabilidad a cualquier proyecto que tenga que ejecutar. Manejo eficiente de Excel y nociones de Power BI. ', 'Planificación y secuenciamiento de minas a corto plazo, perforación y voladura, sistemas dispatch para control de flota, relleno hidráulico de minas subterráneas, sistemas de explotación, ingeniería económica. ', 'https://www.linkedin.com/in/juan-francisco-cabrera-446786144', '', '', ''),
(21, 'Rosa Pamela', 'Verdezoto Velarde', '0201651486', 'rospavv@yahoo.es', 'pbkdf2:sha256:150000$WBgqwEwW$ded3e3cd5a32dbb9b62848ff2533ab139a6f40d463d076844ed8eeb95c92ec1f', 'Ingeniería de Minas', '2021-11-25 02:59:29', 'user', 'u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `volunteering`
--

CREATE TABLE `volunteering` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `organization` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `possition` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `activities` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Volcado de datos para la tabla `volunteering`
--

INSERT INTO `volunteering` (`id`, `user_id`, `organization`, `possition`, `start_date`, `end_date`, `activities`) VALUES
(3, 9, 'SME UCE', 'FUNDADOR', '2021-09-13', '2021-11-20', ''),
(4, 10, 'Asociación de Scouts del Ecuadors', 'Miembor activo / Dirigente de Tropa', '2005-05-01', '2015-01-01', 'Liderar grupos de estudiantes\r\nOrganizar proyectos de vinculación con la sociedad'),
(5, 10, 'Society of Mining, Metallurgy and Exploration', 'Secretario', '2018-01-01', '2019-01-01', 'Comunicación departamental\r\nPresentación de informe semestral de trabajo'),
(6, 1, 'ggggg', 'ggggg', '2024-06-11', '2024-06-20', '');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `education`
--
ALTER TABLE `education`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `experience`
--
ALTER TABLE `experience`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `language`
--
ALTER TABLE `language`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuarios` (`user_id`),
  ADD KEY `empresas` (`empresa_id`);

--
-- Indices de la tabla `publication`
--
ALTER TABLE `publication`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `referencep`
--
ALTER TABLE `referencep`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `referencew`
--
ALTER TABLE `referencew`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `volunteering`
--
ALTER TABLE `volunteering`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `company`
--
ALTER TABLE `company`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `course`
--
ALTER TABLE `course`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `education`
--
ALTER TABLE `education`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `experience`
--
ALTER TABLE `experience`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `language`
--
ALTER TABLE `language`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `publication`
--
ALTER TABLE `publication`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `referencep`
--
ALTER TABLE `referencep`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `referencew`
--
ALTER TABLE `referencew`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `volunteering`
--
ALTER TABLE `volunteering`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `course_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `education`
--
ALTER TABLE `education`
  ADD CONSTRAINT `education_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `experience`
--
ALTER TABLE `experience`
  ADD CONSTRAINT `experience_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `language`
--
ALTER TABLE `language`
  ADD CONSTRAINT `language_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `proyectos`
--
ALTER TABLE `proyectos`
  ADD CONSTRAINT `empresas` FOREIGN KEY (`empresa_id`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usuarios` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `publication`
--
ALTER TABLE `publication`
  ADD CONSTRAINT `publication_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `referencep`
--
ALTER TABLE `referencep`
  ADD CONSTRAINT `referencep_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `referencew`
--
ALTER TABLE `referencew`
  ADD CONSTRAINT `referencew_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `volunteering`
--
ALTER TABLE `volunteering`
  ADD CONSTRAINT `volunteering_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
