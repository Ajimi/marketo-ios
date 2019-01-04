//
//  CategoryViewController.swift
//  marketo
//
//  Created by Moncef Guettat on 12/1/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

private let pavilionReuseIdentifier = "PavilionCell"
private let navigateToCategorySegueIdentifier = "navigateToCategories"

class PavilionViewController: UIViewController {
    
    @IBOutlet weak var pavilionCollectionView : UICollectionView!
    
    let viewModel = PavilionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.updateUI()
        
        // Pavilion
        viewModel.uiPavilionsState.bindAndFire(listener: { (uiModel) in
            if (uiModel.showProgress) {
                print("In progress")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error \(errorMessage)")
            }
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let pavilionsResponse = showSucces.consume() {
                print(pavilionsResponse)
                DispatchQueue.main.async {
                    self.pavilionCollectionView.reloadData()
                }
            }
        })
    }
    

}

extension PavilionViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: navigateToCategorySegueIdentifier, sender: indexPath)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pavilions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = pavilionCollectionView.dequeueReusableCell(withReuseIdentifier: pavilionReuseIdentifier, for: indexPath) as! PavilionCollectionViewCell
        cell.configure(with: viewModel.pavilions[indexPath.item])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == navigateToCategorySegueIdentifier {
            if let destinationViewController = segue.destination as? CategoryViewController {
                let indexPath = sender as! IndexPath
                destinationViewController.pavilion = viewModel.pavilions[indexPath.item]
            }
        }
    }
    
}
