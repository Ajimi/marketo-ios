//
//  SignUpViewController.swift
//  marketo
//
//  Created by Moncef Guettat on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

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
            self.present(
                createAlert(withTitle: "Done!", withMessage: "Sing Up Complete")!,
                animated: true,
                completion: nil)
        }else
        {
            self.present(
                createAlert(withTitle: "Invalid Entries", withMessage: signUpViewModel.prepareMessage())!,
                animated: true,
                completion: nil)
        }
        
        
        
    }
    
    func createAlert(withTitle title : String, withMessage message : String) -> UIAlertController?  {
        let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        
        let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(action)
        
        return alert
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
