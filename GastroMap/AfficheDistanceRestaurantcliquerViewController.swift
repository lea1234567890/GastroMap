//
//  AfficheInfosRestaurantsOuvertsViewController.swift
//  GastroMap
//
//  Created by Léa Percheron on 30/12/2024.
//

import UIKit
import MapKit

class AfficheDistanceRestaurantcliquerViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var piedtTempslb: UILabel!
    @IBOutlet weak var voitureTempslb: UILabel!
    @IBOutlet weak var distanceKMlb: UILabel!
    
    @IBOutlet weak var map: MKMapView!
    
    public var restaurant: Restaurants?
    public let locationManager = AppDelegate.getLocationManager().location!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //couleur
        view.backgroundColor = .black
        piedtTempslb.textColor = .white
        voitureTempslb.textColor = .white
        distanceKMlb.textColor = .white
        navigationController?.navigationBar.tintColor = .orange
        self.navigationItem.backButtonTitle = "Restaurant"

        map.delegate = self
        
        //localisation restaurant
        let localisationRestaurant = CLLocation(latitude: restaurant!.getLatitude(), longitude: restaurant!.getLongitude())
        //calcul distance
        let distance = localisationRestaurant.distance(from: locationManager) / 1000
        distanceKMlb.text = String(format: "%.2f km", distance)
        
        
        let positionRestaurant = CLLocationCoordinate2D(latitude: restaurant!.getLatitude(), longitude: restaurant!.getLongitude())

        let userAnnotation = MKPointAnnotation()
        userAnnotation.coordinate = locationManager.coordinate
        userAnnotation.title = "Moi"

        map.addAnnotation(userAnnotation)
        map.addAnnotation(restaurant!)

        //Tracer  de la route sur la  map
        let startPlacemark = MKPlacemark(coordinate: locationManager.coordinate)
        let endPlacemark = MKPlacemark(coordinate: positionRestaurant)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startPlacemark)
        request.destination = MKMapItem(placemark: endPlacemark)
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let self = self,
                  let route = response?.routes.first else {
                print("Erreur : \(error?.localizedDescription ?? "Erreur inconnue")")
                return
            }
            
            self.map.addOverlay(route.polyline)
            self.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
        
    
        //https://developer.apple.com/documentation/mapkit/mkdirections/request?utm_source=chatgpt.com
        //pour afficher le temps en Voiture et à pied
        let requeteVoiture = MKDirections.Request()
        requeteVoiture.source = MKMapItem(placemark: MKPlacemark(coordinate: locationManager.coordinate))
        requeteVoiture.destination = MKMapItem(placemark: MKPlacemark(coordinate: localisationRestaurant.coordinate))
        
        //temps en voiture que met l'utilisateur pour arriver au restaurant requete de apple
        requeteVoiture.transportType = .automobile
        MKDirections(request: requeteVoiture).calculate { [weak self] response, _ in
            if let temps = response?.routes.first?.expectedTravelTime {
                DispatchQueue.main.async {
                    let heures = Int(temps) / 3600
                    let minutes = (Int(temps) / 60) % 60
                    let tempsTexte = heures > 0 ? "\(heures)h \(minutes)min" : "\(minutes)min"
                    self?.voitureTempslb.text = tempsTexte
                }
            }
        }
        
        //temps à pied que met l'utilisateur pour arriver au restaurant
        requeteVoiture.transportType = .walking
        MKDirections(request: requeteVoiture).calculate { [weak self] response, _ in
            if let temps = response?.routes.first?.expectedTravelTime {
                DispatchQueue.main.async {
                    let heures = Int(temps) / 3600
                    let minutes = (Int(temps) / 60) % 60
                    let tempsTexte = heures > 0 ? "\(heures)h \(minutes)min" : "\(minutes)min"
                    self?.piedtTempslb.text = tempsTexte
                }
            }
        }
    }
    
    //pour aficher les informations du restaurant
    @IBAction func affiheInfosRestaurant(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "AfficheInfosRestaurantViewController") as? AfficheInfosRestaurantViewController {
            detailVC.restaurant = restaurant
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    //https://stackoverflow.com/questions/43049400/draw-route-on-mkmapview-that-looks-like-maps-app?utm_source=chatgpt.com
    //pour la route entre le restauarnt et l'utilisateur
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .blue
            renderer.lineWidth = 4.0
            return renderer
        }
        return MKOverlayRenderer()
    }
}
