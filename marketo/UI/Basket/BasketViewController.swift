//
//  BasketViewController.swift
//  marketo
//
//  Created by Moncef Guettat on 12/8/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit
import PKHUD
import Alamofire

private let numberOfBasketProductReuseIdentifier = "numberOfBasketProductsCell"
private let basketProductReuseIdentifier = "basketProductCell"
private let checkoutButtonReuseIdentifier = "checkoutButtonCell"

private let navigateToStatisticsSegueIdentifier = "showStatistics"
private let navigateToProductDetailSegueIdentifier = "navigateToProductDetail"


class BasketViewController: UITableViewController, BasketProducTableViewCellDelegate , CheckoutTableViewCellDelegate{
    @IBOutlet weak var basketTableView : UITableView!
    
    let viewModel = BasketViewModel()
    
    let firstRowIndexPath = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basketTableView.dataSource = self
        basketTableView.delegate = self
        
        HUD.dimsBackground = false
        HUD.allowsInteraction = false
        viewModel.updateUI()
        basketProductsState()
        deleteProductState()
        
        
        basketTableView.estimatedRowHeight = basketTableView.rowHeight
        basketTableView.rowHeight = UITableView.automaticDimension
        basketTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.updateUI()
        basketTableView.reloadData()

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
                    if (self.viewModel.products.count == 0){
                        self.basketTableView.reloadData()
                    }else{
                        self.basketTableView.deleteRows(at: [indexPath], with: .fade)
                    }
                    self.basketTableView.reloadRows(at: [self.firstRowIndexPath], with: .fade)
                    
                    PKHUD.sharedHUD.show()
                    PKHUD.sharedHUD.contentView = PKHUDSuccessView(title: "Deleted!", subtitle: nil)
                    PKHUD.sharedHUD.hide(afterDelay: 2.0)
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
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let _ = showSucces.consume() {
                DispatchQueue.main.async {
                    self.basketTableView.reloadData()
                }
            }
        }
    }
    

}



extension BasketViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard viewModel.products.count != 0 else {
            return 1
        }
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
            let cell = tableView.dequeueReusableCell(withIdentifier: checkoutButtonReuseIdentifier, for: indexPath) as! CheckoutTableViewCell
            cell.delegate = self
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: basketProductReuseIdentifier, for: indexPath) as! BasketProductTableViewCell
            
            cell.configure(with: viewModel.products[indexPath.row-1])
            cell.delegate = self
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 && indexPath.row != viewModel.products.count + 1 {
            performSegue(withIdentifier: navigateToProductDetailSegueIdentifier, sender: indexPath)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == navigateToProductDetailSegueIdentifier{
            if let destinationNavigationController = segue.destination as? UINavigationController {
                
                if let targetController = destinationNavigationController.topViewController as? ProductDetailViewController{
                    let indexPath = sender as! IndexPath
                    targetController.productId = Int(viewModel.products[indexPath.row-1].productId)
                }
            }
        }
    }
    
    func basketCellDidTapStepper(_ sender: BasketProductTableViewCell, _ value: Int) {
        guard let tappedIndexPath = basketTableView.indexPath(for: sender) else { return }
        viewModel.modifyQuantity(at: tappedIndexPath, with: value)
    }
    
    func basketCellDidTapRemove(_ sender: BasketProductTableViewCell) {
        guard let tappedIndexPath = basketTableView.indexPath(for: sender) else { return }
        viewModel.deleteProductFromBasket(at: tappedIndexPath)
    }
    
    
    // CheckoutButton
    func checkoutCellDidTapButton(_ sender: CheckoutTableViewCell) {
        // perform segue ya M3alem hhh
        performSegue(withIdentifier: navigateToStatisticsSegueIdentifier, sender: nil)
        
    }
    

    
    
}
