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
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginCommand(_ sender: UIButton) {
        loginViewModel.login(withUsername: username.text!, withPassword: password.text!)
    }
    
    @IBAction func navigateToSignUp(_ sender: UIButton) {
    
        performSegue(withIdentifier: "goToSignUp", sender: nil)
        
    }
    
    @IBAction func navigateToHome(_ sender: Any) {
        
        performSegue(withIdentifier: "goToHome", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
    }
}

