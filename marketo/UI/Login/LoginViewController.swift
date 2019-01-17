//
//  ViewController.swift
//  marketo
//
//  Created by selim ajimi on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import GoogleSignIn

class LoginViewController: UIViewController,GIDSignInUIDelegate  {

    @IBOutlet var loginViewModel : LoginViewModel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel.vc = self
        
        GIDSignIn.sharedInstance().uiDelegate=self

        
        let alert = UIAlertController(title: nil, message: "Connecting...", preferredStyle: .alert)
        loginViewModel.uiState.bindAndFire(listener: { (uiModel) in
            if (uiModel.showProgress) {
                DispatchQueue.main.async {
                    self.showWaiting(alert: alert)
                }
                // showProgression()
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                DispatchQueue.main.async {
                    alert.dismiss(animated: true, completion: {
                        self.showAlert(withTitle: "", withMessage: errorMessage)
                    })
                }
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let successMessage = showSucces.consume() {
                DispatchQueue.main.async {
                    alert.dismiss(animated: true, completion: {
                        print("Heeeeeeeeeeeeeeeeeeeee")
                        self.navigationController?.popViewController(animated: true)
                    })
                    alert.dismiss(animated: true, completion: nil)
                    self.navigationController?.popViewController(animated: true)
                    
                }
            }
        })
    }

    @IBAction func loginCommand(_ sender: UIButton) {
        loginViewModel.login(withUsername: username.text!, withPassword: password.text!)
    }
    
    @IBAction func loginFacebook(_ sender: UIButton){
        loginViewModel.loginFacebook()
    }
    
    @IBAction func loginGmail(_ sender: UIButton){
        loginViewModel.loginGoogle()
        print("hello")
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
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
