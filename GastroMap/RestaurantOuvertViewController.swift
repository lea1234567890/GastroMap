//
//  RestaurantOuvertViewController.swift
//  GastroMap
//
//  Created by Léa Percheron on 08/12/2024.
//

import UIKit

class RestaurantOuvertViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var horairepickerView: UIPickerView!
    @IBOutlet weak var jourPickerView: UIPickerView!
    
    
    @IBOutlet weak var infos50KMlb: UILabel!
    @IBOutlet weak var choixHeurelb: UILabel!
    @IBOutlet weak var choixJourlb: UILabel!
    
    public var jourDelaSemaine: String?
    public var heureDelaJourne: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jourPickerView.delegate = self
        jourPickerView.dataSource = self
        horairepickerView.delegate = self
        horairepickerView.dataSource = self
        
        //couleur
        view.backgroundColor = .black
        choixHeurelb.textColor = .white
        choixJourlb.textColor = .white
        infos50KMlb.textColor = .white
        navigationController?.navigationBar.tintColor = .orange
        self.navigationItem.backButtonTitle = "Restaurants Ouvert"
        
        jourDelaSemaine = semaine[0]
        heureDelaJourne = horaire[0]
    }
    //liste de la semaine
    let semaine : [String] = ["Lundi", "Mardi","Mercredi","Jeudi", "Vendredi","Samedi","Dimanche"]
    //liste des horaires ouverture
    let horaire  : [String] = ["11:30", "12:00","12:30","13:00", "13:30","14:00","14:30","19:00","19:30","20:00","20:30","21:00","21:30","22:00","22:30"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == jourPickerView {
            return semaine.count
        } else {
            return horaire.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == jourPickerView {
            return semaine[row]
        } else {
            return horaire[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == jourPickerView {
            jourDelaSemaine = semaine[row]
        } else {
            heureDelaJourne = horaire[row]
        }
    }
    
    @IBAction func afficherCarte(_ sender: UIButton) {
        //pour recup tab HoraireMO enfonction de l'heure et du jour choisis
        if(jourDelaSemaine != nil && heureDelaJourne != nil){
            let horairesOuverts = HoraireMo.getHorairesOuverts(jourDelaSemaine!, heureDelaJourne!)
            
            var restaurantsOuverts: [Restaurants] = []
            for horaire in horairesOuverts {
                if let restaurantMO = horaire.sonResto {
                    let restaurant = Restaurants(restaurantMO)
                    restaurantsOuverts.append(restaurant)
                }
            }
            //pour le lien de navigation pour affciher la map :
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let detailVC = storyboard.instantiateViewController(withIdentifier: "MapRestaurantHorairesViewController") as? MapRestaurantHorairesViewController {
                detailVC.restaurantsAafficher = restaurantsOuverts
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
    
    //pour la couleur du texte dans le picker view
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let text = pickerView == jourPickerView ? semaine[row] : horaire[row]
        return NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
    }
}
