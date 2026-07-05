//
//  MenusAfficherViewController.swift
//  GastroMap
//
//  Created by Léa Percheron on 28/12/2024.
//

import UIKit

class MenusAfficherViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var dessertlb: UILabel!
    @IBOutlet weak var entreeLb: UILabel!
    @IBOutlet weak var platlb: UILabel!
    
    @IBOutlet weak var platPrincipaleTableview: UITableView!
    @IBOutlet weak var entréeTableView: UITableView!
    @IBOutlet weak var dessertTableview: UITableView!
    
    public var tabMenus : [Menus] = []
    public var restaurant : Restaurants?
    private var entrees: [Menus] = []
    private var plats: [Menus] = []
    private var desserts: [Menus] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let restaurant = restaurant else{ return }
        tabMenus = restaurant.getMenus()
        
        entréeTableView.delegate = self
        entréeTableView.dataSource = self
        platPrincipaleTableview.delegate = self
        platPrincipaleTableview.dataSource = self
        dessertTableview.delegate = self
        dessertTableview.dataSource = self
        
        chargerMenus()
        
        //couleur texte :
        entréeTableView.backgroundColor = .black
        platPrincipaleTableview.backgroundColor = .black
        dessertTableview.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .orange

        view.backgroundColor = .black
        entreeLb.textColor = .white
        platlb.textColor = .white
        dessertlb.textColor = .white
    }
    
    private func chargerMenus() {
        for unMenu in restaurant!.getMenus() {
            if(unMenu.getTypeMenu() == "Entrée") {
                entrees.append(unMenu)
            } else {
                if(unMenu.getTypeMenu() == "Plat principal") {
                    plats.append(unMenu)
                } else {
                    desserts.append(unMenu)
                }
            }
        }
        
        entréeTableView.reloadData()
        platPrincipaleTableview.reloadData()
        dessertTableview.reloadData()
    }
    
    

}

extension MenusAfficherViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == entréeTableView) {
            return entrees.count
        }else {
            if(tableView == platPrincipaleTableview){
                return plats.count
            } else {
                return desserts.count
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        cell.backgroundColor = .black
        let menu: Menus
        if(tableView == entréeTableView) {
            menu = entrees[indexPath.row]
        } else {
            if(tableView == platPrincipaleTableview){
                menu = plats[indexPath.row]
            }
            else {
                menu = desserts[indexPath.row]
            }
        }
        
        cell.textLabel?.text = menu.getDescriptionMenu()
        
        return cell
    }
}


