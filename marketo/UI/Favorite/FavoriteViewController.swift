//
//  FavoriteViewController.swift
//  marketo
//
//  Created by Moncef Guettat on 12/2/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit
import CoreData

let favoriteProdCell = "favoriteProductCell"
typealias FavoriteProducts =  [FavoriteProduct]


class FavoriteViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, FavoriteProductTableViewCellDelegate {
    
    let viewModel = FavoriteViewModel()
    

    
    @IBOutlet weak var favoriteProductsCollecionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.updateUI()
        favoriteProductsState()
        deleteFavoriteProductState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.updateUI()
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
                    print("data reloaded in favoriteVC")
                    self.favoriteProductsCollecionView.reloadData()
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
                    self.favoriteProductsCollecionView.deleteItems(at: [indexPath])
                }
            }
        }
    }
    

}


extension FavoriteViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.favoriteProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: favoriteProdCell,for: indexPath) as! FavoriteProductCollectionViewCell
        
        cell.configure(with: viewModel.favoriteProducts[indexPath.item])
        
        return cell
    }
}


// MARK:-Delegated Method for Remove Button
extension FavoriteViewController {
    func favoriteProductCellDidTapRemove(_ sender: FavoriteProductCollectionViewCell) {
        guard let tappedIndexPath = favoriteProductsCollecionView.indexPath(for: sender) else { return }
        viewModel.removeProductFromFavorite(at: tappedIndexPath)
    }
}
