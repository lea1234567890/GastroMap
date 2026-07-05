//
//  MapTousRestaurantsViewController.swift
//  GastroMap
//
//  Created by Léa Percheron on 11/12/2024.
//

import UIKit
import MapKit

class MapTousRestaurantsViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var map: MKMapView!
    
    private var restaurants : [Restaurants] = []
    public var restaurants50KM : [Restaurants] = []
    public var locationManager : CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let location = AppDelegate.getLocationManager().location {
            locationManager = location
        }
        restaurants = AppDelegate.getLesRestaurants()
        
        //trie les restaurants pour avoir seulment ceux qui sont à 50 km de moi
        trierRestaurant50Km()
        
        //affiche les restaurants
        map.addAnnotations(restaurants50KM)
        
        //pour zommer sur la position de l'utilisateur et voir les restaurant à 50km
        let region = MKCoordinateRegion(
            center: locationManager.coordinate, latitudinalMeters: 100000, longitudinalMeters: 100000
        )
        map.setRegion(region, animated: true)
        map.mapType = .standard
        map.delegate = self
        
        self.navigationItem.backButtonTitle = "Navigation"
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotationView: MKAnnotationView) {
        if let leRestaurant = annotationView.annotation as? Restaurants {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let detailVC = storyboard.instantiateViewController(withIdentifier: "AfficheDistanceRestaurantcliquerViewController") as? AfficheDistanceRestaurantcliquerViewController {
                detailVC.restaurant = leRestaurant
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
    
    //fais le trie des restaurants pour garder ce qui sont à 50 km de l'utilisateur
    public func trierRestaurant50Km() {
        for lerestaurant in restaurants {
            let restaurantLocation = CLLocation(latitude: lerestaurant.getLatitude(), longitude: lerestaurant.getLongitude())
            
            let distance = restaurantLocation.distance(from: locationManager) / 1000
            
            if distance <= 50 {
                restaurants50KM.append(lerestaurant)
            }
        }
    }
}
