<?php
require_once '../php/bdd.php';

$id = $_GET['id'];
echo $id;

$stmt = $pdo->prepare("SELECT * FROM produits WHERE id_produit = ?");
$stmt->execute([$id]);
$p = $stmt->fetch();
echo $p['nom'];
echo $p['prix'];
echo $p['id_category'];
if (!$p) { die("Produit introuvable."); }
?>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/style.css">
    <title>Modifier <?= htmlspecialchars($p['nom']) ?></title>
</head>
<body>
    <h2 style>Modifier le produit</h2>
    <form action="../php/modif_produit.php" method="POST">
        <input type="hidden" name="id_produit" value="<?= $p['id_produit'] ?>">

        <label>Nom :</label>
        <input type="text" name="nom" value="<?= htmlspecialchars($p['nom']) ?>" required>

        <label>Prix :</label>
        <input type="number" name="prix" step="0.01" value="<?= $p['prix'] ?>" required>

        <button type="submit">Mettre à jour</button>
        <a href="dashboard.php">Annuler</a>
    </form>
</body>
</html>