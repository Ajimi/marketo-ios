//
//  SignUpViewModel.swift
//  marketo
//
//  Created by Moncef Guettat on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class SignUpViewModel: NSObject {
    
    var user : User?;
    
    func signUp(withConfirmationPassword password : String) -> UIAlertController? {
        
        let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        
        let alert =  UIAlertController(title: "Password Incorrect", message: "verify your password", preferredStyle: .alert)
        
        alert.addAction(action)
        
        return alert
        
    }
    
    
    func checkPassword(password : String) -> UIAlertController? {
        
        var alert : UIAlertController?;
        
        if (password == user?.password)
        {
            alert = createAlert(withTitle : "Done !", withMessage : "Sign Up Complete")
        }
        else
        {
            alert = createAlert(withTitle : "Password Incorrect", withMessage : "verify your password")
        }
        return alert!
    }
    
    func createAlert(withTitle title : String, withMessage message : String) -> UIAlertController?  {
        let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        
        let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(action)
        
        return alert
    }

}
