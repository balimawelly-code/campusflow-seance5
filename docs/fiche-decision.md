# Séance 1 : écosystème mobile

## 1. Fiche comparative Android / iOS (application étudiante, Afrique francophone)

| Critère | Android | iOS | Ce qui change pour un public étudiant africain |
|---|---|---|---|
| Philosophie | Ouvert, très personnalisable | Fermé, contrôlé par Apple | L'ouverture d'Android favorise une grande diversité d'appareils, dont des modèles très abordables |
| Architecture | Noyau Linux, machine virtuelle ART | Noyau Darwin, code compilé | Android tourne sur du matériel modeste, fréquent en gamme d'entrée |
| Langage natif | Kotlin (Java) | Swift (Objective-C) | Les deux sont possibles ; Flutter permet de n'écrire le code qu'une fois |
| Cycle de vie | Activity, plus de cas à gérer | Plus simple | Sur appareils à faible mémoire, Android tue souvent les applications en arrière-plan : il faut sauvegarder l'état |
| Permissions | Demandées à l'exécution | Demandées à l'exécution, plus strictes | Demander le minimum (notifications) pour rassurer les utilisateurs |
| Stockage | Local, SQLite, préférences | Équivalent | Prévoir un mode hors ligne : la connexion est intermittente et chère |
| Distribution | Google Play, APK, stores alternatifs | App Store uniquement | Le partage d'APK par WhatsApp est courant, ce qui facilite la diffusion |
| Coût de publication | Frais uniques, faibles | Abonnement annuel plus élevé | Un étudiant ou une petite équipe publie plus facilement sur Android |
| Fragmentation | Forte (versions, tailles d'écran) | Faible | Tester sur plusieurs tailles d'écran et d'anciennes versions |
| Mises à jour | Dépendent du constructeur | Directes par Apple | Beaucoup d'utilisateurs restent sur d'anciennes versions : viser un minSdk bas |
| Contraintes de développement | Windows, Linux ou macOS | Mac obligatoire pour compiler | Peu d'étudiants ont un Mac : Android est plus accessible |
| Sécurité | Variable selon l'appareil | Homogène | Stocker le jeton dans le stockage sécurisé dans les deux cas |
| Poids des applications | Applications légères appréciées | Idem | Limiter la taille de l'application et la consommation de données |
| Répartition du marché | Très majoritaire en Afrique | Minoritaire | Voir le chiffre ci-dessous |

Chiffre de référence (août 2026, StatCounter Global Stats, gs.statcounter.com) : Android 81,39 % du marché mobile en Afrique, iOS 18,57 %, Windows 0 %.

## 2. Autopsie : Windows Phone

**Cause n°1 (la plus lourde) : l'écosystème d'applications.** Le « fossé d'applications » entre Windows Phone et iOS/Android a fait décliner la plateforme dès 2015 : les développeurs n'investissaient pas dans une plateforme à faible part de marché, ce qui éloignait encore les utilisateurs (cercle vicieux).

**Cause n°2 : le timing.** Microsoft est arrivé trop tard sur le marché des smartphones : quand Windows Phone s'est imposé, Android et iOS avaient déjà verrouillé les développeurs et les habitudes.

**Cause n°3 : la stratégie et le modèle de plateforme.** Le rachat de la division mobile de Nokia n'a pas redressé la situation et Microsoft a fini par passer 7,6 milliards de dollars en perte. Les changements de stratégie répétés (Windows Phone 7, 8, puis 10 Mobile) ont découragé les développeurs.

**Fin officielle :** Microsoft a mis fin au support de la plateforme le 10 décembre 2019.

### Sources
- Tech Advisor, « Windows Phone officially loses support from Microsoft », décembre 2019, techadvisor.com
- TechRadar, « End of Windows 10 Mobile is natural conclusion of Microsoft's shift in strategy », techradar.com
- CNBC, « Microsoft ending Windows 10 Mobile, says switch to iPhone or Android », 18 janvier 2019, cnbc.com
- StatCounter Global Stats, « Mobile Operating System Market Share Africa », gs.statcounter.com

(Date de consultation : novembre 2026.)

## 3. Décision pour CampusFlow

CampusFlow vise les étudiants d'Afrique francophone, un public équipé en grande majorité d'appareils Android, souvent d'entrée de gamme, avec une connexion mobile intermittente et coûteuse. Nous retenons donc une approche **cross-platform avec Flutter**, une base de code unique en Dart. Android est la plateforme prioritaire (plus de 80 % du marché africain selon StatCounter, août 2026) et iOS est couvert avec la même base de code, sans avoir besoin d'un Mac au départ. Le natif aurait doublé le travail pour une équipe étudiante, et l'échec de Windows Phone rappelle qu'une plateforme n'a de valeur que si les utilisateurs et l'écosystème sont au rendez-vous : nous allons là où se trouvent nos utilisateurs. Le projet prévoit une interface légère et une gestion hors ligne des tâches.