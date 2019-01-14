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
    @IBOutlet weak var button : UIButton!
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        btn.addTarget(self, action: #selector(clicked), for: .touchUpInside)
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
    
    @objc func clicked()  {
        let vc = DemoTableViewController()
        self.present(vc, animated: true, completion: nil)
    }

 

}
