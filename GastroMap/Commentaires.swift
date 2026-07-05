//
//  Commentaires.swift
//  GastroMap
//
//  Created by Léa Percheron on 12/12/2024.
//

import Foundation

class Commentaires: Codable {
    private var contenu : String
    private var note : Int16
    private var leRestaurant: Restaurants?
    
    //pour pouvoir décoder le fichier json sans prendre en compte sonRestaurant, sinon le format n'est pas correct et ça ne décode pas le fichier Json
    enum CodingKeys: String, CodingKey {
            case contenu
            case note
    }
    
    init(contenu: String, note: Int16, leRestaurant: Restaurants) {
        self.contenu = contenu
        self.note = note
        self.leRestaurant = nil
    }
    
    //constructeur adapter pour faire les relations entre la base de donnée et les classes 
    init(_ objetCommentaires : CommentairesMO){
        self.contenu = objetCommentaires.contenu!
        self.note = objetCommentaires.note
        self.leRestaurant = nil
    }
    
    public func setRestaurant(_ restaurant: Restaurants) {
        self.leRestaurant = restaurant
    }
    
    public func getContenu() -> String {
        return contenu
    }
    
    public func getNote() -> Int16 {
        return note
    }
}
