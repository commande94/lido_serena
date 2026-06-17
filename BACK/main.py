from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List
from mysql.connector import Error
from database import get_connection

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

<<<<<<< HEAD
=======
def get_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="lido_serena"
    )

>>>>>>> dev-back-miguel
class ProduitCommande(BaseModel):
    id_produit: int
    quantite: int

class MenuCommande(BaseModel):
    id_menu: int
    quantite: int

class Commande(BaseModel):
    produits: List[ProduitCommande]
    menus: List[MenuCommande] = []
    montant: float
    mode_paiement: str
    statut_commande: str = "en attente"
    statut_paiement: str = "non payé"

<<<<<<< HEAD

@app.get("/produits")
def get_produits():
    db = get_connection()
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute("""
            SELECT p.id_produit, p.nom, p.prix, c.nom AS nom_categorie
            FROM produits p
            JOIN categories c ON p.id_category = c.id_category
        """)
        return cursor.fetchall()
    except Error as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()
        db.close()


@app.post("/commandes")
def ajouter_commande(data: Commande):
    db = get_connection()
    cursor = db.cursor()
    try:
        cursor.execute("""
            INSERT INTO commandes (id_staff, montant, mode_paiement, statut_commande, statut_paiement)
            VALUES (%s, %s, %s, %s, %s)
        """, (1, data.montant, data.mode_paiement, data.statut_commande, data.statut_paiement))
        db.commit()
        id_com = cursor.lastrowid

        for p in data.produits:
            cursor.execute("""
                INSERT INTO produit_commande (id_com, id_produit, quantite)
                VALUES (%s, %s, %s)
            """, (id_com, p.id_produit, p.quantite))
        db.commit()

        return {"message": "Commande ajoutée avec succès", "id_com": id_com}
    except Error as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()
        db.close()


@app.get("/commandes")
def get_commandes():
    db = get_connection()
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM commandes ORDER BY id_com DESC")
        return cursor.fetchall()
    except Error as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()
        db.close()


if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="127.0.0.1", port=9000, reload=True)
=======
@app.get("/produits")
def get_produits():
    db = get_db()
    cursor = db.cursor(dictionary=True)
    cursor.execute("""
        SELECT p.id_produit, p.nom, p.prix, c.nom AS nom_categorie
        FROM produits p
        JOIN categories c ON p.id_category = c.id_category
    """)
    data = cursor.fetchall()
    cursor.close()
    db.close()
    return data

@app.get("/menus")
def get_menus():
    print("➡️ /menus appelé")

    try:
        db = get_db()
        cursor = db.cursor(dictionary=True)

        print("🔎 Récupération des menus...")

        cursor.execute("""
            SELECT id_menu, nom, description, prix
            FROM menu
        """)

        menus = cursor.fetchall()
        print(f"✅ Menus trouvés: {len(menus)}")

        for menu in menus:
            print(f"➡️ Traitement menu ID: {menu['id_menu']}")

            try:
                cur2 = db.cursor(dictionary=True)

                cur2.execute("""
                    SELECT 
                        c.id_category,
                        c.nom,
                        mc.quantite
                    FROM menu_categorie mc
                    JOIN categories c ON mc.id_category = c.id_category
                    WHERE mc.id_menu = %s
                """, (menu["id_menu"],))

                data = cur2.fetchall()

                # 🔥 IMPORTANT : nom attendu par ton JS
                menu["categories"] = data

                print(f"   ✔ Catégories liées: {len(data)}")

                cur2.close()

            except Exception as e:
                print(f"❌ Erreur menu ID {menu['id_menu']} : {e}")
                menu["categories"] = []

        cursor.close()
        db.close()

        print("🏁 /menus terminé avec succès")
        return menus

    except Exception as e:
        print("💥 ERREUR GLOBALE /menus :", e)
        return {"error": str(e)}
@app.post("/commande")
def ajouter_commande(data: Commande):
    db = get_db()
    cursor = db.cursor()

    cursor.execute("""
        INSERT INTO commandes (montant, mode_paiement, statut_commande, statut_paiement)
        VALUES (%s, %s, %s, %s)
    """, (data.montant, data.mode_paiement, data.statut_commande, data.statut_paiement))

    id_com = cursor.lastrowid

    for p in data.produits:
        cursor.execute("""
            INSERT INTO produits_commandes (id_com, id_produit, quantite)
            VALUES (%s, %s, %s)
        """, (id_com, p.id_produit, p.quantite))

    for m in data.menus:
        cursor.execute("""
            INSERT INTO commande_menu (id_com, id_menu, quantite)
            VALUES (%s, %s, %s)
        """, (id_com, m.id_menu, m.quantite))

    db.commit()
    cursor.close()
    db.close()

    return {"message": "Commande ajoutée avec succès", "id_com": id_com}
>>>>>>> dev-back-miguel
