# 🍽️ Lido Serena - Système de Gestion Restauration

Système complet pour gérer les commandes dans un restaurant avec interface cuisine temps réel.

**Architecture:**
- **Frontend (Cuisine)**: Interface web responsive pour les cuisiniers (`CUISINE/index.html`)
- **Frontend (Commande)**: Interface client (`COMMANDE/`)
- **Administration**: Interfaces PHP de gestion (`ADMIN/`)
- **Backend API**: API FastAPI (`BACK-END API/api.py`) qui gère les données
- **Base de Données**: MySQL (`ADMIN/lido_serena.sql`)

## 📊 Structure du projet

```
lido_serena/
├── ADMIN/                          # 🛠️ Administration (PHP)
│   ├── lido_serena.sql            # Dump base de données
│   ├── update_bdd.sql             # Script de mise à jour BDD
│   ├── README.md                  # Documentation admin
│   ├── consignes.md               # Instructions
│   ├── .gitignore
│   ├── css/                       # inscription.css, style.css
│   ├── html/                      # Pages admin (administration.php, chart.php,
│   │                              #   menu.html, manage_user.php, inscription.php, ...)
│   ├── php/                       # Logique métier (CRUD produits, menus, staff, BDD)
│   ├── js/                        # main.js
│   └── image/                     # Logos / assets
│
├── BACK-END API/                   # 🔑 API FastAPI principale (utilisée par CUISINE/COMMANDE)
│   ├── api.py                     # Application FastAPI
│   ├── start.py                   # Démarreur Python
│   ├── run.bat                    # Script de lancement Windows
│   ├── requirements.txt           # Dépendances Python
│   └── conf.env                   # Configuration base de données
│
├── BACK/                           # ⚙️ Backend alternatif/legacy (FastAPI)
│   ├── main.py
│   ├── database.py
│   ├── models.py
│   └── requirements.txt
│
├── CUISINE/                        # 🍳 Interface Cuisine
│   ├── index.html                 # Interface HTML
│   ├── index.css                  # Styles
│   ├── index.js
│   └── main.js                    # Logique (fetch API)
│
├── COMMANDE/                       # 📱 Interface Client
│   ├── index.html
│   ├── index.css
│   └── commande.js                # Logique (fetch API, panier)
│
├── README.md                       # Ce fichier
└── lido_serena (3).sql             # Export BDD (racine)
```

## 🎯 Fonctionnalités

### 🍳 Interface Cuisine
- ✅ Affichage temps réel des commandes
- ✅ Détails complets de chaque commande (table, plats, quantités, prix)
- ✅ Marquer les commandes comme "prêtes"
- ✅ Rafraîchissement automatique (5 secondes)
- ✅ Interface responsive (desktop/tablette/mobile)
- ✅ Notifications visuelles
- ✅ Support plein écran pour tablettes
- ⌨️ Raccourcis clavier (F5 pour rafraîchir, Échap pour fermer les modals)

### 🔧 Backend API
- ✅ Architecture FastAPI moderne
- ✅ API RESTful pour toutes les opérations
- ✅ Connexion MySQL en temps réel
- ✅ CORS activé pour accès de tous les domaines
- ✅ Documentation automatique Swagger (/docs)
- ✅ Gestion des erreurs robuste

### 🛠️ Administration
- ✅ Interface PHP pour gérer les menus
- ✅ Système utilisateur/staff
- ✅ Gestion des produits et catégories

---

## 🚀 Démarrage rapide

### 1. Prérequis

```bash
# Windows
- Python 3.8+
- MySQL/MariaDB en cours d'exécution
- WAMP64 ou équivalent
```

### 2. Installation

```bash
# Aller dans le dossier backend
cd "BACK-END API"

# Installer les dépendances
pip install -r requirements.txt
```

**Packages installés:**
- `fastapi` - Framework web
- `uvicorn` - Serveur ASGI
- `mysql-connector-python` - Connexion MySQL
- `python-dotenv` - Gestion des variables d'environnement
- `pydantic` - Validation des données

