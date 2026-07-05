//
//  ListeRestaurantsTableViewController.swift
//  GastroMap
//
//  Created by Léa Percheron on 11/12/2024.
//

import UIKit
import CoreLocation

class ListeRestaurantsTableViewController: UITableViewController {

    private var restaurants: [Restaurants] = []
    private var restaurantsTrier: [Restaurants] = []
    private var distances: [Double] = []
    
    public let localisationUtilisateur = AppDelegate.getLocationManager().location
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //recup tous les resto
        self.restaurants = AppDelegate.getLesRestaurants()
        trierRestaurantsParDistance() //focntion de trie
        
        //couleur du fond
        tableView.backgroundColor = .black
    }
    
    //permet de trier les restaurants pour afficher celui qui est le plus proche de l'utilisateur en premier
    public func trierRestaurantsParDistance() {
        let userLocation = AppDelegate.getLocationManager().location
        
        //calcul la distance entre l'utilisateur et chaque restaurants
        for i in 0..<restaurants.count {
            let restaurant = restaurants[i]
            let latitude = restaurant.getLatitude()
            let longitude = restaurant.getLongitude()
            let restaurantLocation = CLLocation(latitude: latitude, longitude: longitude)
            let distance = restaurantLocation.distance(from: userLocation!) / 1000
            distances.append(distance)
            restaurantsTrier.append(restaurant)
        }
        
        //trie tous les restauarnts pour les avoir dans le bon ordre
        for i in 0..<distances.count {
            for j in 0..<distances.count - i - 1 {
                if distances[j] > distances[j + 1] {
                    let tempDistance = distances[j]
                    distances[j] = distances[j + 1]
                    distances[j + 1] = tempDistance
                    
                    let tempRestaurant = restaurantsTrier[j]
                    restaurantsTrier[j] = restaurantsTrier[j + 1]
                    restaurantsTrier[j + 1] = tempRestaurant
                }
            }
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listeRestaurants", for: indexPath)
        
        //couleur de la celule :
        cell.backgroundColor = .black
        cell.detailTextLabel?.textColor = .white
        //pour empecher que le cellule ne devienne blanche quand on clique dessus
        cell.selectionStyle = .none
        
        let restaurant = restaurantsTrier[indexPath.row]
        let distance = distances[indexPath.row]
        
        cell.textLabel?.text = restaurant.getNom()
        cell.detailTextLabel?.text = String(format: "%.2f km", distance)
               

        return cell
    }
    
    //si l'utilisateur clique alors ça affiche le restaurant en question
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Désélectionner la ligne après le clic
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Récupérer le restaurant sélectionné
        let restaurantSelectionne = restaurantsTrier[indexPath.row]
        
        // Charger le ViewController de détail depuis le Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "AfficheInfosRestaurantViewController") as? AfficheInfosRestaurantViewController {
            detailVC.restaurant = restaurantSelectionne
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }


}
