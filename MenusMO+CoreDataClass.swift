//
//  MenusMO+CoreDataClass.swift
//  GastroMap
//
//  Created by Léa Percheron on 26/12/2024.
//
//

import Foundation
import CoreData
import UIKit


public class MenusMO: NSManagedObject {
    
    static let leContexte = AppDelegate.getContext()
    
    static func tousLesMenus() -> [MenusMO]{
        
        let maRequest : NSFetchRequest<MenusMO> = MenusMO.fetchRequest()
        
        guard let tousMenus = try? leContexte.fetch(maRequest)
        else {
            return []
        }
        
        return tousMenus
    }
    
    static func toutesLesEntrées(_ restaurant : RestaurantsMO) -> [MenusMO] {
        let maRequest: NSFetchRequest<MenusMO> = MenusMO.fetchRequest()
        
        maRequest.predicate = NSPredicate(format: "type_menu == %@ AND leRestaurant == %@",
                                          "Entrée",
                                          restaurant)
            
        guard let entrées = try? leContexte.fetch(maRequest)
        else {
            return []
        }
        
        return entrées
    }
    
    static func tousLesPlatsPrincipals(_ restaurant : RestaurantsMO) -> [MenusMO] {
         let maRequest: NSFetchRequest<MenusMO> = MenusMO.fetchRequest()
         
         maRequest.predicate = NSPredicate(format: "type_menu == %@ AND leRestaurant == %@",
                                           "Plat principal",
                                           restaurant)
             
         guard let platsPrincipales = try? leContexte.fetch(maRequest)
         else {
             return []
         }
         
         return platsPrincipales
     }
     
    static func tousLesDesserts(_ restaurant : RestaurantsMO) -> [MenusMO] {
      let maRequest: NSFetchRequest<MenusMO> = MenusMO.fetchRequest()
      
      maRequest.predicate = NSPredicate(format: "type_menu == %@ AND leRestaurant == %@",
                                        "Dessert",
                                        restaurant)
          
      guard let desserts = try? leContexte.fetch(maRequest)
      else {
          return []
      }
      
      return desserts
    }
    
    
}
