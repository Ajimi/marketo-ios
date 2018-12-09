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
typealias FavoriteProducts =  [FavoriteProduct]


class FavoriteViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, FavoriteProductTableViewCellDelegate {
    
    let viewModel = FavoriteViewModel()
    

    
    @IBOutlet weak var favoriteProductsTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.updateUI()
        favoriteProductsState()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    fileprivate func favoriteProductsState() {
        viewModel.uiFavoriteProductState.bindAndFire(listener: { (uiModel) in
            if (uiModel.showProgress) {
                print("In progress")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error \(errorMessage)")
            }
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let _ = showSucces.consume() {
                DispatchQueue.main.async {
                    self.favoriteProductsTableView.reloadData()
                }
            }
        })
    }
    
    fileprivate func deleteFavoriteProductState() {
        viewModel.uiDeleteFavoriteProductState.bindAndFire { uiModel in
            if (uiModel.showProgress) {
                print("In progress")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error \(errorMessage)")
            }
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let indexPath = showSucces.consume() {
                DispatchQueue.main.async {
                    self.favoriteProductsTableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
    

}


extension FavoriteViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoriteProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteProductsTableView.dequeueReusableCell(withIdentifier: favoriteProdCell) as! FavoriteProductTableViewCell
        
        cell.configure(with: viewModel.favoriteProducts[indexPath.item])
        
        return cell
    }
}


// MARK:-Delegated Method for Remove Button
extension FavoriteViewController {
    func favoriteProductCellDidTapRemove(_ sender: FavoriteProductTableViewCell) {
        guard let tappedIndexPath = basketTableView.indexPath(for: sender) else { return }
        viewModel.removeProductFromFavorite(at: tappedIndexPath)
    }
    
}
