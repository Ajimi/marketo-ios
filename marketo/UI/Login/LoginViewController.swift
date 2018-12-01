//
//  ViewController.swift
//  marketo
//
//  Created by selim ajimi on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var loginViewModel : LoginViewModel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alert = UIAlertController(title: nil, message: "Connecting...", preferredStyle: .alert)
        loginViewModel.uiState.bindAndFire(listener: { (uiModel) in
            if (uiModel.showProgress) {
                self.showWaiting(alert: alert)
                // showProgression()
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                alert.dismiss(animated: true, completion: {
                    self.showAlert(withTitle: "", withMessage: errorMessage)
                })
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let successMessage = showSucces.consume() {
                alert.dismiss(animated: true, completion: {
                    self.showAlert(withTitle: "Conncted", withMessage: successMessage)
                })
            }
        })
    }

    @IBAction func loginCommand(_ sender: UIButton) {
        loginViewModel.login(withUsername: username.text!, withPassword: password.text!)
    }
    
    @IBAction func navigateToSignUp(_ sender: UIButton) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
    }
}

extension LoginViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        resignFirstResponder()
    }
}

extension LoginViewController {
    func displayErrorMessage(errorMessage: String) {
        let alertController = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
