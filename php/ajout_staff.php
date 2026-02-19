<?php
require_once 'bdd.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    $nom = htmlspecialchars($_POST['nom']);
    $prenom = $_POST['prenom'];
    $email = $_POST['email'];
    $password = $_POST['password'];

    try {
        $sql = "INSERT INTO staff (nom, prenom, email, mot_de_passe) VALUES (:nom, :prenom, :email, :password)";
        $stmt = $pdo->prepare($sql);
        
        $stmt->execute([
            ':nom' => $nom,
            ':prenom' => $prenom,
            ':email' => $email,
            ':password' => $password
        ]);

        header('Location: ../html/dashboard.php?insert=success');
        exit();

    } catch (PDOException $e) {
        die("Erreur lors de l'ajout : " . $e->getMessage());
    }
}
?>