let panier = [];
let produitsDB = [];
let menusDB = [];
let panierMenus = [];

let menuSelection = null;
let choixMenu = {};

// ---------------- PRODUITS ----------------
async function fetchProduits() {
    try {
        const res = await fetch("http://127.0.0.1:9000/produits");
        produitsDB = await res.json();
        afficherProduits();
    } catch (err) {
        console.error("Produits error:", err);
    }
}

// ---------------- MENUS ----------------
async function fetchMenus() {
    try {
        const res = await fetch("http://127.0.0.1:9000/menus");
        menusDB = await res.json();

        console.log("MENUS RECUS :", menusDB);

        afficherMenus();
    } catch (err) {
        console.error("Menus error:", err);
    }
}

// ---------------- PRODUITS UI ----------------
function afficherProduits() {
    const container = document.getElementById("categories-container");
    container.innerHTML = "";

    const categories = [...new Set(produitsDB.map(p => p.nom_categorie))];

    categories.forEach(cat => {
        const catDiv = document.createElement("div");
        catDiv.className = "category";
        catDiv.innerHTML = `<h3>${cat}</h3>`;

        produitsDB
            .filter(p => p.nom_categorie === cat)
            .forEach(prod => {
                const div = document.createElement("div");
                div.className = "product-card";

                div.innerHTML = `
                    <span>${prod.nom} - €${prod.prix}</span>
                    <button class="btn-ajouter" onclick="ajouterPanier(${prod.id_produit})">
                        ➕ Ajouter
                    </button>
                `;

                catDiv.appendChild(div);
            });

        container.appendChild(catDiv);
    });
}
// ---------------- MENUS UI ----------------
function afficherMenus() {
    const container = document.getElementById("menus-container");
    container.innerHTML = "";

    menusDB.forEach(menu => {
        const div = document.createElement("div");
        div.className = "menu-card";

        const categoriesHTML = (menu.categories || [])
            .map(c => `<li>${c.quantite} ${c.nom}</li>`)
            .join("");

        div.innerHTML = `
            <h4>🍔 ${menu.nom}</h4>
            <div class="menu-price">€${menu.prix}</div>

            <ul class="menu-list">
                ${categoriesHTML}
            </ul>

            <button class="btn-composer" onclick="ouvrirMenu(${menu.id_menu})">
                🍽️ Composer
            </button>
        `;

        container.appendChild(div);
    });
}

// ---------------- MODAL MENU ----------------
function ouvrirMenu(id_menu) {
    menuSelection = menusDB.find(m => m.id_menu === id_menu);
    choixMenu = {};

    let html = `<h3>${menuSelection.nom}</h3>`;

    menuSelection.categories.forEach(cat => {

        const produits = produitsDB.filter(p => p.nom_categorie === cat.nom);

        html += `<h4>${cat.nom}</h4>`;

        html += produits.map(p => `
            <div>
                <input type="radio"
                    name="cat_${cat.id_category}"
                    value="${p.id_produit}"
                    onclick="choisirProduit('${cat.nom}', ${p.id_produit})">
                ${p.nom}
            </div>
        `).join("");
    });

    html += `
        <button onclick="ajouterMenuCompose()">Ajouter</button>
        <button onclick="fermerModal()">Fermer</button>
    `;

    let modal = document.getElementById("menu-modal");
    if (!modal) {
        modal = document.createElement("div");
        modal.id = "menu-modal";
        document.body.appendChild(modal);
    }

    modal.innerHTML = html;
    modal.style.display = "block";
}

// ---------------- MODAL CLOSE ----------------
function fermerModal() {
    const modal = document.getElementById("menu-modal");
    if (modal) modal.style.display = "none";
}

// ---------------- CHOIX MENU ----------------
function choisirProduit(categorie, id_produit) {
    choixMenu[categorie] = id_produit;
}

// ---------------- AJOUT MENU ----------------
function ajouterMenuCompose() {
    panierMenus.push({
        id_menu: menuSelection.id_menu,
        nom: menuSelection.nom,
        prix: menuSelection.prix,
        choix: choixMenu,
        quantite: 1
    });

    fermerModal();
    afficherPanier();
}

// ---------------- PANIER ----------------
function ajouterPanier(id) {
    const produit = produitsDB.find(p => p.id_produit === id);
    const exist = panier.find(p => p.id_produit === id);

    if (exist) exist.quantite++;
    else panier.push({ ...produit, quantite: 1 });

    afficherPanier();
}

function supprimerPanier(id) {
    panier = panier.filter(p => p.id_produit !== id);
    afficherPanier();
}

function supprimerMenu(id) {
    panierMenus = panierMenus.filter(m => m.id_menu !== id);
    afficherPanier();
}

// ---------------- AFFICHAGE PANIER ----------------
function afficherPanier() {
    const container = document.getElementById("panier-list");
    container.innerHTML = "";

    let total = 0;

    panier.forEach(item => {
        total += item.prix * item.quantite;

        container.innerHTML += `
            <div>
                ${item.nom} x${item.quantite}
                <button onclick="supprimerPanier(${item.id_produit})">X</button>
            </div>
        `;
    });

    panierMenus.forEach(menu => {
        total += menu.prix * menu.quantite;

        container.innerHTML += `
            <div>
                🍔 ${menu.nom}
                <button onclick="supprimerMenu(${menu.id_menu})">X</button>
            </div>
        `;
    });

    document.getElementById("panier-total").innerText = total.toFixed(2);
}

// ---------------- INIT ----------------
fetchProduits();
fetchMenus();
afficherPanier();