### 3. Configuration BDD

**Importer la base de données:**
```bash
mysql -u root < ..\ADMIN\lido_serena.sql
```

**Ou via phpMyAdmin:**
- Aller sur http://localhost/phpmyadmin
- Importer `ADMIN/lido_serena.sql`

Vérifier les identifiants dans `BACK-END API/conf.env`:
```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=lido_serena
```

### 4. Démarrer l'API

**Option A - Script Windows:**
```bash
run.bat
```

**Option B - Script Python:**
```bash
python start.py
```

**Option C - Commande directe:**
```bash
uvicorn api:app --host 0.0.0.0 --port 8000 --reload
```

**L'API démarrera sur:** `http://localhost:8000`

### 5. Accéder aux interfaces

```
🍳 Cuisine:         http://localhost:8000/cuisine
📚 Documentation:   http://localhost:8000/docs
🔍 Test BDD:        http://localhost:8000/test/db
```

---

## 📱 Utilisation - Interface Cuisine

### Affichage des commandes

Chaque commande est affichée sous forme de carte contenant:

1. **En-tête (bleu)**
   - Numéro de commande
   - Numéro de table/À emporter
   - Statut (En cuisine / Prête)

2. **Corps (blanc)**
   - Heure de passation
   - Nombre de plats
   - Liste complète des plats avec nom 🍽️, quantité et prix unitaire

3. **Pied de page (gris)**
   - Prix total
   - Bouton "Marquer comme prête" (vert)

### Actions

**Marquer une commande comme prête:**
1. Cliquer sur le bouton vert "✅ Marquer comme prête"
2. Confirmer dans le modal de confirmation
3. La commande s'affichera en vert avec un badge "✅ Prête"

**Rafraîchir les commandes:**
- Cliquer sur "🔄 Rafraîchir les commandes"
- Ou appuyer sur **F5** / **Ctrl+R**
- Ou attendre le rafraîchissement automatique (5 secondes)

### Indicateurs

| Indicateur   | Signification           |
| ------------ | ----------------------- |
| 🟢 Connecté   | API disponible          |
| 🔴 Déconnecté | API non accessible      |
| ⏳ En cuisine | Commande en préparation |
| ✅ Prête      | Commande prête à servir |

Les données affichées proviennent **directement de la BDD MySQL**.

---

## 🗄️ Données en Base de Données

### Table `commandes`
- `id_com` - ID unique de la commande
- `id_staff` - Serveur qui a pris la commande
- `montant` - Prix total
- `statut_commande` - État (en attente, **en cuisine**, prête, livrée)
- `mode_paiement` - espèces ou carte
- `statut_paiement` - payé ou non payé
- `date_commande` - Timestamp

### Table `commandes_menus`
- Lie les commandes aux menus
- Enregistre la quantité de chaque plat

### Table `menus`
- `id_menu`, `nom`, `description`, `prix`, `date_creation`, `disponible`

### Ajouter des commandes de test

```sql
-- Ajouter une commande
INSERT INTO `commandes` (`id_com`, `id_staff`, `montant`, `statut_commande`, `mode_paiement`, `statut_paiement`, `date_commande`)
VALUES (10, 1, 18.00, 'en cuisine', 'carte', 'payé', NOW());

-- Lier un ou plusieurs menus à cette commande
INSERT INTO `commandes_menus` (`id_com`, `id_menu`, `quantite`)
VALUES (10, 1, 1);
```

⚠️ **Important:** La colonne `statut_commande` doit être **'en cuisine'** pour que la commande s'affiche!

---

## 🔌 API Endpoints

### Récupérer les commandes en cuisine

```
GET /commandes/cuisine
```
Récupère **toutes les commandes en cuisine** depuis la base de données MySQL.

