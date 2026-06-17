<?php
require_once 'bdd.php';

if (isset($_GET['id'])) {
    $id = $_GET['id'];

    // supprimer les associations avant de supprimer le menu
    $pdo->prepare("DELETE FROM menu_categorie WHERE id_menu = ?")->execute([$id]);
    $pdo->prepare("DELETE FROM commandes_menu WHERE id_menu = ?")->execute([$id]);

    $stmt = $pdo->prepare("DELETE FROM menu WHERE id_menu = ?");
    $stmt->execute([$id]);

    header('Location: ../html/administration.php?delete=menu_ok');
}
?>
