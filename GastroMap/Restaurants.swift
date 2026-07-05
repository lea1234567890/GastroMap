//
//  Restaurants.swift
//  GastroMap
//
//  Created by Léa Percheron on 12/12/2024.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class Restaurants : NSObject, Codable {
    
    private var adresse: String
    private var image: String
    private var latitude: Double
    private var longitude: Double
    private var nom: String
    private var sesCommentaires: [Commentaires]?
    private var sesHoraires: [Horaire]?
    private var sesMenus: [Menus]?
    
    init(_ adresse: String,_ image: String,_ latitude: Double,_ longitude: Double,_ nom: String) {
        self.adresse = adresse
        self.image = image
        self.latitude = latitude
        self.longitude = longitude
        self.nom = nom
        self.sesCommentaires = []
        self.sesHoraires = []
        self.sesMenus = []
    }
    
    //constructeur adapter pour faire les relations entre la base de donnée et les classes
    init(_ objetResto: RestaurantsMO) {
        self.adresse = objetResto.adresse!
        self.image = objetResto.image!
        self.latitude = objetResto.latitude
        self.longitude = objetResto.longitude
        self.nom = objetResto.nom!
        self.sesCommentaires = []
        self.sesHoraires = []
        self.sesMenus = []
        
        //pris sur internet : https://www.hackingwithswift.com/books/ios-swiftui/one-to-many-relationships-with-core-data-swiftui-and-fetchrequest?utm_source=chatgpt.com
        //pour la relation entre le restaurants et ses horaire
        if let horaires = objetResto.sesHoraires?.allObjects as? [HoraireMo] {
             self.sesHoraires = horaires.map { Horaire($0) }
        }
        //pareil mais pour les commentaires
        if let commentaires = objetResto.sesCommentaires?.allObjects as? [CommentairesMO] {
            self.sesCommentaires = commentaires.map { Commentaires($0) }
        }
        //pour les menus
        if let menus = objetResto.sesMenus?.allObjects as? [MenusMO] {
            self.sesMenus = menus.map { Menus($0) }
        }
        // map ->  transformer chaque élément du tableau menus
        
    }
    
    //tous les set
    public func setCommentaire(_ lescommentaire: [Commentaires]) {
        sesCommentaires = lescommentaire
    }
    
    public func setMenus(_ lesMenus: [Menus]) {
        sesMenus = lesMenus
    }
    
    public func setsesHoraires(_ lesHoraires: [Horaire]) {
        sesHoraires = lesHoraires
    }
    
    //toius les get
    public func getCommentaires() -> [Commentaires] {
        return sesCommentaires!
    }
    
    public func getHoraires() -> [Horaire] {
        return sesHoraires!
    }
    
    public func getMenus() -> [Menus] {
        return sesMenus!
    }
    
    public func getLatitude() -> Double {
        return latitude
    }
    
    public func getLongitude() -> Double {
        return longitude
    }
    
    public func getNom() -> String {
        return nom
    }
    
    public func getAdresse() -> String {
        return adresse
    }
    
    public func getImage() -> String {
        return image
    }

}

extension Restaurants : MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        let lescoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        return lescoordinate
    }

    var title : String? {
        return nom
    }
}
