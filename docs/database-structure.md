# Structure des données

GastroMap utilise CoreData pour stocker localement les informations de l'application iOS. Le modèle est volontairement centré sur l'usage mobile : afficher des restaurants, leurs menus, leurs horaires et leurs commentaires.

## Modèle CoreData utilisé par l'application

### `Restaurants`

Représente un restaurant affiché dans l'application.

| Attribut | Type | Rôle |
| --- | --- | --- |
| `nom` | String | Nom du restaurant |
| `adresse` | String | Adresse affichée dans la fiche |
| `latitude` | Double | Position GPS pour MapKit |
| `longitude` | Double | Position GPS pour MapKit |
| `image` | String | Nom de l'image associée |

Relations :

- `sesMenus` : un restaurant possède plusieurs menus.
- `sesHoraires` : un restaurant possède plusieurs horaires.
- `sesCommentaires` : un restaurant possède plusieurs commentaires.

### `Menus`

Représente un menu proposé par un restaurant.

| Attribut | Type | Rôle |
| --- | --- | --- |
| `type_menu` | String | Catégorie du menu |
| `descriptionMenu` | String | Description affichée à l'utilisateur |

Relation :

- `sonRestaurant` : rattachement au restaurant concerné.

### `Horaire`

Représente les horaires d'ouverture d'un restaurant.

| Attribut | Type | Rôle |
| --- | --- | --- |
| `jour` | String | Jour concerné |
| `ouverture` | String | Créneau d'ouverture |

Relation :

- `sonResto` : rattachement au restaurant concerné.

### `Commentaires`

Représente un avis utilisateur.

| Attribut | Type | Rôle |
| --- | --- | --- |
| `contenu` | String | Texte du commentaire |
| `note` | Integer 16 | Note donnée au restaurant |

Relation :

- `leRestaurant` : restaurant commenté.

## Vue relationnelle simplifiée

```text
Restaurants
  1 ─── * Menus
  1 ─── * Horaire
  1 ─── * Commentaires
```

## Lien avec le projet académique SQL

Pendant la Licence, un autre projet de base de données a porté sur un domaine restaurant plus large : clients, commandes, menus, ingrédients, boissons et fournisseurs.

Ce modèle SQL n'est pas utilisé directement par l'application iOS, mais il montre une autre compétence complémentaire : la modélisation relationnelle. Une version simplifiée et nettoyée du schéma est disponible dans [`restaurantdb-schema.sql`](./restaurantdb-schema.sql).

La différence principale est la suivante :

- GastroMap CoreData : modèle mobile centré utilisateur, carte, restaurants, menus, horaires et commentaires.
- RestaurantDB SQL : modèle de gestion restaurant plus complet, avec commandes, stocks, fournisseurs et relations many-to-many.
