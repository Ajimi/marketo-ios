//
//  BasketViewController.swift
//  marketo
//
//  Created by Moncef Guettat on 12/8/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

private let numberOfBasketProductReuseIdentifier = "numberOfBasketProductsItemsCell"
private let basketProductReuseIdentifier = "basketProductCell"
private let checkoutButtonReuseIdentifier = "checkoutButtonCell"

class BasketViewController: UITableViewController, BasketProducTableViewCellDelegate {
    @IBOutlet weak var basketTableView : UITableView!
    
    let viewModel = BasketViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basketTableView.dataSource = self
        basketTableView.delegate = self
        
        viewModel.updateUI()
        basketProductsState()
        deleteProductState()
        
        
        self.tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    
    fileprivate func basketProductsState() {
        // Pavilion
        viewModel.uiBasketProductsState.bindAndFire(listener: { (uiModel) in
            if (uiModel.showProgress) {
                print("In progress")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error \(errorMessage)")
            }
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let _ = showSucces.consume() {
                DispatchQueue.main.async {
                    self.basketTableView.reloadData()
                }
            }
        })
    }
    
    
    fileprivate func deleteProductState() {
        viewModel.uiDeleteProductState.bindAndFire { uiModel in
            if (uiModel.showProgress) {
                print("In progress")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error \(errorMessage)")
            }
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let indexPath = showSucces.consume() {
                DispatchQueue.main.async {
                    self.basketTableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
    
    fileprivate func truncateProductState() {
        viewModel.uiTruncateBasketState.bindAndFire { uiModel in
            if (uiModel.showProgress) {
                print("In progress")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error \(errorMessage)")
            }
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let indexPath = showSucces.consume() {
                DispatchQueue.main.async {
                    self.basketTableView.reloadData()   
                }
            }
        }
    }
    
    func basketCellDidTapStepper(_ sender: BasketProductTableViewCell, _ value: Int) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        viewModel.modifyQuantity(at: tappedIndexPath, with: value)
    }
    
    func basketCellDidTapRemove(_ sender: BasketProductTableViewCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        viewModel.deleteProductFromBasket(at: tappedIndexPath)
    }
}



extension BasketViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.products.count + 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard viewModel.products.count != 0 else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: numberOfBasketProductReuseIdentifier, for: indexPath) as! NumberOfBasketProductsTableViewCell
            
            cell.configure(with: viewModel.numberOfItem())
            
            return cell
            
        }
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: numberOfBasketProductReuseIdentifier, for: indexPath) as! NumberOfBasketProductsTableViewCell
            
            cell.configure(with: viewModel.numberOfItem())
            
            return cell
            
        } else if indexPath.row == viewModel.products.count + 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: checkoutButtonReuseIdentifier, for: indexPath)
            // Todo add delegate
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: basketProductReuseIdentifier, for: indexPath) as! BasketProductTableViewCell
            
            cell.configure(with: viewModel.products[indexPath.row])
            cell.delegate = self
            
            return cell
        }
    }
    
}
