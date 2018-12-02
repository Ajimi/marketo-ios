//
//  FavoriteViewController.swift
//  marketo
//
//  Created by Moncef Guettat on 12/2/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit
import CoreData

let favoriteProdCell = "favoriteProdCell"

class FavoriteViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var favoriteProducts = [FavoriteProduct]()

    @IBOutlet weak var favoriteProductsTableView : UITableView!
    
    fileprivate func fetchFavoriteProducts() {
        let pers = PersistenceManager.shared
        favoriteProducts = pers.fetch(FavoriteProduct.self)
        favoriteProductsTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchFavoriteProducts()
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteProductsTableView.dequeueReusableCell(withIdentifier: favoriteProdCell) as! FavoriteProductTableViewCell
        
        cell.configure(with: favoriteProducts[indexPath.item])
        
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let pers = PersistenceManager.shared
            pers.delete(favoriteProducts[indexPath.item])
            favoriteProducts.remove(at: indexPath.item)
            favoriteProductsTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