**Réponse:**
```json
[
  {
    "id_com": 1,
    "numero_table": null,
    "plats": [
      {
        "id_produit": 1,
        "nom": "Steak Frites",
        "quantite": 1,
        "prix": 18.00
      }
    ],
    "statut_commande": "en cuisine",
    "date_commande": "2026-04-07T15:17:00",
    "prix_total": 18.00
  }
]
```

### Marquer comme prête

```
POST /commandes/{commande_id}/prete
```

**Exemple:**
```bash
curl -X POST http://localhost:8000/commandes/1/prete
```

### Update statut

```
PUT /commandes/{commande_id}/statut
Body: {"statut_commande": "prête"}
```

### Documentation complète

Disponible sur: **http://localhost:8000/docs** (interface interactive Swagger).

---

## ⚙️ Configuration avancée

### Port API

Modifier le port de démarrage:
```bash
uvicorn api:app --port 3000
```

Puis mettre à jour `CUISINE/main.js`:
```javascript
const API_BASE_URL = 'http://localhost:3000';
```

### Intervalle rafraîchissement

Dans `CUISINE/main.js`:
```javascript
const REFRESH_INTERVAL = 5000; // ms
```

### CORS (Accès depuis d'autres domaines)

L'API accepte actuellement les requêtes de tous les domaines (`allow_origins=["*"]`).

Pour restreindre, dans `api.py`:
```python
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:8000", "http://192.168.1.100"],
    ...
)
```

---

## ⚡ Optimisation

### Performance
- Les commandes se rafraîchissent toutes les 5 secondes
- Le rafraîchissement s'arrête si l'onglet est en arrière-plan
- Utilisation de la mise en cache côté client

### Pour les tablettes de cuisine
- Interface grande et facile à lire
- Boutons grands et tactiles
- Notifications visibles
- Support du mode plein écran

---

## 🐛 Dépannage

| Problème               | Solution                                       |
| ---------------------- | ---------------------------------------------- |
| "Erreur connexion BDD" | Vérifier MySQL + identifiants dans conf.env    |
| "API non accessible"   | Vérifier que le serveur est démarré :8000      |
| "Modules not found"    | `pip install -r requirements.txt`              |
| "Port déjà utilisé"    | Changer de port dans la commande uvicorn       |
| "CORS error"           | À priori pas de problème (all origins allowed) |
| Commandes non à jour   | Console navigateur (F12), vérifier `/test/db`  |

**Test de diagnostic:**
```bash
curl http://localhost:8000/test/db
```

---

## 🎮 Raccourcis clavier

| Touche | Action                   |
| ------ | ------------------------ |
| F5     | Rafraîchir les commandes |
| Ctrl+R | Rafraîchir les commandes |
| Échap  | Fermer les modals        |

---

## 🔐 Production

**Avant de go en production:**

- [ ] Mettre `allow_origins` à des domaines spécifiques
- [ ] Ajouter authentification JWT
- [ ] Utiliser HTTPS/SSL
- [ ] Ajouter un rate limiting
- [ ] Valider toutes les entrées utilisateur
- [ ] Configurer firewall/reverse proxy
- [ ] Ajouter logging et monitoring
- [ ] Backup/recovery plan
- [ ] Load testing

---

## 📚 Documentation détaillée

- **Admin**: [ADMIN/README.md](ADMIN/README.md) - Gestion administration
- **API**: Documentation interactive Swagger sur http://localhost:8000/docs

---

## 👥 Équipe

**Développement:** Lido Serena Team
**Dernière mise à jour:** 7 Avril 2026
**Version:** 1.0.0

---

## 📞 Support

Pour les problèmes:
1. Vérifier les logs du serveur FastAPI
2. Ouvrir la console du navigateur (F12)
3. Consulter la documentation FastAPI: https://fastapi.tiangolo.com
4. Tester avec `curl` ou Postman

---

## 📝 Changelog

### v1.0.0 (7 Avril 2026)
- ✅ Interface cuisine complète
- ✅ API FastAPI fonctionnelle
- ✅ Base de données MySQL
- ✅ Documentation complète
- ✅ Scripts de démarrage

---

**Bon courage! 🚀**
