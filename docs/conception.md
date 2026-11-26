# Séance 2 : dossier de conception v1

## 1. Persona

**Aïcha Ouédraogo, 21 ans, étudiante en L3 Informatique à Ouagadougou.**
- **Contexte :** 6 cours par semestre, des TP en binôme, des projets à rendre sur GitHub et un petit job de soutien scolaire le week-end.
- **Appareil :** smartphone Android d'entrée de gamme (3 Go de RAM, écran 6 pouces), forfait data limité rechargé par Orange Money.
- **Difficultés :** elle note ses échéances dans WhatsApp et dans un cahier, oublie des dates annoncées à l'oral, et perd du temps quand la connexion coupe.
- **Objectif :** ne plus jamais rendre un devoir en retard et voir en un coup d'œil ce qui est urgent.

## 2. Job stories

1. **Quand** un enseignant annonce une date de rendu à la fin du cours, **je veux** l'enregistrer en moins de 15 secondes avec son titre et sa date, **pour** ne pas l'oublier en rentrant.
2. **Quand** j'ouvre l'application le matin sans connexion, **je veux** voir mes tâches du jour et celles en retard, **pour** décider quoi faire en priorité sans consommer de données.

## 3. Parcours « suivre mes échéances »

| Étape | Action | Friction | Opportunité |
|---|---|---|---|
| Planifier | Elle liste ses cours et devoirs du semestre | Dates éparpillées (WhatsApp, cahier, oral) | Ajout rapide de cours et de dates au même endroit |
| Consulter | Elle ouvre l'application pour voir quoi faire | Elle ne sait pas ce qui est urgent | Filtres « à faire / faites / en retard » |
| Ajouter | Elle saisit une tâche annoncée en cours | Les formulaires longs la découragent | Formulaire minimal (titre, cours, date) |
| Être rappelée | Elle attend un rappel avant l'échéance | Elle oublie si elle n'ouvre pas l'application | Notification la veille de l'échéance |
| Rendre | Elle dépose son travail et coche la tâche | Elle oublie de marquer comme fait | Bouton « Marquer comme fait » sur le détail |

## 4. Wireframes

Les cinq écrans : Connexion, Échéances, Détail, Nouvelle tâche, Cours / Profil. Les images sont dans le dossier `wireframes/`.

Trois variantes de l'écran Échéances :
- **A. Liste simple :** tâches triées par date, pastille de statut.
- **B. Liste groupée :** sections « En retard », « Aujourd'hui », « Cette semaine ».
- **C. Calendrier :** vue mensuelle, liste du jour en dessous.

**Variante choisie : B**, avec la grille du cours :
- **Besoin :** elle répond à la job story n°2 (voir ce qui est urgent).
- **Parcours :** elle réduit la friction de l'étape « Consulter ».
- **Accessibilité :** les sections sont nommées en texte, le statut ne repose pas que sur la couleur.
- **Faisabilité :** elle se construit avec une ListView et des filtres Riverpod ; le calendrier demanderait un package supplémentaire, lourd pour un petit appareil.

## 5. Design system v1

| Rôle | Couleur | Utilisation | Contraste |
|---|---|---|---|
| Primaire | `#1F4FD8` | Boutons, AppBar | blanc sur primaire : 6,63 |
| Fond | `#F7F8FC` | Arrière-plan | texte principal dessus : 16,18 |
| Texte principal | `#1B1B1F` | Titres, contenu | sur blanc : 17,17 |
| Texte secondaire | `#5A5F6E` | Légendes, dates | sur fond : 6,00 |
| Erreur / en retard | `#B3261E` | Tâches en retard | blanc dessus : 6,54 |
| Succès / fait | `#1B7F4B` | Tâches faites | blanc dessus : 5,02 |

Tous les contrastes dépassent le minimum de 4,5:1 pour le texte.

**Typographie :** Roboto (par défaut sur Android). Titre 22 sp gras, sous-titre 16 sp, corps 14 sp, légende 12 sp.

**Composants :**
- **Bouton principal :** fond primaire, texte blanc, hauteur 48 dp, coins arrondis de 12 dp.
- **Carte de tâche :** fond blanc, titre, cours, date, pastille de statut (couleur + texte).
- **Champ de saisie :** étiquette au-dessus, bordure grise, bordure primaire au focus, message d'erreur rouge si le titre est vide.

**Tailles de fenêtre :** téléphone d'environ 360 dp (cible principale) ; tablette à partir de 840 dp (liste et détail côte à côte).