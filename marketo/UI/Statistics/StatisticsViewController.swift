//
//  StatisticsViewController.swift
//  marketo
//
//  Created by Admin on 1/14/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {

    private let viewModel : StatisticsViewModel = StatisticsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.updateUI()

        viewModel.uiState.bindAndFire { (uiModel) in
            if (uiModel.showProgress){
                print("In progress stat")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error loading stat \(errorMessage)")
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let mes = showSucces.consume() {
                DispatchQueue.main.async {
                    print(mes)
                }
            }
        }
        
        
    }
    

 

}
