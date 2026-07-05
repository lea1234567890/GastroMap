-- Schema relationnel simplifie issu d'un projet academique de Licence.
-- Ce fichier documente la modelisation SQL du domaine restaurant.
-- Il ne contient pas les donnees du dump original.
-- L'application iOS GastroMap utilise CoreData et non cette base SQL.

CREATE TABLE Client (
  IDClient INT PRIMARY KEY,
  Nom VARCHAR(255) NOT NULL,
  Prenom VARCHAR(255) NOT NULL,
  Adresse VARCHAR(255) NOT NULL,
  Telephone VARCHAR(20) NOT NULL
);

CREATE TABLE Fournisseur (
  IDFournisseur INT PRIMARY KEY,
  Nom VARCHAR(255) NOT NULL,
  Prenom VARCHAR(255) NOT NULL,
  Telephone VARCHAR(20) NOT NULL,
  Adresse VARCHAR(255) NOT NULL
);

CREATE TABLE Ingredient (
  IDIngredient INT PRIMARY KEY,
  Nom_Ingredient VARCHAR(255) NOT NULL,
  Type VARCHAR(255) NOT NULL,
  Quantite_en_Stock INT NOT NULL,
  IDFournisseur INT NOT NULL,
  FOREIGN KEY (IDFournisseur) REFERENCES Fournisseur(IDFournisseur)
);

CREATE TABLE Menu (
  IDMenu INT PRIMARY KEY,
  Nom_Menu VARCHAR(255) NOT NULL,
  Description TEXT,
  Prix DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Menu_Ingredient (
  IDMenu INT NOT NULL,
  IDIngredient INT NOT NULL,
  Quantite DECIMAL(10, 2),
  PRIMARY KEY (IDMenu, IDIngredient),
  FOREIGN KEY (IDMenu) REFERENCES Menu(IDMenu),
  FOREIGN KEY (IDIngredient) REFERENCES Ingredient(IDIngredient)
);

CREATE TABLE Commande (
  IDCommande INT PRIMARY KEY,
  Date DATE NOT NULL,
  IDClient INT,
  FOREIGN KEY (IDClient) REFERENCES Client(IDClient)
);

CREATE TABLE Commande_Menu (
  IDCommande INT NOT NULL,
  IDMenu INT NOT NULL,
  Quantite DECIMAL(10, 2),
  PRIMARY KEY (IDCommande, IDMenu),
  FOREIGN KEY (IDCommande) REFERENCES Commande(IDCommande),
  FOREIGN KEY (IDMenu) REFERENCES Menu(IDMenu)
);

CREATE TABLE Boisson (
  IDBoisson INT PRIMARY KEY,
  Nom_Boisson VARCHAR(255) NOT NULL,
  Type VARCHAR(255) NOT NULL,
  Prix DECIMAL(10, 2) NOT NULL,
  Quantite_en_Stock INT NOT NULL,
  IDFournisseur INT NOT NULL,
  FOREIGN KEY (IDFournisseur) REFERENCES Fournisseur(IDFournisseur)
);

CREATE TABLE Commande_Boisson (
  IDCommande INT NOT NULL,
  IDBoisson INT NOT NULL,
  Quantite DECIMAL(10, 2),
  PRIMARY KEY (IDCommande, IDBoisson),
  FOREIGN KEY (IDCommande) REFERENCES Commande(IDCommande),
  FOREIGN KEY (IDBoisson) REFERENCES Boisson(IDBoisson)
);
