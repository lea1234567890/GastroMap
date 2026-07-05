//
//  AfficheInfosRestaurantViewController.swift
//  GastroMap
//
//  Created by Léa Percheron on 12/12/2024.
//

import UIKit
import MapKit

class AfficheInfosRestaurantViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var horairelb: UILabel!
    @IBOutlet weak var nomTF: UILabel!
    @IBOutlet weak var horaireTF: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var adresseTF: UILabel!
    @IBOutlet weak var adresselb: UILabel!
    @IBOutlet weak var carteDistance: MKMapView!
    
    var restaurant: Restaurants?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //couleur du fond
        view.backgroundColor = .black
        nomTF.textColor = .white
        horaireTF.textColor = .white
        adresseTF.textColor = .white
        navigationController?.navigationBar.tintColor = .orange
        self.navigationItem.backButtonTitle = "Restaurant"
        adresselb.textColor = .orange
        horairelb.textColor = .orange
        
        carteDistance.delegate = self
        //pour recup le restaurant qu'on a cliquer
        guard let restaurant = restaurant else{ return }
        //affiche nom et adresse
        nomTF.text = restaurant.getNom()
        var adresse = "Adresse : "
        adresse += restaurant.getAdresse()
        adresseTF.text = adresse
        //horaire
        var horairesText = "\n"
        for horaire in restaurant.getHoraires() {
            horairesText += "\(horaire.getJour()) : \(horaire.getOuverture()) \n"
        }
        horaireTF.text = horairesText
        //image
        imageView.image = UIImage(named: restaurant.getImage())
    
        //pour la carte
        let locationManager = AppDelegate.getLocationManager().location!
        let localisationRestaurant = CLLocationCoordinate2D(latitude: restaurant.getLatitude(), longitude: restaurant.getLongitude())
        
        let utilisateurPosition = MKPointAnnotation()
        utilisateurPosition.coordinate = locationManager.coordinate
        utilisateurPosition.title = "Moi"
        
        carteDistance.addAnnotation(utilisateurPosition)
        carteDistance.addAnnotation(restaurant)
        
        //la route
        let startPlacemark = MKPlacemark(coordinate: locationManager.coordinate)
        let endPlacemark = MKPlacemark(coordinate: localisationRestaurant)
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
            
            self.carteDistance.addOverlay(route.polyline)
            self.carteDistance.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
    }

    //afficher le view controller des menus
    @IBAction func afficheMenu(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "MenusAfficherViewController") as? MenusAfficherViewController {
            detailVC.restaurant = restaurant
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    //afficher les commentaires sur un autre view Controller
    @IBAction func afficheCommentaires(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "CommentairesAfficherViewController") as? CommentairesAfficherViewController {
            detailVC.restaurant = restaurant
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    //https://stackoverflow.com/questions/43049400/draw-route-on-mkmapview-that-looks-like-maps-app?utm_source=chatgpt.com
    //pris sur internet, c'est pour la route
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
