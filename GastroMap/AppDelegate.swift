//
//  AppDelegate.swift
//  GastroMap
//
//  Created by Lea Percheron on 04/12/2024.
//

import UIKit
import CoreData
import MapKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    static var locationManager : CLLocationManager = CLLocationManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("Documents Directory: ", FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last ?? "Not Found!")
        //pour l'autorisation de géolocalisation
        AppDelegate.locationManager.requestWhenInUseAuthorization()
        AppDelegate.locationManager.delegate = self
        AppDelegate.locationManager.startUpdatingLocation()
        
        
        //inserer les données dans coreData avec un WebService, fichier json data sur github
        let defaults = UserDefaults.standard
        //ça vérifier si les données ont déjà chargées
        if defaults.bool(forKey: "isDataLoaded") {
            print("Données déjà téléchargées.")
        } else {
            print("Chargement des données.")
            WebService.chargementDuWebService()
            defaults.set(true, forKey: "isDataLoaded") //change
        }
        
        return true
    }
    
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static public func getLocationManager() ->  CLLocationManager {
        return AppDelegate.locationManager
    }
    
    static public func getLesRestaurants() -> [Restaurants] {
        let lesRestaurantMO: [RestaurantsMO] = RestaurantsMO.tousLesRestaurants()
        var lesRestaurant: [Restaurants] = []
        
        for i in 0..<lesRestaurantMO.count {
            let objRestaurant = Restaurants(lesRestaurantMO[i])
            lesRestaurant.append(objRestaurant)
        }
        return lesRestaurant
    }

    
    static public func getTousLesCommentaires() -> [Commentaires] {
        let lesCommentairesMO: [CommentairesMO] = CommentairesMO.tousLesCommentaire()
        var lesCommentaires: [Commentaires] = []
        
        for i in 0..<lesCommentairesMO.count {
            let objCommentaires = Commentaires(lesCommentairesMO[i])
            lesCommentaires.append(objCommentaires)
        }
        
        return lesCommentaires
    }
    
    static public func getTousLesMenus() -> [Menus] {
        let lesMenusMO : [MenusMO] = MenusMO.tousLesMenus()
        var lesMenus : [Menus] = []
        
        for i in 0..<lesMenusMO.count {
            let objMenus = Menus(lesMenusMO[i])
            lesMenus.append(objMenus)
        }
        
        return lesMenus
        
    }
    
    static public func getTousLesHoraires() -> [Horaire] {
        let lesHoraireMo : [HoraireMo] = HoraireMo.tousLesHoraires()
        var lesHoraire : [Horaire] = []
        
        for i in 0..<lesHoraireMo.count {
            let objHoraire = Horaire(lesHoraireMo[i])
            lesHoraire.append(objHoraire)
        }
        
        return lesHoraire
        
    }

    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GastroMap")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

