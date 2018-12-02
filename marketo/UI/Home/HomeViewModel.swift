//
//  HomeViewModel.swift
//  marketo
//
//  Created by Moncef Guettat on 12/2/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

class HomeViewModel : ViewModel {
    
    let isLoggedInUseCase : IsLoggedInUseCase = IsLoggedInUseCase()
    let logoutUseCase : LogoutUseCase = LogoutUseCase()
    
    var uiLogoutState = Dynamic<UiState<Bool>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    
    func isLoggedIn() -> Bool {
        return isLoggedInUseCase.execute()
    }
    
    func logout() {
        self.uiLogoutState.value = self.emitUiState(showProgress: true)
        let result = logoutUseCase.execute()
        self.uiLogoutState.value = self.emitUiState(showSuccess: Event(with: result))
        
    }
    
}
