//
//  CommentairesMO+CoreDataProperties.swift
//  GastroMap
//
//  Created by Léa Percheron on 26/12/2024.
//
//

import Foundation
import CoreData


extension CommentairesMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CommentairesMO> {
        return NSFetchRequest<CommentairesMO>(entityName: "Commentaires")
    }

    @NSManaged public var contenu: String?
    @NSManaged public var note: Int16
    @NSManaged public var leRestaurant: RestaurantsMO?

}

extension CommentairesMO : Identifiable {

}
