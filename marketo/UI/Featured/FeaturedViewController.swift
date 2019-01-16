//
//  FeaturedViewController.swift
//  marketo
//
//  Created by Moncef Guettat on 11/25/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit
import PKHUD
import SkeletonView

private let pavilionHomeReuseIdentifier = "PavilionHomeCell"

private let productHomeTrendingReuseIdentifier = "ProductTrendingHomeCell"

private let productHomeDiscountedReuseIdentifier = "ProductDiscountedHomeCell"

private let navigateToCategorySegueIdentifier = "navigateToCategory"


class FeaturedViewController: UIViewController {
    
    
    @IBOutlet weak var pavilionsCollectionView: UICollectionView!
    
    @IBOutlet weak var trendingProductCollectionView: UICollectionView!
    
    @IBOutlet weak var discountedProductCollectionView: UICollectionView!
    
  
    let viewModel = FeaturedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HUD.dimsBackground = false
        HUD.allowsInteraction = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.updateUI()
        
        // Trending PRODUCTS
        viewModel.uiTrendingState.bindAndFire(listener: { (uiModel) in
            if (uiModel.showProgress) {
                print("trending Showing skeleton")
                // self.trendingProductCollectionView.showSkeleton()
            } else {
                print("trending hiding skeleton")
                 // self.trendingProductCollectionView.hideSkeleton()
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error \(errorMessage)")
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let productsResponse = showSucces.consume() {
                //print(productsResponse)
                DispatchQueue.main.async {
                    self.trendingProductCollectionView.reloadData()
                }
            }
        })
        
        // Discounted PRODUCTS
        viewModel.uiDiscountedState.bindAndFire(listener: { (uiModel) in
            if (uiModel.showProgress) {
                
                // self.discountedProductCollectionView.showSkeleton(usingColor: UIColor.greenSea)
            }else {
//                self.discountedProductCollectionView.hideSkeleton()
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error \(errorMessage)")
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let productsResponse = showSucces.consume() {
                //print(productsResponse)
                DispatchQueue.main.async {
                    self.discountedProductCollectionView.reloadData()
                }
            }
        })
        
        
        // Pavilion
        viewModel.uiPavilionsState.bindAndFire(listener: { (uiModel) in
            if (uiModel.showProgress) {
                print("In progress")
//                self.pavilionsCollectionView.showSkeleton()
            }else {
//                self.pavilionsCollectionView.hideSkeleton()
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error \(errorMessage)")
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let pavilionsResponse = showSucces.consume() {

                DispatchQueue.main.async {
                    self.pavilionsCollectionView.reloadData()
                }
            }
        })
        
        viewModel.uiMessageState.bindAndFire(listener: { (uiModel) in
            if (uiModel.showProgress) {
                print("In progress")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error \(errorMessage)")
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let messageResponse = showSucces.consume() {
                //print(productsResponse)
                DispatchQueue.main.async {
                    PKHUD.sharedHUD.show()
                    PKHUD.sharedHUD.contentView = PKHUDSuccessView(title: "Success!", subtitle: messageResponse)
                    PKHUD.sharedHUD.hide(afterDelay: 2.0)
                }
            }
        })
        
        viewModel.uiLoadingState.bindAndFire(listener: { (uiModel) in
            if (uiModel.showProgress) {
                print("In progress")
                HUD.show(.progress)
            } else {
                 HUD.flash(.success, delay: 1.0)
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error \(errorMessage)")
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let messageResponse = showSucces.consume() {
                //print(productsResponse)
    
            }
        })
        
    }

}

//extension FeaturedViewController : UICollectionViewDataSource,UICollectionViewDelegate
//}


extension FeaturedViewController:UICollectionViewDataSource,UICollectionViewDelegate,TrendingProductCollectionViewCellDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.pavilionsCollectionView){
            return viewModel.pavilions.count
        }
        else if (collectionView == self.trendingProductCollectionView){
            return viewModel.trendingProducts.count
        }
        else{
            return viewModel.discountedProducts.count
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("dkhal")
        switch collectionView {
        case self.pavilionsCollectionView:
            print("1")
            performSegue(withIdentifier: navigateToCategorySegueIdentifier, sender: indexPath)
        case self.trendingProductCollectionView:
            print("2")
            return
        case self.discountedProductCollectionView:
            print("3")
            return
        default:
            print("all")
            return
        }
    }
    
    func trendingCellDidTapFavorite(_ sender: TrendingProductCollectionViewCell) {
        guard let tappedIndexPath = trendingProductCollectionView.indexPath(for: sender) else { return }
        viewModel.toggleTrendingProductFavorite(at: tappedIndexPath)
    }
    
    func trendingCellDidTapBasket(_ sender: TrendingProductCollectionViewCell) {
        guard let tappedIndexPath = trendingProductCollectionView.indexPath(for: sender) else { return }
        viewModel.toggleTrendingProductBasket(at: tappedIndexPath)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == navigateToCategorySegueIdentifier{
            if let destinationViewController = segue.destination as? CategoryViewController{
                let indexPath = sender as! IndexPath
                destinationViewController.pavilion = viewModel.pavilions[indexPath.item]
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.pavilionsCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pavilionHomeReuseIdentifier, for: indexPath) as! PavilionHomeCollectionViewCell
            
            cell.configure(with: viewModel.pavilions[indexPath.item])
            return cell;
        }
        else if (collectionView == self.trendingProductCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productHomeTrendingReuseIdentifier, for: indexPath) as! TrendingProductCollectionViewCell
            
            cell.configure(with: viewModel.trendingProducts[indexPath.item])
            cell.delegate = self
            return cell;
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productHomeDiscountedReuseIdentifier, for: indexPath) as! DiscountedProductCollectionViewCell
            cell.configure(with: viewModel.discountedProducts[indexPath.item])
            
            return cell;
        }
    }
    
    
}
