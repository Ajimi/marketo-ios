//
//  ProductDetailViewController.swift
//  marketo
//
//  Created by Moncef Guettat on 1/16/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import UIKit
import PKHUD

private let productDetailPricesHeaderReuseIdentifier = "productDetailPricesHeaderReuseIdentifier"

private let productDetailPricesCellReuseIdentifier = "productDetailPricesCellReuseIdentifier"

private let similarProductCellReuseIdentifier = "similarProductCellReuseIdentifier"

class ProductDetailViewController: UIViewController {
    
    private let viewModel : ProductDetailViewModel = ProductDetailViewModel()
    @IBOutlet weak var pricesTableView: UITableView!
    @IBOutlet weak var similarProductsColectionView: UICollectionView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productMarl: UILabel!
    @IBOutlet weak var productBestPrice: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productImage: UIImageView!
    
    var product : Product?{
        didSet{
            viewModel.product = product
        }
    }

    var productId : Int? {
        didSet{
            viewModel.loadProduct(id: productId!)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initiateView()
        
        viewModel.updateUi()
        
        viewModel.uiSimilarProductsState.bindAndFire { (uiModel) in
            if (uiModel.showProgress){
                HUD.show(.progress)
            } else {
                HUD.hide()
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error loading similar product \(errorMessage)")
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let _ = showSucces.consume() {
                print("c bon")
                DispatchQueue.main.async {
                    self.similarProductsColectionView.reloadData()
                }
            }
        }
        
        viewModel.uiProductState.bindAndFire { (uiModel) in
            if (uiModel.showProgress){
                HUD.show(.progress)
            } else {
                HUD.hide()
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error loading similar product \(errorMessage)")
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let prod = showSucces.consume() {
                DispatchQueue.main.async {
                    self.product = prod
                    self.initiateView()
                    self.pricesTableView.reloadData()
                    self.similarProductsColectionView.reloadData()
                }
            }
        }
        
        viewModel.uiMessageState.bindAndFire(listener: { (uiModel) in
            if (uiModel.showProgress) {
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error message product detail \(errorMessage)")
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
        
    }
    
    private func initiateView() {
        if let prod = product{
            productName.text = prod.name
            productMarl.text = prod.mark?.name
            productBestPrice.text = "$ " + (prod.prices?.min(by: { (price1, price2) -> Bool in
                return price1.value < price2.value
            })?.value.description)!
            productImage.kf.setImage(
                with: URL(string: prod.image!),
                placeholder: UIImage(named: "logo"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            productDescription.text = prod.description
        }
    }
    
    @IBAction func dimissDetail(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func addToFavorite(_ sender: Any) {
        
        viewModel.toggletProductFavorite()

    }
    
    @IBAction func addToBasket(_ sender: Any) {
        
        viewModel.toggleProductBasket()

        
    }
}

extension ProductDetailViewController: UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.similarProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: similarProductCellReuseIdentifier, for: indexPath) as! ProductDetailSimilarProductCollectionViewCell
        
        cell.configure(with: viewModel.similarProducts[indexPath.row])
        
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.product = viewModel.similarProducts[indexPath.item]
        pricesTableView.reloadData()
        self.initiateView()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard product != nil else {
            return 1
        }
        return product!.prices!.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: productDetailPricesHeaderReuseIdentifier) as! UITableViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: productDetailPricesCellReuseIdentifier) as! ProductDetailPriceTableViewCell
            
            cell.configure(with: (product?.prices![indexPath.row-1])!)
            
            return cell
        }
        
        
    }
    
    
    
    
}
