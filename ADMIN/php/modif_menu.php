<?php
require_once 'bdd.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id_menu = $_POST['id_menu'];
    $nom = htmlspecialchars($_POST['nom']);
    $description = htmlspecialchars($_POST['description'] ?? '');
    $prix = $_POST['prix'];
    $disponible = isset($_POST['disponible']) ? 1 : 0;

    try {
        $sql = "UPDATE menu SET nom = :nom, description = :description, prix = :prix, disponible = :disponible WHERE id_menu = :id_menu";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            ':nom' => $nom,
            ':description' => $description,
            ':prix' => $prix,
            ':disponible' => $disponible,
            ':id_menu' => $id_menu
        ]);

        $pdo->prepare("DELETE FROM menu_categorie WHERE id_menu = ?")->execute([$id_menu]);
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

        header('Location: ../html/administration.php?update=menu_success');
        exit();
    } catch (PDOException $e) {
        die("Erreur lors de la modification du menu : " . $e->getMessage());
    }
} else {
    $id_menu = $_GET['id'] ?? null;
    if (!$id_menu) {
        die("ID menu manquant");
    }

    $sql = "SELECT * FROM menu WHERE id_menu = :id_menu";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([':id_menu' => $id_menu]);
    $menu = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$menu) {
        die("Menu non trouvé");
    }

    // récupérer les catégories disponibles et celles déjà associées (avec quantité)
    $allCategories = $pdo->query("SELECT id_category, nom FROM categories ORDER BY nom")->fetchAll(PDO::FETCH_ASSOC);
    $selected = $pdo->prepare("SELECT id_category, quantite FROM menu_categorie WHERE id_menu = ?");
    $selected->execute([$id_menu]);
    $selectedRows = $selected->fetchAll(PDO::FETCH_KEY_PAIR);
    $selectedIds = array_keys($selectedRows);
}
?>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <title>Modifier un menu - Lido Serena</title>
    <link rel="stylesheet" href="../css/style.css">
</head>

<body>
    <div class="container">
        <h1>Modifier un menu</h1>
        <section class="form-container">
            <form action="../php/modif_menu.php" method="POST">
                <input type="hidden" name="id_menu" value="<?= htmlspecialchars($menu['id_menu']) ?>">
                <input type="text" name="nom" placeholder="Nom du menu" value="<?= htmlspecialchars($menu['nom']) ?>"
                    required>
                <textarea name="description" placeholder="Description"
                    rows="3"><?= htmlspecialchars($menu['description']) ?></textarea>
                <input type="number" name="prix" step="0.01" placeholder="Prix (€)"
                    value="<?= htmlspecialchars($menu['prix']) ?>" required>
                <label>
                    Disponible ?
                    <input type="checkbox" name="disponible" value="1" <?= $menu['disponible'] ? 'checked' : '' ?>>
                </label>
                <fieldset>
                    <legend>Catégories du menu (cochez celles présentes et indiquez la quantité)</legend>
                    <?php
                    foreach ($allCategories as $categorie):
                        $catId = $categorie['id_category'];
                        $checked = in_array($catId, $selectedIds) ? 'checked' : '';
                        $qte = $selectedRows[$catId] ?? 1;
                        ?>
                        <label>
                            <input type="checkbox" name="categories[]" value="<?= $catId ?>" <?= $checked ?>>
                            <?= htmlspecialchars($categorie['nom']) ?>
                        </label>
                        Quantité :
                        <input type="number" name="quantite[<?= $catId ?>]" value="<?= htmlspecialchars($qte) ?>" min="1" style="width:60px;">
                        <br>
                    <?php endforeach; ?>
                </fieldset>
                <button type="submit">Enregistrer</button>
            </form>
        </section>
    </div>
</body>

</html>