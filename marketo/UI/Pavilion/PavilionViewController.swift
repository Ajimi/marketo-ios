//
//  CategoryViewController.swift
//  marketo
//
//  Created by Moncef Guettat on 12/1/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

private let pavilionReuseIdentifier = "PavilionCell"

class PavilionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
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
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let productsResponse = showSucces.consume() {
                print(productsResponse)
                self.pavilionCollectionView.reloadData()
            }
        })
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pavilions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = pavilionCollectionView.dequeueReusableCell(withReuseIdentifier: pavilionReuseIdentifier, for: indexPath) as! PavilionCollectionViewCell
        cell.configure(with: pavilions[indexPath.row])
        return cell
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
