//
//  WebService.swift
//  GastroMap
//
//  Created by Léa Percheron on 07/12/2024.
//

import Foundation
import CoreData
import UIKit

class WebService {

    static func chargementDuWebService() {
        guard let urlServeur = URL(string: "https://raw.githubusercontent.com/lea1234567890/restaurant-data/main/restaurant_data.json") else {
            print("Erreur : URL invalide.")
            return
        }
        
        let urlSession = URLSession.shared
        let requete = URLRequest(url: urlServeur)
        
        let dataTask = urlSession.dataTask(with: requete) { (data, response, error) in
            guard let jsonData = data, error == nil else {
                print("Erreur réseau : \(error?.localizedDescription ?? "Inconnue")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonResponse = try decoder.decode([String: [Restaurants]].self, from: jsonData)
                
                if let restaurants = jsonResponse["restaurants"] {
                    DispatchQueue.main.async {
                        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                        let context = appDelegate.persistentContainer.viewContext
                        //remplit la base de données avec les données de mon web service
                        for restaurant in restaurants {
                            let restaurantMO = RestaurantsMO(context: context)
                            restaurantMO.nom = restaurant.getNom()
                            restaurantMO.adresse = restaurant.getAdresse()
                            restaurantMO.latitude = restaurant.getLatitude()
                            restaurantMO.longitude = restaurant.getLongitude()
                            restaurantMO.image = restaurant.getImage()
                            
                            for menu in restaurant.getMenus() {
                                menu.setRestaurant(restaurant)
                                let menuMO = MenusMO(context: context)
                                menuMO.descriptionMenu = menu.getDescriptionMenu()
                                menuMO.type_menu = menu.getTypeMenu()
                                restaurantMO.addToSesMenus(menuMO)
                            }
                            
                            for horaire in restaurant.getHoraires() {
                                horaire.setRestaurant(restaurant)
                                let horaireMO = HoraireMo(context: context)
                                horaireMO.jour = horaire.getJour()
                                horaireMO.ouverture = horaire.getOuverture()
                                restaurantMO.addToSesHoraires(horaireMO)
                            }
                            
                            for commentaire in restaurant.getCommentaires() {
                                commentaire.setRestaurant(restaurant)
                                let commentaireMO = CommentairesMO(context: context)
                                commentaireMO.contenu = commentaire.getContenu()
                                commentaireMO.note = Int16(commentaire.getNote())
                                restaurantMO.addToSesCommentaires(commentaireMO)
                            }
                        }
                        
                        try? context.save()
                        print("Importation réussie dans Core Data.")
                    }
                }
            } catch {
                print("Erreur JSON : \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
}
