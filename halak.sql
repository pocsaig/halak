-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Feb 17. 10:04
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `halak`
--
CREATE DATABASE IF NOT EXISTS `halak` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE `halak`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `fogasok`
--

CREATE TABLE `fogasok` (
  `id` int(11) NOT NULL,
  `hal_id` int(11) NOT NULL,
  `horgasz_id` int(11) NOT NULL,
  `datum` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `fogasok`
--

INSERT INTO `fogasok` (`id`, `hal_id`, `horgasz_id`, `datum`) VALUES
(6, 1, 1, '2025-02-10'),
(7, 2, 2, '2025-02-11'),
(8, 3, 3, '2025-02-12'),
(9, 4, 4, '2025-02-13'),
(10, 5, 5, '2025-02-14');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `halak`
--

CREATE TABLE `halak` (
  `id` int(11) NOT NULL,
  `nev` varchar(100) NOT NULL,
  `faj` varchar(100) NOT NULL,
  `meret_cm` decimal(11,0) NOT NULL,
  `to_id` int(11) NOT NULL,
  `kep` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `halak`
--

INSERT INTO `halak` (`id`, `nev`, `faj`, `meret_cm`, `to_id`, `kep`) VALUES
(1, 'Ponty', 'Cyprinus carpio', 45, 1, 0x506f6e74792e706e67),
(2, 'Csuka', 'Esox lucius', 75, 2, 0x4373756b612e706e67),
(3, 'Süllő', 'Sander lucioperca', 55, 3, 0x53c3bc6c6cc5912e706e67),
(4, 'Harcsa', 'Silurus glanis', 120, 4, 0x4861726373612e706e67),
(5, 'Keszeg', 'Abramis brama', 30, 5, 0x4b65737a65672e706e67);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `horgaszok`
--

CREATE TABLE `horgaszok` (
  `id` int(11) NOT NULL,
  `nev` varchar(100) NOT NULL,
  `eletkor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `horgaszok`
--

INSERT INTO `horgaszok` (`id`, `nev`, `eletkor`) VALUES
(1, 'Kovács Péter', 35),
(2, 'Nagy László', 42),
(3, 'Szabó Zoltán', 29),
(4, 'Tóth Gábor', 51),
(5, 'Horváth István', 38);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `tavak`
--

CREATE TABLE `tavak` (
  `id` int(11) NOT NULL,
  `nev` varchar(100) NOT NULL,
  `helyszin` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `tavak`
--

INSERT INTO `tavak` (`id`, `nev`, `helyszin`) VALUES
(1, 'Balaton', 'Magyarország'),
(2, 'Velencei-tó', 'Magyarország'),
(3, 'Tisza-tó', 'Magyarország'),
(4, 'Fertő-tó', 'Ausztria/Magyarország'),
(5, 'Hévízi-tó', 'Magyarország');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `fogasok`
--
ALTER TABLE `fogasok`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hal_id` (`hal_id`),
  ADD KEY `horgasz_id` (`horgasz_id`);

--
-- A tábla indexei `halak`
--
ALTER TABLE `halak`
  ADD PRIMARY KEY (`id`),
  ADD KEY `to_id` (`to_id`);

--
-- A tábla indexei `horgaszok`
--
ALTER TABLE `horgaszok`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `tavak`
--
ALTER TABLE `tavak`
  ADD PRIMARY KEY (`id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `fogasok`
--
ALTER TABLE `fogasok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `halak`
--
ALTER TABLE `halak`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `horgaszok`
--
ALTER TABLE `horgaszok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `tavak`
--
ALTER TABLE `tavak`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `fogasok`
--
ALTER TABLE `fogasok`
  ADD CONSTRAINT `fogasok_ibfk_1` FOREIGN KEY (`hal_id`) REFERENCES `halak` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fogasok_ibfk_2` FOREIGN KEY (`horgasz_id`) REFERENCES `horgaszok` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `halak`
--
ALTER TABLE `halak`
  ADD CONSTRAINT `halak_ibfk_1` FOREIGN KEY (`to_id`) REFERENCES `tavak` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
