-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 17 juin 2026 à 10:08
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
  `nom` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`id_category`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id_category`, `nom`, `description`) VALUES
(1, 'Entrées', 'Une sélection raffinée pour bien commencer votre repas.'),
(2, 'Plats', 'Nos spécialités de la mer et du terroir.'),
(3, 'Desserts', 'Douceurs sucrées et créations artisanales.'),
(4, 'Boissons', 'Vins, cocktails et rafraîchissements.'),
(5, 'Pizza', 'Une disposition de pizza de saveur differentes'),
(6, 'Pates', 'Nos spécialités de la mer et du terroir.'),
(7, 'Burgers', 'Tous les burgers et hamburgers'),
(8, 'Wraps', 'Wraps chauds et froids'),
(9, 'Paninis', 'Paninis et sandwichs grillés'),
(10, 'Salades', 'Salades composées et salades repas'),
(11, 'Accompagnements', 'Frites, potatoes, riz et autres accompagnements'),
(12, 'Sauces', 'Sauces et condiments'),
(13, 'Glaces', 'Glaces, coupes glacées et desserts glacés');

-- --------------------------------------------------------

--
-- Structure de la table `commandes`
--

DROP TABLE IF EXISTS `commandes`;
CREATE TABLE IF NOT EXISTS `commandes` (
  `id_com` int NOT NULL AUTO_INCREMENT,
  `id_staff` int DEFAULT NULL,
  `montant` decimal(10,2) NOT NULL,
  `statut_commande` enum('en attente','en cuisine','prête','livrée') DEFAULT 'en attente',
  `mode_paiement` enum('espèces','carte') NOT NULL,
  `statut_paiement` enum('non payé','payé') DEFAULT 'non payé',
  `date_commande` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_com`),
  KEY `id_staff` (`id_staff`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `commandes`
--

INSERT INTO `commandes` (`id_com`, `id_staff`, `montant`, `statut_commande`, `mode_paiement`, `statut_paiement`, `date_commande`) VALUES
(6, 3, 0.00, 'en attente', 'espèces', 'non payé', '2026-04-03 15:18:21'),
(7, 3, 0.00, 'en attente', 'espèces', 'non payé', '2026-04-03 15:18:21'),
(8, 3, 0.00, 'en attente', 'espèces', 'non payé', '2026-04-03 15:18:21'),
(9, 3, 0.00, 'en attente', 'espèces', 'non payé', '2026-04-03 15:18:21'),
(10, 3, 0.00, 'en attente', 'espèces', 'non payé', '2026-04-03 15:18:21'),
(11, 1, 0.00, 'en attente', 'espèces', 'non payé', '2026-04-03 15:18:21'),
(12, 1, 0.00, 'en attente', 'espèces', 'non payé', '2026-04-03 15:18:21'),
(13, 1, 0.00, 'en attente', 'espèces', 'non payé', '2026-04-03 15:18:21'),
(14, 1, 0.00, 'en attente', 'espèces', 'non payé', '2026-04-03 15:18:21'),
(15, 1, 0.00, 'en attente', 'espèces', 'non payé', '2026-04-03 15:18:21'),
(16, 1, 0.00, 'en attente', 'espèces', 'non payé', '2026-04-03 15:18:21'),
(17, 1, 0.00, 'en attente', 'espèces', 'non payé', '2026-04-03 15:18:21'),
(18, 1, 0.00, 'en attente', 'espèces', 'non payé', '2026-04-03 15:18:21'),
(19, 1, 0.00, 'en attente', 'espèces', 'non payé', '2026-04-03 15:18:21'),
(20, 1, 0.00, 'en attente', 'espèces', 'non payé', '2026-04-03 15:18:21'),
(21, 1, 0.00, 'en attente', 'espèces', 'non payé', '2026-04-03 15:18:21'),
(22, 1, 0.00, 'en attente', 'espèces', 'non payé', '2026-04-03 15:18:21'),
(25, NULL, 5.50, '', 'espèces', '', '2026-04-07 14:31:22'),
(26, NULL, 29.00, '', 'espèces', '', '2026-04-07 14:31:30'),
(27, NULL, 41.50, '', 'espèces', '', '2026-04-07 14:34:07'),
(28, NULL, 8.50, '', 'espèces', '', '2026-04-07 14:34:23'),
(29, NULL, 8.50, '', 'espèces', '', '2026-04-07 14:34:24'),
(30, NULL, 8.50, '', 'espèces', '', '2026-04-07 14:34:25'),
(31, NULL, 8.50, '', 'espèces', '', '2026-04-07 14:34:27'),
(32, NULL, 5.50, '', 'espèces', '', '2026-04-07 14:36:45'),
(33, NULL, 48.50, '', 'espèces', '', '2026-04-07 14:37:14'),
(34, NULL, 13.00, '', 'espèces', '', '2026-04-07 14:37:44'),
(35, NULL, 2.50, '', 'espèces', '', '2026-04-07 14:38:09'),
(36, NULL, 12.00, '', 'espèces', '', '2026-04-07 14:38:16'),
(37, NULL, 22.00, '', 'espèces', '', '2026-04-07 14:42:33'),
(38, NULL, 5.50, '', 'espèces', '', '2026-04-07 14:48:41'),
(39, NULL, 27.00, '', 'espèces', '', '2026-04-07 15:01:10'),
(40, NULL, 15.00, '', 'espèces', '', '2026-04-16 15:12:22'),
(41, NULL, 49.30, '', 'espèces', '', '2026-04-16 16:51:07'),
(42, NULL, 25.40, '', 'espèces', '', '2026-04-16 16:51:14'),
(43, NULL, 26.90, '', 'espèces', '', '2026-04-16 16:52:53');

-- --------------------------------------------------------

--
-- Structure de la table `commandes_menu`
--

DROP TABLE IF EXISTS `commandes_menu`;
CREATE TABLE IF NOT EXISTS `commandes_menu` (
  `id_com` int NOT NULL,
  `id_menu` int NOT NULL,
  `quantite` int NOT NULL DEFAULT '1',
  KEY `id_com` (`id_com`),
  KEY `id_menu` (`id_menu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `menu`
--

DROP TABLE IF EXISTS `menu`;
CREATE TABLE IF NOT EXISTS `menu` (
  `id_menu` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `description` text,
  `prix` decimal(10,2) NOT NULL,
  `date_creation` date DEFAULT NULL,
  `disponible` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_menu`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `menu`
--

INSERT INTO `menu` (`id_menu`, `nom`, `description`, `prix`, `date_creation`, `disponible`) VALUES
(1, 'Menu Burger Classic', 'Burger + accompagnement + boisson', 12.90, NULL, 1),
(2, 'Menu Burger Gourmand', 'Burger + accompagnement + dessert + boisson', 15.90, NULL, 1),
(3, 'Menu Wrap', 'Wrap + accompagnement + boisson', 11.90, NULL, 1),
(4, 'Menu Wrap Premium', 'Wrap + dessert + boisson', 13.90, NULL, 1),
(5, 'Menu Panini', 'Panini + boisson', 10.90, NULL, 1),
(6, 'Menu Panini Maxi', 'Panini + accompagnement + boisson', 12.90, NULL, 1),
(7, 'Menu Pizza Solo', 'Pizza + boisson', 11.90, NULL, 1),
(8, 'Menu Pizza Dolce', 'Pizza + dessert + boisson', 14.90, NULL, 1),
(9, 'Menu Pasta Solo', 'Pâtes + boisson', 12.90, NULL, 1),
(10, 'Menu Pasta Gourmande', 'Pâtes + dessert + boisson', 15.90, NULL, 1),
(11, 'Menu Italien', 'Pizza ou pâtes + dessert + boisson', 16.90, NULL, 1),
(12, 'Menu Déjeuner', 'Entrée + plat + boisson', 13.90, NULL, 1),
(13, 'Menu Complet', 'Entrée + plat + dessert + boisson', 17.90, NULL, 1),
(14, 'Menu Prestige', 'Menu complet + extras + sauce', 21.90, NULL, 1),
(15, 'Menu Salade', 'Salade + boisson', 11.90, NULL, 1),
(16, 'Menu Salade Gourmande', 'Salade + dessert + boisson', 13.90, NULL, 1),
(17, 'Menu Enfant', 'Burger ou panini + glace + boisson', 8.90, NULL, 1),
(18, 'Menu Kids Plus', 'Menu enfant amélioré', 10.90, NULL, 1),
(19, 'Menu Douceur', 'Dessert + boisson', 7.90, NULL, 1),
(20, 'Menu Glacé', 'Glace + boisson', 6.90, NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `menu_categorie`
--

DROP TABLE IF EXISTS `menu_categorie`;
CREATE TABLE IF NOT EXISTS `menu_categorie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_menu` int NOT NULL,
  `id_category` int NOT NULL,
  `quantite` int DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `id_menu` (`id_menu`),
  KEY `id_category` (`id_category`)
) ENGINE=MyISAM AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `menu_categorie`
--

INSERT INTO `menu_categorie` (`id`, `id_menu`, `id_category`, `quantite`) VALUES
(1, 1, 7, 1),
(2, 1, 11, 1),
(3, 1, 4, 1),
(4, 2, 7, 1),
(5, 2, 11, 1),
(6, 2, 3, 1),
(7, 2, 4, 1),
(8, 3, 8, 1),
(9, 3, 11, 1),
(10, 3, 4, 1),
(11, 4, 8, 1),
(12, 4, 11, 1),
(13, 4, 3, 1),
(14, 4, 4, 1),
(15, 5, 9, 1),
(16, 5, 4, 1),
(17, 6, 9, 1),
(18, 6, 11, 1),
(19, 6, 4, 1),
(20, 7, 5, 1),
(21, 7, 4, 1),
(22, 8, 5, 1),
(23, 8, 3, 1),
(24, 8, 4, 1),
(25, 9, 6, 1),
(26, 9, 4, 1),
(27, 10, 6, 1),
(28, 10, 3, 1),
(29, 10, 4, 1),
(30, 10, 6, 1),
(31, 10, 3, 1),
(32, 10, 4, 1),
(33, 11, 5, 1),
(34, 11, 6, 1),
(35, 11, 3, 1),
(36, 11, 4, 1),
(37, 12, 1, 1),
(38, 12, 2, 1),
(39, 12, 4, 1),
(40, 13, 1, 1),
(41, 13, 2, 1),
(42, 13, 3, 1),
(43, 13, 4, 1),
(44, 14, 1, 1),
(45, 14, 2, 1),
(46, 14, 3, 1),
(47, 14, 4, 1),
(48, 14, 12, 1),
(49, 15, 10, 1),
(50, 15, 4, 1),
(51, 16, 10, 1),
(52, 16, 3, 1),
(53, 16, 4, 1),
(54, 17, 7, 1),
(55, 17, 13, 1),
(56, 17, 4, 1),
(57, 18, 7, 1),
(58, 18, 11, 1),
(59, 18, 13, 1),
(60, 18, 4, 1),
(61, 19, 3, 1),
(62, 19, 4, 1),
(63, 20, 13, 1),
(64, 20, 4, 1);

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

DROP TABLE IF EXISTS `produits`;
CREATE TABLE IF NOT EXISTS `produits` (
  `id_produit` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(150) NOT NULL,
  `prix` decimal(10,2) NOT NULL,
  `id_category` int DEFAULT NULL,
  PRIMARY KEY (`id_produit`),
  KEY `id_category` (`id_category`)
) ENGINE=InnoDB AUTO_INCREMENT=391 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `produits`
--

INSERT INTO `produits` (`id_produit`, `nom`, `prix`, `id_category`) VALUES
(300, 'Salade verte', 4.00, 1),
(301, 'Soupe maison', 5.00, 1),
(302, 'Bruschetta', 6.50, 1),
(303, 'Œufs mayonnaise', 4.50, 1),
(304, 'Carpaccio de bœuf', 9.00, 1),
(305, 'Melon jambon', 7.00, 1),
(306, 'Feuilleté fromage', 5.50, 1),
(307, 'Poulet rôti', 12.00, 2),
(308, 'Steak frites', 14.00, 2),
(309, 'Poisson grillé', 13.50, 2),
(310, 'Escalope milanaise', 13.00, 2),
(311, 'Bœuf bourguignon', 15.00, 2),
(312, 'Lasagnes maison', 11.50, 2),
(313, 'Omelette complète', 9.00, 2),
(314, 'Tiramisu', 5.50, 3),
(315, 'Mousse au chocolat', 4.50, 3),
(316, 'Crème brûlée', 5.00, 3),
(317, 'Tarte aux pommes', 4.50, 3),
(318, 'Fondant chocolat', 6.00, 3),
(319, 'Cheesecake', 5.50, 3),
(320, 'Salade de fruits', 4.00, 3),
(321, 'Coca Cola', 3.00, 4),
(322, 'Fanta', 3.00, 4),
(323, 'Sprite', 3.00, 4),
(324, 'Jus d’orange', 3.50, 4),
(325, 'Eau minérale', 2.00, 4),
(326, 'Thé glacé', 3.50, 4),
(327, 'Café', 2.50, 4),
(328, 'Pizza Margherita', 10.00, 5),
(329, 'Pizza Pepperoni', 12.00, 5),
(330, 'Pizza 4 fromages', 13.00, 5),
(331, 'Pizza végétarienne', 11.50, 5),
(332, 'Pizza BBQ', 13.50, 5),
(333, 'Pizza poulet curry', 13.00, 5),
(334, 'Pizza fruits de mer', 14.00, 5),
(335, 'Pâtes Carbonara', 11.00, 6),
(336, 'Pâtes Bolognaise', 10.50, 6),
(337, 'Pâtes Pesto', 10.00, 6),
(338, 'Lasagnes', 12.00, 6),
(339, 'Tagliatelles saumon', 13.00, 6),
(340, 'Penne arrabiata', 10.50, 6),
(341, 'Raviolis ricotta', 11.50, 6),
(342, 'Classic Burger', 8.50, 7),
(343, 'Cheese Burger', 9.00, 7),
(344, 'Bacon Burger', 10.50, 7),
(345, 'Chicken Burger', 9.50, 7),
(346, 'Double Burger', 12.00, 7),
(347, 'Veggie Burger', 9.00, 7),
(348, 'BBQ Burger', 11.50, 7),
(349, 'Wrap poulet', 7.50, 8),
(350, 'Wrap kebab', 8.00, 8),
(351, 'Wrap saumon', 9.00, 8),
(352, 'Wrap veggie', 7.50, 8),
(353, 'Wrap thon', 8.50, 8),
(354, 'Wrap falafel', 7.00, 8),
(355, 'Wrap crispy chicken', 9.50, 8),
(356, 'Panini jambon fromage', 6.50, 9),
(357, 'Panini poulet curry', 7.50, 9),
(358, 'Panini thon', 7.00, 9),
(359, 'Panini bolognaise', 8.00, 9),
(360, 'Panini 3 fromages', 7.50, 9),
(361, 'Panini saumon', 8.50, 9),
(362, 'Panini veggie', 7.00, 9),
(363, 'Salade César', 9.50, 10),
(364, 'Salade Niçoise', 10.00, 10),
(365, 'Salade italienne', 10.50, 10),
(366, 'Salade chèvre chaud', 11.00, 10),
(367, 'Salade poulet', 10.50, 10),
(368, 'Salade quinoa', 9.50, 10),
(369, 'Salade méditerranéenne', 10.00, 10),
(370, 'Frites', 3.00, 11),
(371, 'Potatoes', 3.50, 11),
(372, 'Riz pilaf', 3.50, 11),
(373, 'Légumes grillés', 4.50, 11),
(374, 'Onion rings', 4.00, 11),
(375, 'Mozzarella sticks', 5.00, 11),
(376, 'Nuggets', 5.50, 11),
(377, 'Mayonnaise', 0.50, 12),
(378, 'Ketchup', 0.50, 12),
(379, 'Barbecue', 0.70, 12),
(380, 'Samouraï', 0.70, 12),
(381, 'Andalouse', 0.70, 12),
(382, 'Curry', 0.70, 12),
(383, 'Algérienne', 0.70, 12),
(384, 'Glace vanille', 3.50, 13),
(385, 'Glace chocolat', 3.50, 13),
(386, 'Glace fraise', 3.50, 13),
(387, 'Glace pistache', 4.00, 13),
(388, 'Dame blanche', 6.50, 13),
(389, 'Banana split', 7.50, 13),
(390, 'Coupe chocolat', 6.50, 13);

-- --------------------------------------------------------

--
-- Structure de la table `produits_commandes`
--

DROP TABLE IF EXISTS `produits_commandes`;
CREATE TABLE IF NOT EXISTS `produits_commandes` (
  `id_com` int NOT NULL,
  `id_produit` int NOT NULL,
  `quantite` int NOT NULL,
  KEY `id_com` (`id_com`),
  KEY `id_produit` (`id_produit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `staff`
--

DROP TABLE IF EXISTS `staff`;
CREATE TABLE IF NOT EXISTS `staff` (
  `id_staff` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `role` enum('super-admin','admin') NOT NULL DEFAULT 'admin',
  `mot_de_passe` varchar(255) NOT NULL,
  `date_creation` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_staff`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `staff`
--

INSERT INTO `staff` (`id_staff`, `nom`, `prenom`, `email`, `role`, `mot_de_passe`, `date_creation`) VALUES
(1, 'TATIOTSOP ZEBAZE', 'Miguel', 'migueltatiotsop@icloud.com', 'super-admin', '$2y$10$abc123def456GHI789jkl012mno345pq678rst90uvwx', '2026-02-19 09:43:49'),
(2, 'MALBLANC', 'Joackim', 'joackimmalblanc@gmail.com', 'admin', '$2y$10$JE1f4E5xnZsa5CBZ5LCso.nqH5OYyX6OyqruvCVBGuzC/B7b.H5Ey', '2026-02-19 10:47:47'),
(3, 'FRERE', 'Adam', 'adam.frere@gmail.com', 'admin', '$2y$10$GnbIUVw/TLKtLkHePDKow..gzasDYggugi/VTuUBjOMMwv8lz/8Ae', '2026-02-19 11:50:20');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commandes`
--
ALTER TABLE `commandes`
  ADD CONSTRAINT `commandes_ibfk_1` FOREIGN KEY (`id_staff`) REFERENCES `staff` (`id_staff`);

--
-- Contraintes pour la table `commandes_menu`
--
ALTER TABLE `commandes_menu`
  ADD CONSTRAINT `commandes_menu_ibfk_1` FOREIGN KEY (`id_com`) REFERENCES `commandes` (`id_com`),
  ADD CONSTRAINT `commandes_menu_ibfk_2` FOREIGN KEY (`id_menu`) REFERENCES `menu` (`id_menu`);

--
-- Contraintes pour la table `produits`
--
ALTER TABLE `produits`
  ADD CONSTRAINT `produits_ibfk_1` FOREIGN KEY (`id_category`) REFERENCES `categories` (`id_category`) ON DELETE SET NULL;

--
-- Contraintes pour la table `produits_commandes`
--
ALTER TABLE `produits_commandes`
  ADD CONSTRAINT `produits_commandes_ibfk_1` FOREIGN KEY (`id_com`) REFERENCES `commandes` (`id_com`),
  ADD CONSTRAINT `produits_commandes_ibfk_2` FOREIGN KEY (`id_produit`) REFERENCES `produits` (`id_produit`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
