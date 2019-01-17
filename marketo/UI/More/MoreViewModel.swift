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
    
    var feedbackAction = Dynamic<Event<Bool>?>(nil)
    var disconnectAction = Dynamic<Event<Bool>?>(nil)
    var changePasswordAction = Dynamic<Event<Bool>?>(nil)
    var navigateToSignInAction = Dynamic<Event<Bool>?>(nil)
    var navigateToFavoriteAction = Dynamic<Event<Bool>?>(nil)
    
    //
    var user:User?
    
    func updateUI() {
       loadLoggedInUser()
    }
    
    private func loadLoggedInUser(){
        uiUserState.value = emitUiState(showProgress:true)
        if let user = loggedInUserUseCase.execute(){
            self.user = user
            print("online")
            uiUserState.value = emitUiState(showSuccess: Event(with: user))
        } else {
            print("Offline ")
            uiUserState.value = emitUiState(showError: Event(with: "User offline"))
        }
    }
    
    func checkTapAction(with type: CellType){
        switch type {
        case .favorite:
            self.navigateToFavoriteAction.value = Event(with: true)
            break
        case .disconnect:
            self.disconnectAction.value = Event(with: true)
            break
        // TODO logoout and perform segue
        case .password:
            self.changePasswordAction.value = Event(with: true)
            break
        // Display alert and change password
        case .feedback:
            self.feedbackAction.value = Event(with: true)
            break
        case .signin:
            self.navigateToSignInAction.value = Event(with: true)
            break
        default :
            return
        }
    }
    
    func logout() {
        let logoutUseCase = LogoutUseCase()
        let result = logoutUseCase.execute()
    }
}
