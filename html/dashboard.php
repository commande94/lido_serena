<?php
session_start();
require_once '../php/bdd.php';

$sql = "SELECT p.id_produit, p.nom, p.prix, c.nom AS categorie_nom 
        FROM produits p 
        LEFT JOIN categories c ON p.id_category = c.id_category 
        ORDER BY p.id_produit DESC";

$stmt = $pdo->query($sql);
$produits = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Lido Serena</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

    <div class="container">
        <h1>Gestion du Lido Serena</h1>

        <section class="form-container">
            <h2>Ajouter un produit</h2>
            <form action="../php/ajout_produit.php" method="POST">
                <input type="text" name="nom" placeholder="Nom du produit" required>
                <input type="number" name="prix" step="0.1" placeholder="Prix (€)" required>
                
                <button type="submit">Enregistrer</button>
            </form>
        </section>

        <hr>

        <section class="table-container">
            <h2>Liste des Produits</h2>
            <table border="1">
                <thead>
                    
                </thead>
                <tbody>
                    <?php if (count($produits) > 0): ?>
                        <?php foreach ($produits as $produit): ?>
                            <tr>
                                <td><?= htmlspecialchars($produit['id_produit']) ?></td>
                                <td><?= htmlspecialchars($produit['nom']) ?></td>
                                <td><?= number_format($produit['prix'], 2) ?> €</td>
                                <td><?= htmlspecialchars($produit['categorie_nom'] ?? 'Entrée') ?></td>
                                <td>
                                    <a href="../php/modif_produit.php?id=<?= $produit['id_produit'] ?>"> Modifier</a> | 
                                    <a href="../php/suppr_produit.php?id=<?= $produit['id_produit'] ?>" 
                                       onclick="return confirm('Supprimer ce produit ?')" 
                                       > Supprimer</a>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <tr>
                            <td colspan="5" style="text-align:center;">Aucun produit trouvé dans la base.</td>
                        </tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </section>
    </div>

</body>
</html>