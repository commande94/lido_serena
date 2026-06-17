<?php
require_once 'bdd.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nom = htmlspecialchars($_POST['nom']);
    $description = htmlspecialchars($_POST['description'] ?? '');
    $prix = $_POST['prix'];
    $disponible = isset($_POST['disponible']) ? 1 : 0;
    // date création par défaut aujourd'hui
    $date_creation = date('Y-m-d');

    try {
        $sql = "INSERT INTO menu (nom, description, prix, date_creation, disponible)
                VALUES (:nom, :description, :prix, :date_creation, :disponible)";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            ':nom' => $nom,
            ':description' => $description,
            ':prix' => $prix,
            ':date_creation' => $date_creation,
            ':disponible' => $disponible
        ]);

        $id_menu = $pdo->lastInsertId();

        // gestion des catégories composant le menu
        if (!empty($_POST['categories']) && is_array($_POST['categories'])) {
            $sql2 = "INSERT INTO menu_categorie (id_menu, id_category, quantite) VALUES (:id_menu, :id_category, :quantite)";
            $stmt2 = $pdo->prepare($sql2);
            foreach ($_POST['categories'] as $id_category) {
                $quantite = max(1, intval($_POST['quantite'][$id_category] ?? 1));
                $stmt2->execute([
                    ':id_menu' => $id_menu,
                    ':id_category' => $id_category,
                    ':quantite' => $quantite
                ]);
            }
        }

        header('Location: ../html/administration.php?insert=menu_success');
        exit();
    } catch (PDOException $e) {
        die("Erreur lors de l'ajout du menu : " . $e->getMessage());
    }
}
?>
