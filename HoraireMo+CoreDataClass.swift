//
//  HoraireMo+CoreDataClass.swift
//  GastroMap
//
//  Created by Léa Percheron on 26/12/2024.
//
//

import Foundation
import CoreData
import UIKit

public class HoraireMo: NSManagedObject {
    
    static let leContexte = AppDelegate.getContext()
    
    static func tousLesHoraires() -> [HoraireMo]{
        let maRequest : NSFetchRequest<HoraireMo> = HoraireMo.fetchRequest()
        
        guard let tousHorraires = try? leContexte.fetch(maRequest)
        else {
            return []
        }
        return tousHorraires
    }
    
    static func getHorairesOuverts(_ jour: String,_ heure: String) -> [HoraireMo] {
        let request: NSFetchRequest<HoraireMo> = HoraireMo.fetchRequest()
        request.predicate = NSPredicate(format: "jour == %@", jour)
        
        guard let horaires = try? leContexte.fetch(request) else {
            return []
        }
        
        return horaires.filter { horaire in
            if let ouverture = horaire.ouverture {
                let plage = ouverture.components(separatedBy: " - ")
                if plage.count == 2 {
                    let laheure = plage[0]
                    let laminute = plage[1]
                    return heure >= laheure && heure <= laminute
                }
            }
            return false
        }
    }
}
