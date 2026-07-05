//
//  RestaurantsMO+CoreDataClass.swift
//  GastroMap
//
//  Created by Léa Percheron on 26/12/2024.
//
//

import Foundation
import CoreData
import UIKit
import MapKit


public class RestaurantsMO: NSManagedObject {
    
    static let leContexte = AppDelegate.getContext()
    
    static func tousLesRestaurants() -> [RestaurantsMO] {
        let maRequest : NSFetchRequest<RestaurantsMO> = RestaurantsMO.fetchRequest()
        
        guard let tousRestaurants = try? leContexte.fetch(maRequest)
        else {
            return []
        }
        return tousRestaurants
    }
    

}
