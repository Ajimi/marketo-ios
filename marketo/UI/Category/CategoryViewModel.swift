//
//  CategoryViewModel.swift
//  marketo
//
//  Created by Moncef Guettat on 1/3/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation

class CategoryViewModel: ViewModel {
    
    let loadCategoriesByPavilionUseCase : LoadCategoriesByPavilionUseCase = LoadCategoriesByPavilionUseCase()
    let loadTypesByCategoryUseCase : LoadTypesByCategoryUseCase = LoadTypesByCategoryUseCase()
    let loadMarksByTypeUseCase : LoadMarksByTypeUseCase = LoadMarksByTypeUseCase()
    
    var selectedPavilion : Pavilion? {
        didSet{
            loadCategoriesByPavilion()
        }
    }
    var selectedCategory : Category?{
        didSet{
            loadTypesByCategory()
        }
    }
    var selectedType : Type?{
        didSet{
            loadMarksByType()
        }
    }
    
    var categories : Categories = Categories()
    var types : Types = Types()
    var marks : Marks = Marks()
    
    var uiCategoriesState = Dynamic<UiState<Categories>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiTypesState = Dynamic<UiState<Types>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiMarksState = Dynamic<UiState<Marks>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    
    
    func updateUI(){
    }
    
    func loadCategoriesByPavilion() {
        self.uiCategoriesState.value = self.emitUiState(showProgress : true)
        loadCategoriesByPavilionUseCase.execute(pavilionId: String(describing: selectedPavilion!.id)) { (response) in
            switch response {
            case .success(let categories):
                self.categories = categories
                if categories.count > 0 {
                    self.selectedCategory = categories[0]
                    self.uiCategoriesState.value = self.emitUiState(showSuccess: Event(with: categories))
                } else {
                    //TODO: Display error state
                }
                
            case .failure(let error):
                self.uiCategoriesState.value = self.emitUiState(showError: Event(with: error.localizedDescription))
            }
        }
        
    }
    
    func loadTypesByCategory() {
        
        self.uiTypesState.value = self.emitUiState(showProgress : true)
        loadTypesByCategoryUseCase.execute(categoryId: String(describing:selectedCategory!.id)) { (response) in
            switch response {
            case .success(let types):
                self.types = types
                self.selectedType = types[0]
                self.uiTypesState.value = self.emitUiState( showSuccess: Event(with: types))
            case .failure(let error):
                self.uiTypesState.value = self.emitUiState( showError: Event(with: error.localizedDescription))
            }
        }
        
    }
    
    func loadMarksByType() {
        
        self.uiMarksState.value = self.emitUiState(showProgress : true)
        loadMarksByTypeUseCase.execute(typeId: String(describing: selectedType!.id) ){ (response) in
            switch response {
            case .success(let marks):
                self.marks = marks
                self.uiMarksState.value = self.emitUiState(showSuccess: Event(with: marks))
            case .failure(let error):
                self.uiMarksState.value = self.emitUiState(showError: Event(with: error.localizedDescription))
            }
        }
        
    }
    
    
}
