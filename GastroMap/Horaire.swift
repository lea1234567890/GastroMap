//
//  Horaire.swift
//  GastroMap
//
//  Created by Léa Percheron on 12/12/2024.
//

import Foundation

class Horaire : Codable {
    private var jour : String
    private var ouverture : String
    private var sonResto : Restaurants?
    
    init(jour: String, ouverture: String, sonResto: Restaurants) {
        self.jour = jour
        self.ouverture = ouverture
        self.sonResto = sonResto
    }
    
    //pour pouvoir décoder le fichier json sans prendre en compte sonRestaurant, sinon le format n'est pas correct et ça ne décode pas le fichier Json
    enum CodingKeys: String, CodingKey {
            case jour
            case ouverture
    }
    //constructeur adapter pour faire les relations entre la base de donnée et les classes 
    init(_ ojetHoraire : HoraireMo){
        self.jour = ojetHoraire.jour!
        self.ouverture = ojetHoraire.ouverture!
        self.sonResto = nil
    }
    
    public func setRestaurant(_ resto: Restaurants){
        self.sonResto = resto
    }
    
    public func getJour() -> String{
        return self.jour
    }
    
    public func getOuverture() -> String{
        return self.ouverture
    }
    
    public func getSonResto() -> Restaurants?{
        return self.sonResto
    }
}

