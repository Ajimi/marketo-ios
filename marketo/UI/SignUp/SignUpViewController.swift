//
//  SignUpViewController.swift
//  marketo
//
//  Created by Moncef Guettat on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet var signUpViewModel : SignUpViewModel!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confimPassword: UITextField!
    @IBOutlet weak var email: UITextField!
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fullName.delegate = self
        username.delegate = self
        password.delegate = self
        confimPassword.delegate = self
        email.delegate = self
        
        
        let alert = UIAlertController(title: nil, message: "Signin Up...", preferredStyle: .alert)
        signUpViewModel.uiState.bindAndFire(listener: { (uiModel) in
            if (uiModel.showProgress) {
                self.showWaiting(alert: alert)
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                alert.dismiss(animated: true, completion: {
                    self.showAlert(withTitle: "", withMessage: errorMessage)
                })
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let _ = showSucces.consume() {
                alert.dismiss(animated: true, completion: {
                    self.showAlert(withTitle: "User Created", withMessage: "User Created Successful")
                })
            }
        })
    }
    

    
    @IBAction func signUpCommand(_ sender: UIButton) {
        signUpViewModel.user = User(
            fullName: self.fullName.text!,
            username: self.username.text!,
            password: self.password.text!,
            email: self.email.text!,
            type: "local")
        signUpViewModel.confirmationPassword = self.confimPassword.text!
        signUpViewModel.register()
        
    }
}



// MARK: - User Creation Extension
extension SignUpViewController {
    func tryConnect() {
        signUpViewModel.register()
    }
}
