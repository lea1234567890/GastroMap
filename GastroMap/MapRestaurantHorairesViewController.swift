//
//  MapRestaurantHorairesViewController.swift
//  GastroMap
//
//  Created by Lea Percheron on 05/12/2024.
//

import UIKit
import CoreData
import MapKit

class MapRestaurantHorairesViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    public var restaurantsAafficher: [Restaurants] = []
    public var restaurants50KM: [Restaurants] = []
    public let locationManager = AppDelegate.getLocationManager().location!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trierRestaurant50Km()
        mapView.delegate = self
        mapView.addAnnotations(restaurants50KM)
        
        //position de l'utilisateur
        let utilisateurPosition = MKPointAnnotation()
        utilisateurPosition.coordinate = locationManager.coordinate
        utilisateurPosition.title = "Moi"
        mapView.addAnnotation(utilisateurPosition)
        
        
        //pour zommer sur la position de l'utilisateur et voir les restaurant à 50km
        let region = MKCoordinateRegion(
            center: utilisateurPosition.coordinate, latitudinalMeters: 100000, longitudinalMeters: 100000
        )
        mapView.setRegion(region, animated: true)
        
    }

    public func trierRestaurant50Km() {
        for restaurant in restaurantsAafficher {
            let restaurantLocation = CLLocation(latitude: restaurant.getLatitude(), longitude: restaurant.getLongitude())
            
            let distance = restaurantLocation.distance(from: locationManager) / 1000
            
            if distance <= 50 {
                restaurants50KM.append(restaurant)
            }
        }
    }
    
    //lorsqu'on clique sur l'annotation du restaurant ça affiche les infos sur ce restaurant
    func mapView(_ mapView: MKMapView, didSelect annotationView: MKAnnotationView) {
        if let leRestaurant = annotationView.annotation as? Restaurants {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let detailVC = storyboard.instantiateViewController(withIdentifier: "AfficheInfosRestaurantViewController") as? AfficheInfosRestaurantViewController {
                detailVC.restaurant = leRestaurant
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
    
}
