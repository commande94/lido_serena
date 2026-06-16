<?php
session_start();

require '../php/bdd.php'; 

$message = "";


if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $produitsSelectionnes = $_POST['produits'] ?? [];
    $quantites = $_POST['quantite'] ?? [];

    if (!empty($produitsSelectionnes)) {

        $id_staff = $_SESSION['id_staff'] ?? 1;
        $mode_paiement = $_POST['mode_paiement'] ?? 'espèces';

        // Calculer le montant total à partir des prix en base
        $montant = 0;
        $lignes = [];
        foreach ($produitsSelectionnes as $id_produit) {
            $qte = intval($quantites[$id_produit] ?? 0);
            if ($qte > 0) {
                $stmtPrix = $pdo->prepare("SELECT prix FROM produits WHERE id_produit = ?");
                $stmtPrix->execute([$id_produit]);
                $prix = $stmtPrix->fetchColumn();
                if ($prix !== false) {
                    $montant += $prix * $qte;
                    $lignes[] = [$id_produit, $qte];
                }
            }
        }

        if (!empty($lignes)) {
            $stmtCommande = $pdo->prepare("
                INSERT INTO commandes (id_staff, montant, mode_paiement)
                VALUES (?, ?, ?)
            ");
            $stmtCommande->execute([$id_staff, $montant, $mode_paiement]);
            $id_commande = $pdo->lastInsertId();

            foreach ($lignes as [$id_produit, $qte]) {
                $stmt = $pdo->prepare("
                    INSERT INTO produit_commande (id_com, id_produit, quantite)
                    VALUES (?, ?, ?)
                ");
                $stmt->execute([$id_commande, $id_produit, $qte]);
            }

            $message = "Commande enregistrée avec succès ! (ID : $id_commande)";
        } else {
            $message = "Aucune quantité valide saisie.";
        }
    } else {
        $message = "Aucun produit sélectionné.";
    }
}

$produits = $pdo->query("SELECT id_produit, nom, prix FROM produits ORDER BY nom")->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lido Serena - Commande</title>
    <link rel="stylesheet" href="../css/style.css">
</head>

<body>
    <section class="login-section">
        <h2>Créer une commande</h2>

        <?php if (!empty($message)) : ?>
            <p style="color:green; font-weight:bold;">
                <?= htmlspecialchars($message) ?>
            </p>
        <?php endif; ?>

        <form method="POST">
            <table border="1">
                <thead>
                    <tr>
                        <th>Sélection</th>
                        <th>Plat</th>
                        <th>Prix (€)</th>
                        <th>Quantité</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($produits as $produit) : ?>
                        <tr>
                            <td>
                                <input type="checkbox" name="produits[]" value="<?= $produit['id_produit'] ?>">
                            </td>
                            <td><?= htmlspecialchars($produit['nom']) ?></td>
                            <td><?= number_format($produit['prix'], 2) ?></td>
                            <td>
                                <input type="number" 
                                       name="quantite[<?= $produit['id_produit'] ?>]" 
                                       min="0" 
                                       placeholder="Entrer une quantité">
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>

            <br>
            <label for="mode_paiement">Mode de paiement :</label>
            <select name="mode_paiement" id="mode_paiement">
                <option value="espèces">Espèces</option>
                <option value="carte">Carte</option>
            </select>

            <br><br>
            <button type="submit">Valider la commande</button>
        </form>
    </section>
</body>

</html>