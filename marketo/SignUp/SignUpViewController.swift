//
//  SignUpViewController.swift
//  marketo
//
//  Created by Moncef Guettat on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    
    @IBOutlet var signUpViewModel : SignUpViewModel!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confimPassword: UITextField!
    @IBOutlet weak var email: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
   
    
    @IBAction func signUpCommand(_ sender: UIButton) {
        
        signUpViewModel.user = User(
            fullName: self.fullName.text!,
            username: self.username.text!,
            password: self.password.text!,
            email: self.email.text!)
        signUpViewModel.confirmationPassword = self.confimPassword.text!
        
        if (self.signUpViewModel.isValid){
            tryConnect();
        } else {
            showAlert(withTitle: "Invalid Entries", withMessage: signUpViewModel.prepareMessage())
        }
    }
}



// MARK: - User Creation Extension
extension SignUpViewController {
    func tryConnect() {
        signUpViewModel.register(completion: { (result) in
            self.checkResponseFor(response: result as! Result<Any>)
        })
    }
    
    func checkResponseFor(response : Result<Any>) {
        switch response {
        case .success(let user):
            self.showAlert(withTitle: "Done!", withMessage :"SignUp Complete")
            print(user)
        // TODO: - Check Errors 
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

// MARK: - Alert Extensions
extension SignUpViewController {
    fileprivate func showAlert(withTitle: String, withMessage: String) {
        self.present(
            createAlert(withTitle: withTitle, withMessage: withMessage)!,
            animated: true,
            completion: nil)
    }
    
    func createAlert(withTitle title : String, withMessage message : String) -> UIAlertController?  {
        let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(action)
        
        return alert
    }
}
