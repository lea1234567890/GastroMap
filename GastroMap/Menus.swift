//
//  Menus.swift
//  GastroMap
//
//  Created by Léa Percheron on 12/12/2024.
//

import Foundation


class Menus : Codable {
    
    public var descriptionMenu : String
    private var type_menu : String
    private var sonRestaurant: Restaurants?
    
    init(descriptionMenu: String, type_menu: String, sonRestaurant: Restaurants) {
        self.descriptionMenu = descriptionMenu
        self.type_menu = type_menu
        self.sonRestaurant = sonRestaurant
    }
    
    //pour pouvoir décoder le fichier json sans prendre en compte sonRestaurant, sinon le format n'est pas correct et ça ne décode pas le fichier Json
    enum CodingKeys: String, CodingKey {
            case descriptionMenu
            case type_menu
    }
    
    //constructeur adapter pour faire les relations entre la base de donnée et les classes 
    init(_ objMenu: MenusMO){
        self.descriptionMenu = objMenu.descriptionMenu!
        self.type_menu = objMenu.type_menu!
        self.sonRestaurant = nil
    }
    
    public func setRestaurant(_ restaurant: Restaurants){
        sonRestaurant = restaurant
    }
    
    public func getDescriptionMenu() -> String{
        return descriptionMenu
    }
    
    public func getTypeMenu() -> String{
        return type_menu
    }
}
