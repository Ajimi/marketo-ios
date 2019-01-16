//
//  MoreViewModel.swift
//  marketo
//
//  Created by Admin on 1/16/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation

class MoreViewModel: ViewModel {
    
    
    // Use cases
    let loggedInUserUseCase = LoggedInUserUseCase()
    
    // uiState
    var uiUserState = Dynamic<UiState<User>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    // Actions
    var disconnectAction = Dynamic<Event<Bool>?>(nil)
    var navigateToSignInAction = Dynamic<Event<Bool>?>(nil)
    var navigateToFavoriteAction = Dynamic<Event<Bool>?>(nil)
    
    
    func updateUI() {
       loadLoggedInUser()
    }
    
    private func loadLoggedInUser(){
        uiUserState.value = emitUiState(showProgress:true)
        if let user = loggedInUserUseCase.execute(){
            uiUserState.value = emitUiState(showSuccess: Event(with: user))
        } else {
            uiUserState.value = emitUiState(showError: Event(with: "User offline"))
        }
    }
}
