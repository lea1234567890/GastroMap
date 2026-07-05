//
//  LaunchScreenViewController.swift
//  GastroMap
//
//  Created by Léa Percheron on 28/12/2024.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var imageLogo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLogo.image = UIImage(named: "logo")
        //fond noir
    }
    

}
