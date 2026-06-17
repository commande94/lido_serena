<?php
require_once 'bdd.php';

if (isset($_GET['id'])) {
    $id = $_GET['id'];

    $pdo->prepare("DELETE FROM produits_commandes WHERE id_produit = ?")->execute([$id]);

    $stmt = $pdo->prepare("DELETE FROM produits WHERE id_produit = ?");
    $stmt->execute([$id]);

    header('Location: ../html/administration.php?delete=ok');
}
?>