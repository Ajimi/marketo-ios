//
//  FeaturedViewController.swift
//  marketo
//
//  Created by Moncef Guettat on 11/25/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit


private let categoryHomeReuseIdentifier = "CategoryHomeCell"

private let productHomeTrendingReuseIdentifier = "ProductTrendingHomeCell"

class FeaturedViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    @IBOutlet weak var trendingProductCollectionView: UICollectionView!
    
    let viewModel = FeaturedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.updateUI()
        
        
        // ALL PRODUCTS
        viewModel.uiProductState.bindAndFire(listener: { (uiModel) in
            if (uiModel.showProgress) {
                print("In progress")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error \(errorMessage)")
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let productsResponse = showSucces.consume() {
                print(productsResponse)
            }
        })
        
        // ALL PRODUCTS
        viewModel.uiTrendingState.bindAndFire(listener: { (uiModel) in
            if (uiModel.showProgress) {
                print("In progress")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error \(errorMessage)")
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let productsResponse = showSucces.consume() {
                print(productsResponse)
            }
        })
        
        // ALL PRODUCTS
        viewModel.uiDiscountedState.bindAndFire(listener: { (uiModel) in
            if (uiModel.showProgress) {
                print("In progress")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error \(errorMessage)")
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let productsResponse = showSucces.consume() {
                print(productsResponse)
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.categoriesCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryHomeReuseIdentifier, for: indexPath) as! CategoryHomeCollectionViewCell
            return cell;
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productHomeTrendingReuseIdentifier, for: indexPath) as! TrendingProductCollectionViewCell
            
            return cell;
        }
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
