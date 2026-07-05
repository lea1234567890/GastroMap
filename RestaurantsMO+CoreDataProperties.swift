//
//  RestaurantsMO+CoreDataProperties.swift
//  GastroMap
//
//  Created by Léa Percheron on 26/12/2024.
//
//

import Foundation
import CoreData


extension RestaurantsMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RestaurantsMO> {
        return NSFetchRequest<RestaurantsMO>(entityName: "Restaurants")
    }

    @NSManaged public var adresse: String?
    @NSManaged public var image: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var nom: String?
    @NSManaged public var sesCommentaires: NSSet?
    @NSManaged public var sesHoraires: NSSet?
    @NSManaged public var sesMenus: NSSet?

}

// MARK: Generated accessors for sesCommentaires
extension RestaurantsMO {

    @objc(addSesCommentairesObject:)
    @NSManaged public func addToSesCommentaires(_ value: CommentairesMO)

    @objc(removeSesCommentairesObject:)
    @NSManaged public func removeFromSesCommentaires(_ value: CommentairesMO)

    @objc(addSesCommentaires:)
    @NSManaged public func addToSesCommentaires(_ values: NSSet)

    @objc(removeSesCommentaires:)
    @NSManaged public func removeFromSesCommentaires(_ values: NSSet)

}

// MARK: Generated accessors for sesHoraires
extension RestaurantsMO {

    @objc(addSesHorairesObject:)
    @NSManaged public func addToSesHoraires(_ value: HoraireMo)

    @objc(removeSesHorairesObject:)
    @NSManaged public func removeFromSesHoraires(_ value: HoraireMo)

    @objc(addSesHoraires:)
    @NSManaged public func addToSesHoraires(_ values: NSSet)

    @objc(removeSesHoraires:)
    @NSManaged public func removeFromSesHoraires(_ values: NSSet)

}

// MARK: Generated accessors for sesMenus
extension RestaurantsMO {

    @objc(addSesMenusObject:)
    @NSManaged public func addToSesMenus(_ value: MenusMO)

    @objc(removeSesMenusObject:)
    @NSManaged public func removeFromSesMenus(_ value: MenusMO)

    @objc(addSesMenus:)
    @NSManaged public func addToSesMenus(_ values: NSSet)

    @objc(removeSesMenus:)
    @NSManaged public func removeFromSesMenus(_ values: NSSet)

}

extension RestaurantsMO : Identifiable {

}
