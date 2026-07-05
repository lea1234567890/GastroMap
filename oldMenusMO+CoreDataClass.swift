//
//  MenusMO+CoreDataClass.swift
//  GastroMap
//
//  Created by Léa Percheron on 07/12/2024.
//
//

import Foundation
import CoreData
import UIKit


public class MenusMO: NSManagedObject {
    
    static func tousLesMenus() -> [MenusMO]{
        
        let maRequest : NSFetchRequest<MenusMO> = MenusMO.fetchRequest()
        
        guard let tousMenus = try? (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext.fetch(maRequest)
        else {
            return []
        }
        
        return tousMenus
    }
}
