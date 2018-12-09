//
//  FeaturedViewController.swift
//  marketo
//
//  Created by Moncef Guettat on 11/25/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit


private let pavilionHomeReuseIdentifier = "PavilionHomeCell"

private let productHomeTrendingReuseIdentifier = "ProductTrendingHomeCell"

private let productHomeDiscountedReuseIdentifier = "ProductDiscountedHomeCell"


class FeaturedViewController: UIViewController, UICollectionViewDataSource , TrendingProductCollectionViewCellDelegate {
    
    
    @IBOutlet weak var pavilionsCollectionView: UICollectionView!
    
    @IBOutlet weak var trendingProductCollectionView: UICollectionView!
    
    @IBOutlet weak var discountedProductCollectionView: UICollectionView!
    
    let viewModel = FeaturedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.updateUI()
        
        // Trending PRODUCTS
        viewModel.uiTrendingState.bindAndFire(listener: { (uiModel) in
            if (uiModel.showProgress) {
                print("In progress")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error \(errorMessage)")
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let productsResponse = showSucces.consume() {
                print(productsResponse)
                DispatchQueue.main.async {
                    self.trendingProductCollectionView.reloadData()
                }
            }
        })
        
        // Discounted PRODUCTS
        viewModel.uiDiscountedState.bindAndFire(listener: { (uiModel) in
            if (uiModel.showProgress) {
                print("In progress")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error \(errorMessage)")
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let productsResponse = showSucces.consume() {
                print(productsResponse)
                DispatchQueue.main.async {
                    self.discountedProductCollectionView.reloadData()
                }
            }
        })
        
        // Pavilion
        viewModel.uiPavilionsState.bindAndFire(listener: { (uiModel) in
            if (uiModel.showProgress) {
                print("In progress")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error \(errorMessage)")
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let pavilionsResponse = showSucces.consume() {
                print("hhhhhhhh")
                print(pavilionsResponse)
                DispatchQueue.main.async {
                    self.pavilionsCollectionView.reloadData()
                }
            }
        })
    }

}

extension FeaturedViewController{
    
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.pavilionsCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pavilionHomeReuseIdentifier, for: indexPath) as! PavilionHomeCollectionViewCell
            
            cell.configure(with: viewModel.pavilions[indexPath.item])
            
            return cell;
        }
        else if (collectionView == self.trendingProductCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productHomeTrendingReuseIdentifier, for: indexPath) as! TrendingProductCollectionViewCell
            
            cell.configure(with: viewModel.trendingProducts[indexPath.item])
            
            return cell;
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productHomeDiscountedReuseIdentifier, for: indexPath) as! DiscountedProductCollectionViewCell
            
            cell.configure(with: viewModel.discountedProducts[indexPath.item])
            
            return cell;
        }
    }

    func trendingCellDidTapFavorite(_ sender: TrendingProductCollectionViewCell) {
        guard let tappedIndexPath = trendingProductCollectionView.indexPath(for: sender) else { return }
        viewModel.addTrendingProductToFavorite(at: tappedIndexPath)
    }
    
    func trendingCellDidTapBasket(_ sender: TrendingProductCollectionViewCell) {
        guard let tappedIndexPath = trendingProductCollectionView.indexPath(for: sender) else { return }
        viewModel.addTrendingProductToBasket(at: tappedIndexPath)
    }
}



