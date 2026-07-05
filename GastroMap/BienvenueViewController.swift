//
//  BienvenueViewController.swift
//  GastroMap
//
//  Created by Léa Percheron on 08/12/2024.
//

import UIKit

class BienvenueViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var infosRestaurantlb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //pour afficher le logo de l'application
        image.image = UIImage(named: "logo")
        //fond noir
        view.backgroundColor = .black
        infosRestaurantlb.textColor = .white
    }
    

}
