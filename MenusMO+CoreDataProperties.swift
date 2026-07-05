//
//  MenusMO+CoreDataProperties.swift
//  GastroMap
//
//  Created by Léa Percheron on 26/12/2024.
//
//

import Foundation
import CoreData


extension MenusMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MenusMO> {
        return NSFetchRequest<MenusMO>(entityName: "Menus")
    }

    @NSManaged public var descriptionMenu: String?
    @NSManaged public var type_menu: String?
    @NSManaged public var sonRestaurant: RestaurantsMO?

}

extension MenusMO : Identifiable {

}
