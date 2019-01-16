//
//  MoreViewController.swift
//  marketo
//
//  Created by Admin on 1/16/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {

    let viewModel = MoreViewModel()
    var isUserLoggedIn = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.uiUserState.bindAndFire { (uiModel) in
            if (uiModel.showProgress){
                print("In progress stat")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                self.isUserLoggedIn = false
                print("there Was an error loading stat \(errorMessage)")
                // TODO user is not connected
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let _ = showSucces.consume() {
                // TODO user is connected display change
                self.isUserLoggedIn = true
            }
        }
    }
    
}
