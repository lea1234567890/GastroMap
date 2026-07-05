//
//  CommentairesAfficherViewController.swift
//  GastroMap
//
//  Created by Léa Percheron on 28/12/2024.
//

import UIKit
import CoreData

class CommentairesAfficherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var erreurlb: UILabel!
    @IBOutlet weak var ajCommenatireLB: UILabel!
    @IBOutlet weak var commentairelb: UILabel!
    @IBOutlet weak var étoileslb: UILabel!
    @IBOutlet weak var notelb: UILabel!
    @IBOutlet weak var noteTF: UITextField!
    @IBOutlet weak var commentaireTF: UITextField!
    @IBOutlet weak var CommentairestableView: UITableView!
    
    public var restaurant : Restaurants?
    public var tabCommentaires : [Commentaires] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let restaurant = restaurant else{ return }
        tabCommentaires = restaurant.getCommentaires()
        
        CommentairestableView.delegate = self
        CommentairestableView.dataSource = self
        
        //couleur :
        view.backgroundColor = .black
        étoileslb.textColor = .systemIndigo
        notelb.textColor = .systemIndigo
        commentairelb.textColor = .white
        ajCommenatireLB.textColor = .systemIndigo
        CommentairestableView.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .orange
    }
    
    
    @IBAction func ajouterCommentaires(_ sender: Any) {
        
        if (commentaireTF.text!.isEmpty || noteTF.text!.isEmpty) {
            erreurlb.text = "Veuillez saisir tous le champs"
            return
        } else {
            if(Int16(noteTF.text!)! > 5 || Int16(noteTF.text!)! >= 0 ){
                erreurlb.text = "Votre note doit être en dessous de 6 et supérieur à 0"
            }
            else {
                let leContexte = AppDelegate.getContext()
                let objCommentaire = CommentairesMO(context : leContexte)
                objCommentaire.contenu = commentaireTF.text
                objCommentaire.note = Int16(noteTF.text!)!
                
                for restaurantCommentaire in RestaurantsMO.tousLesRestaurants() {
                    if restaurantCommentaire.nom == restaurant?.getNom() {
                        objCommentaire.leRestaurant = restaurantCommentaire
                    }
                }
                
                RAZ()//met à vide tout
                do {
                    try leContexte.save()
                    //met le commentaire dans le tab pour l'afficher dans la table view
                    let nouveauCommentaire = Commentaires(objCommentaire)
                    tabCommentaires.append(nouveauCommentaire)
                    CommentairestableView.reloadData()
                } catch let error as NSError {
                    print("Impossible de sauver le conxte \(error)")
                }
            }
        }
        
    
    }
    
    public func RAZ(){
        noteTF.text = ""
        commentaireTF.text = ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabCommentaires.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let uneCellule = tableView.dequeueReusableCell(withIdentifier: "cellCommentaires", for:indexPath)
        //couleur de la cellule et du texte
        uneCellule.backgroundColor = .black
        uneCellule.detailTextLabel?.textColor = .white
        //pour les lignes, sinon ça n'affiche pas tous mon commentaire seulement une partie
        uneCellule.textLabel?.numberOfLines = 0
        uneCellule.textLabel?.lineBreakMode = .byWordWrapping
        
        uneCellule.textLabel!.text = tabCommentaires[indexPath.row].getContenu()
        uneCellule.detailTextLabel!.text = "\(tabCommentaires[indexPath.row].getNote()) étoiles"

        return uneCellule
    }
}
