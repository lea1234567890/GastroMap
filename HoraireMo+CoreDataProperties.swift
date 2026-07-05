//
//  HoraireMo+CoreDataProperties.swift
//  GastroMap
//
//  Created by Léa Percheron on 26/12/2024.
//
//

import Foundation
import CoreData


extension HoraireMo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HoraireMo> {
        return NSFetchRequest<HoraireMo>(entityName: "Horaire")
    }

    @NSManaged public var jour: String?
    @NSManaged public var ouverture: String?
    @NSManaged public var sonResto: RestaurantsMO?

}

extension HoraireMo : Identifiable {

}
