-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 16 juin 2026 à 18:14
-- Version du serveur : 9.1.0
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `lido_serena`
--

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id_category` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `id_parent` int DEFAULT NULL,
  PRIMARY KEY (`id_category`),
  KEY `id_parent` (`id_parent`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id_category`, `nom`, `id_parent`) VALUES
(9, 'Entrée', NULL),
(10, 'Plat', NULL),
(11, 'Dessert', NULL),
(12, 'Boisson', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `commandes`
--

DROP TABLE IF EXISTS `commandes`;
CREATE TABLE IF NOT EXISTS `commandes` (
  `id_com` int NOT NULL AUTO_INCREMENT,
  `id_staff` int DEFAULT NULL,
  `montant` decimal(10,2) NOT NULL,
  `statut_commande` enum('en attente','en cuisine','prête','livrée') COLLATE utf8mb4_general_ci DEFAULT 'en attente',
  `mode_paiement` enum('espèces','carte') COLLATE utf8mb4_general_ci NOT NULL,
  `statut_paiement` enum('non payé','payé') COLLATE utf8mb4_general_ci DEFAULT 'non payé',
  `date_commande` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_com`),
  KEY `id_staff` (`id_staff`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `commandes`
--

INSERT INTO `commandes` (`id_com`, `id_staff`, `montant`, `statut_commande`, `mode_paiement`, `statut_paiement`, `date_commande`) VALUES
(6, 1, 17.00, 'en cuisine', 'carte', 'non payé', '2026-04-07 15:16:31'),
(7, 2, 25.50, 'en cuisine', 'espèces', 'payé', '2026-04-07 15:23:18'),
(10, 2, 17.50, 'en cuisine', 'carte', 'payé', '2026-04-07 15:24:49'),
(11, 1, 18.00, 'en cuisine', 'carte', 'payé', '2026-04-07 15:27:15'),
(12, 2, 34.00, 'en cuisine', 'espèces', 'payé', '2026-04-07 15:27:15'),
(13, 1, 17.00, 'en cuisine', 'carte', 'non payé', '2026-04-07 15:27:16'),
(14, NULL, 99999999.99, '', 'carte', '', '2026-04-07 17:13:34'),
(15, NULL, 10.00, '', 'carte', '', '2026-04-07 17:14:44');

-- --------------------------------------------------------

--
-- Structure de la table `commandes_menus`
--

DROP TABLE IF EXISTS `commandes_menus`;
CREATE TABLE IF NOT EXISTS `commandes_menus` (
  `id_com` int NOT NULL,
  `id_menu` int NOT NULL,
  `quantite` int NOT NULL DEFAULT '1',
  KEY `id_com` (`id_com`),
  KEY `id_menu` (`id_menu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `commandes_menus`
--

INSERT INTO `commandes_menus` (`id_com`, `id_menu`, `quantite`) VALUES
(6, 10, 1),
(11, 1, 1),
(12, 9, 1),
(12, 10, 1),
(13, 10, 1);

-- --------------------------------------------------------

--
-- Structure de la table `menus`
--

DROP TABLE IF EXISTS `menus`;
CREATE TABLE IF NOT EXISTS `menus` (
  `id_menu` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `prix` decimal(10,2) NOT NULL,
  `date_creation` date DEFAULT NULL,
  `disponible` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_menu`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `menus`
--

INSERT INTO `menus` (`id_menu`, `nom`, `description`, `prix`, `date_creation`, `disponible`) VALUES
(1, 'Steak Frites', 'Steak 200g avec frites maison', 18.00, '2026-04-07', 1),
(9, 'Steak Frites', 'Steak 200g avec frites', 18.00, '2026-04-07', 1),
(10, 'Poulet Rôti', 'Poulet fermier rôti', 17.00, '2026-04-07', 1);

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

DROP TABLE IF EXISTS `produits`;
CREATE TABLE IF NOT EXISTS `produits` (
  `id_produit` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `prix` decimal(10,2) NOT NULL,
  `id_category` int NOT NULL,
  PRIMARY KEY (`id_produit`),
  KEY `id_category` (`id_category`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `produits`
--

INSERT INTO `produits` (`id_produit`, `nom`, `prix`, `id_category`) VALUES
(12, 'COCA', 3.00, 12),
(13, '312e3', 99999999.99, 12),
(14, 'sdjcsjcwwcw', 1212.00, 9),
(16, 'pizza', 10.00, 10),
(17, 'pates', 7.00, 10),
(18, 'escalope a la milanaise', 15.00, 10),
(19, 'bruschetta ', 5.00, 9),
(20, 'salade Caprese', 7.00, 9),
(21, 'arancini', 6.00, 9);

-- --------------------------------------------------------

--
-- Structure de la table `produit_commande`
--

DROP TABLE IF EXISTS `produit_commande`;
CREATE TABLE IF NOT EXISTS `produit_commande` (
  `id_com` int NOT NULL,
  `id_produit` int NOT NULL,
  `quantite` int NOT NULL,
  KEY `id_com` (`id_com`),
  KEY `id_produit` (`id_produit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `produit_commande`
--

INSERT INTO `produit_commande` (`id_com`, `id_produit`, `quantite`) VALUES
(14, 13, 1),
(14, 14, 1),
(14, 16, 1),
(15, 16, 1);

-- --------------------------------------------------------

--
-- Structure de la table `produit_menus`
--

DROP TABLE IF EXISTS `produit_menus`;
CREATE TABLE IF NOT EXISTS `produit_menus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_menu` int NOT NULL,
  `id_produit` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_menu` (`id_menu`),
  KEY `id_produit` (`id_produit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `staff`
--

DROP TABLE IF EXISTS `staff`;
CREATE TABLE IF NOT EXISTS `staff` (
  `id_staff` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `prenom` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `role` enum('super-admin','admin','manager') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'admin',
  `mot_de_passe` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `date_creation` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_staff`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `staff`
--

INSERT INTO `staff` (`id_staff`, `nom`, `prenom`, `email`, `role`, `mot_de_passe`, `date_creation`) VALUES
(1, 'TATIOTSOP ZEBAZE', 'Miguel', 'migueltatiotsop@icloud.com', 'super-admin', '$2y$10$abc123def456GHI789jkl012mno345pq678rst90uvwx', '2026-02-19 08:43:49'),
(2, 'MALBLANC', 'Joackim', 'joackimmalblanc@gmail.com', 'admin', '$2y$10$JE1f4E5xnZsa5CBZ5LCso.nqH5OYyX6OyqruvCVBGuzC/B7b.H5Ey', '2026-02-19 09:47:47'),
(3, 'FRERE', 'Adam', 'adam.frere@gmail.com', 'admin', '$2y$10$GnbIUVw/TLKtLkHePDKow..gzasDYggugi/VTuUBjOMMwv8lz/8Ae', '2026-02-19 10:50:20'),
(5, 'abc', 'ab', 'ab@gmail.com', 'admin', '$2y$10$SzV2HaGByUY0ygrUMmNFvO2zRL.T78VGbOeLPaK/OsRU5rIpNnr.a', '2026-03-10 14:58:10'),
(8, 'le', 'pro', 'pro@gmail.com', 'manager', '$2y$10$T8VxACJEPcfHxEF9kXY6uOTMCdpqzymDkJ/.wxRQfBD3zbQpJJ5BK', '2026-03-12 09:38:31'),
(12, 'truc', 'te', 'truc@gmail.com', 'manager', '$2y$10$ZulvA8t6V4wMYZA4X0Wlb.2X.JgDIp6uHeegS3kGq0WVjJBkuQCvK', '2026-03-12 10:38:00');

-- --------------------------------------------------------

--
-- Structure de la table `staff_menus`
--

DROP TABLE IF EXISTS `staff_menus`;
CREATE TABLE IF NOT EXISTS `staff_menus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_staff` int NOT NULL,
  `id_menu` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_staff` (`id_staff`),
  KEY `id_menu` (`id_menu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`id_parent`) REFERENCES `categories` (`id_category`) ON DELETE SET NULL;

--
-- Contraintes pour la table `commandes`
--
ALTER TABLE `commandes`
  ADD CONSTRAINT `commandes_ibfk_1` FOREIGN KEY (`id_staff`) REFERENCES `staff` (`id_staff`);

--
-- Contraintes pour la table `commandes_menus`
--
ALTER TABLE `commandes_menus`
  ADD CONSTRAINT `commandes_menus_ibfk_1` FOREIGN KEY (`id_com`) REFERENCES `commandes` (`id_com`),
  ADD CONSTRAINT `commandes_menus_ibfk_2` FOREIGN KEY (`id_menu`) REFERENCES `menus` (`id_menu`);

--
-- Contraintes pour la table `produit_commande`
--
ALTER TABLE `produit_commande`
  ADD CONSTRAINT `produit_commande_ibfk_1` FOREIGN KEY (`id_com`) REFERENCES `commandes` (`id_com`),
  ADD CONSTRAINT `produit_commande_ibfk_2` FOREIGN KEY (`id_produit`) REFERENCES `produits` (`id_produit`);

--
-- Contraintes pour la table `produit_menus`
--
ALTER TABLE `produit_menus`
  ADD CONSTRAINT `produit_menus_ibfk_1` FOREIGN KEY (`id_menu`) REFERENCES `menus` (`id_menu`),
  ADD CONSTRAINT `produit_menus_ibfk_2` FOREIGN KEY (`id_produit`) REFERENCES `produits` (`id_produit`);

--
-- Contraintes pour la table `staff_menus`
--
ALTER TABLE `staff_menus`
  ADD CONSTRAINT `staff_menus_ibfk_1` FOREIGN KEY (`id_staff`) REFERENCES `staff` (`id_staff`),
  ADD CONSTRAINT `staff_menus_ibfk_2` FOREIGN KEY (`id_menu`) REFERENCES `menus` (`id_menu`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
