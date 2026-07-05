# GastroMap iOS

Projet réalisé en Licence, dans le cadre d'un projet mobile iOS.

GastroMap est une application iOS de recherche et consultation de restaurants. Le projet met en avant une application mobile complète avec liste de restaurants, fiches détaillées, horaires, menus, commentaires, cartes et calcul de distance.

## Compétences mises en avant

- Développement iOS en Swift avec UIKit et Storyboards.
- Utilisation de MapKit et CoreLocation pour l'affichage cartographique et la géolocalisation.
- Modélisation locale avec CoreData.
- Navigation mobile avec plusieurs écrans, contrôleurs et vues de détail.
- Structuration d'une application orientée domaine métier.

## Fonctionnalités

- Liste des restaurants.
- Affichage des informations détaillées d'un restaurant.
- Consultation des menus, horaires et commentaires.
- Carte des restaurants et affichage d'un restaurant sélectionné.
- Calcul de distance entre l'utilisateur et un restaurant.
- Persistance locale des données avec CoreData.

## Technologies

Swift, UIKit, Storyboards, CoreData, MapKit, CoreLocation, Xcode.

## Modèle de données

L'application utilise CoreData avec quatre entités principales : `Restaurants`, `Menus`, `Horaire` et `Commentaires`.

La structure est détaillée dans [`docs/database-structure.md`](docs/database-structure.md). Ce dossier contient aussi un schéma SQL simplifié issu d'un projet académique de base de données restaurant réalisé en Licence, uniquement comme référence de modélisation.

## Lancement

Ouvrir `GastroMap.xcodeproj` avec Xcode, puis lancer l'application sur simulateur iOS.

## Notes

Les fichiers personnels Xcode, caches et dossiers de build ne sont pas versionnés. Le dépôt est destiné à présenter le projet dans un portfolio GitHub.
