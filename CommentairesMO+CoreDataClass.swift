//
//  CommentairesMO+CoreDataClass.swift
//  GastroMap
//
//  Created by Léa Percheron on 26/12/2024.
//
//

import Foundation
import CoreData
import UIKit


public class CommentairesMO: NSManagedObject {
    
    static let leContexte = AppDelegate.getContext()
    
    static func tousLesCommentaire() -> [CommentairesMO]{
        
        let maRequest : NSFetchRequest<CommentairesMO> = CommentairesMO.fetchRequest()
        
        guard let tousCommentaires = try? leContexte.fetch(maRequest)
        else { return [] }
        
        return tousCommentaires
    }
    
    static func commentairesPourRestaurant(_ restaurant: RestaurantsMO) -> [CommentairesMO] {
        let maRequest: NSFetchRequest<CommentairesMO> = CommentairesMO.fetchRequest()
        
        maRequest.predicate = NSPredicate(format: "sonRestaurant == %@", restaurant)
            
        guard let commentaires = try? leContexte.fetch(maRequest)
        else {
            return []
        }
        
        return commentaires
    }

}
