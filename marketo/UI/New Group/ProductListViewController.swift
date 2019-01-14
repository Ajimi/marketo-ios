//
//  ProductListViewController.swift
//  marketo
//
//  Created by Othmen on 12/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

private let productReuseIdentifier = "productCell"

class ProductListViewController: UITableViewController {
    
    private let viewModel : ProductListViewModel = ProductListViewModel()
    
    @IBOutlet weak var productsTableView : UITableView!
    
    var mark : Mark?
    var type : Type?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.updateUI()

        viewModel.uiProductsState.bindAndFire { (uiModel) in
            if (uiModel.showProgress){
                print("In progress product list")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error loading product list \(errorMessage)")
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let _ = showSucces.consume() {
                DispatchQueue.main.async {
                    self.productsTableView.reloadData()
                }
            }
        }
        
        launchLoadProducts()

    }
    
    func launchLoadProducts(){
        if let mark = self.mark , let type = self.type{
            viewModel.loadProductsByMarkAndType(mark: mark, type: type)
        }else if let mark = self.mark{
            viewModel.loadProductsByMark(mark: mark)
        }else if let type = self.type{
            viewModel.loadProductsByType(type: type)
        }
    }

}

extension ProductListViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsTableView.dequeueReusableCell(withIdentifier: productReuseIdentifier) as! ProductTableViewCell
        
        cell.configure(with: viewModel.products[indexPath.row])
        
        return cell
    }
    
}
