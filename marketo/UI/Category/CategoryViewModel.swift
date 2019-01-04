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
        loadCategoriesByPavilionUseCase.execute(pavilion: selectedPavilion!) { (response) in
            switch response {
            case .success(let categories):
                self.categories = categories
                self.selectedCategory = categories[0]
                self.uiCategoriesState.value = self.emitUiState(showProgress: false, showSuccess: Event(with: categories))
            case .failure(let error):
                self.uiCategoriesState.value = self.emitUiState(showProgress: false, showError: Event(with: error.localizedDescription))
            }
        }
        
    }
    
    func loadTypesByCategory() {
        
        self.uiTypesState.value = self.emitUiState(showProgress : true)
        loadTypesByCategoryUseCase.execute(category: selectedCategory!) { (response) in
            switch response {
            case .success(let types):
                self.types = types
                self.selectedType = types[0]
                self.uiTypesState.value = self.emitUiState(showProgress: false, showSuccess: Event(with: types))
            case .failure(let error):
                self.uiTypesState.value = self.emitUiState(showProgress: false, showError: Event(with: error.localizedDescription))
            }
        }
        
    }
    
    func loadMarksByType() {
        
        self.uiMarksState.value = self.emitUiState(showProgress : true)
        loadMarksByTypeUseCase.execute(type: selectedType!) { (response) in
            switch response {
            case .success(let marks):
                self.marks = marks
                self.uiMarksState.value = self.emitUiState(showProgress: false, showSuccess: Event(with: marks))
            case .failure(let error):
                self.uiMarksState.value = self.emitUiState(showProgress: false, showError: Event(with: error.localizedDescription))
            }
        }
        
    }
    
    
}
