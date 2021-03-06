//
//  FavoriteViewController.swift
//  marketo
//
//  Created by Moncef Guettat on 12/2/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit
import CoreData
import PKHUD
import Alamofire

private let favoriteProdCell = "favoriteProductCell"
private let navigateToProductDetailSegueIdentifier = "navigateToProductDetail"

typealias FavoriteProducts =  [FavoriteProduct]


class FavoriteViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, FavoriteProductTableViewCellDelegate {
    
    let viewModel = FavoriteViewModel()
    

    @IBOutlet weak var emptyState: UIViewFavoriteEmptyState!
    // FIX: -collection instead of Collecion
    @IBOutlet weak var favoriteProductsCollecionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteProductsCollecionView.delegate = self
        favoriteProductsCollecionView.dataSource = self
        
        HUD.dimsBackground = false
        HUD.allowsInteraction = false
        viewModel.updateUI()
        favoriteProductsState()
        deleteFavoriteProductState()
        updateEmptyState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.updateUI()
        updateEmptyState()
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
                    self.favoriteProductsCollecionView.reloadData()
                    self.updateEmptyState()
                }
            }
        })
    }
    
    fileprivate func updateEmptyState() {
        let shouldShowEmptyState = viewModel.shouldShowEmptyState()
        toggleEmptyState(shouldShow: shouldShowEmptyState)
    }
    
    func toggleEmptyState(shouldShow : Bool) {
        print(shouldShow, "FAA")
        favoriteProductsCollecionView.isHidden = shouldShow
        emptyState.isHidden = !shouldShow
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
                    PKHUD.sharedHUD.show()
                    PKHUD.sharedHUD.contentView = PKHUDSuccessView(title: "Deleted!", subtitle: nil)
                    PKHUD.sharedHUD.hide(afterDelay: 2.0)
                    self.updateEmptyState()
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
        let cell = favoriteProductsCollecionView.dequeueReusableCell(withReuseIdentifier: favoriteProdCell,for: indexPath) as! FavoriteProductCollectionViewCell
        
        print(indexPath.row)
        cell.configure(with: viewModel.favoriteProducts[indexPath.row])
        
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: navigateToProductDetailSegueIdentifier, sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == navigateToProductDetailSegueIdentifier{
            if let destinationNavigationController = segue.destination as? UINavigationController {
                
                if let targetController = destinationNavigationController.topViewController as? ProductDetailViewController{
                    let indexPath = sender as! IndexPath
                    targetController.productId = Int(viewModel.favoriteProducts[indexPath.row].id)
                }
            }
        }
    }
    
}


// MARK:-Delegated Method for Remove Button
extension FavoriteViewController {
    func favoriteProductCellDidTapRemove(_ sender: FavoriteProductCollectionViewCell) {
        guard let tappedIndexPath = favoriteProductsCollecionView.indexPath(for: sender) else { return }
        viewModel.removeProductFromFavorite(at: tappedIndexPath)
    }
}
