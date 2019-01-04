//
//  CategoryViewController.swift
//  marketo
//
//  Created by Othmen on 12/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

private let markReuseIdentifier = "markCell"
private let typeReuseIdentifier = "typeCell"
private let categoryReuseIdentifier = "categoryCell"


class CategoryViewController: UIViewController {
    
    private let viewModel : CategoryViewModel = CategoryViewModel()
    
    @IBOutlet weak var categoriesCollectionView : UICollectionView!
    @IBOutlet weak var typesCollectionView : UICollectionView!
    @IBOutlet weak var marksTableView : UITableView!
    
    var pavilion : Pavilion?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.selectedPavilion = pavilion
        
        viewModel.updateUI()
        
        //Categories
        viewModel.uiCategoriesState.bindAndFire { (uiModel) in
            if (uiModel.showProgress){
                print("In progress categories")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error loading categories \(errorMessage)")
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let _ = showSucces.consume() {
                DispatchQueue.main.async {
                    self.categoriesCollectionView.reloadData()
                }
            }
        }
        
        //Types
        viewModel.uiTypesState.bindAndFire { (uiModel) in
            if (uiModel.showProgress){
                print("In progress types")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error loading types \(errorMessage)")
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let _ = showSucces.consume() {
                DispatchQueue.main.async {
                    self.typesCollectionView.reloadData()
                }
            }
        }
        
        //Marks
        viewModel.uiMarksState.bindAndFire { (uiModel) in
            if (uiModel.showProgress){
                print("In progress marks")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error loading marks \(errorMessage)")
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let _ = showSucces.consume() {
                DispatchQueue.main.async {
                    self.typesCollectionView.reloadData()
                }
            }
        }
        
    }
    

}

extension CategoryViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.marks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = marksTableView.dequeueReusableCell(withIdentifier: markReuseIdentifier) as! MarkTableViewCell
        cell.configure(with: viewModel.marks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showProducts", sender: nil)
    }
    
}

extension CategoryViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.categoriesCollectionView {
            return viewModel.categories.count
        }else{
            return viewModel.types.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellule : UICollectionViewCell
        if collectionView == self.categoriesCollectionView {
            let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: categoryReuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
            cell.configure(with: viewModel.categories[indexPath.item])
            cellule = cell
        }else{
            let cell = typesCollectionView.dequeueReusableCell(withReuseIdentifier: typeReuseIdentifier, for: indexPath) as! TypeCollectionViewCell
            cell.configure(with: viewModel.types[indexPath.item])
            cellule = cell
        }
        return cellule
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.categoriesCollectionView {
            viewModel.selectedCategory = viewModel.categories[indexPath.item]
        }else{
            viewModel.selectedType = viewModel.types[indexPath.item]
        }
    }
}
