//
//  CategoryViewModel.swift
//  marketo
//
//  Created by Moncef Guettat on 12/1/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

class PavilionViewModel: ViewModel {
    
    let loadPavilionUseCase:LoadPavilionUseCase = LoadPavilionUseCase()
    
    var pavilions:Pavilions = Pavilions()
    
    var uiPavilionsState =  Dynamic<UiState<Pavilions>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    
    func updateUI(){
        loadAllPavilions()
    }
    
    func loadAllPavilions() {
        
        self.uiPavilionsState.value = self.emitUiState(showProgress: true)
        loadPavilionUseCase.execute { (response) in
            switch response {
            case .success(let pavilions):
                self.pavilions = pavilions
                self.uiPavilionsState.value = self.emitUiState(showSuccess: Event(with: pavilions))
            case .failure(let error):
                self.uiPavilionsState.value = self.emitUiState(showProgress: false, showError: Event(with: error.localizedDescription))
            }
        }
    }
}
