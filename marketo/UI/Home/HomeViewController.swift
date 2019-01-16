//
//  HomeViewController.swift
//  marketo
//
//  Created by Moncef Guettat on 11/11/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import GoogleSignIn

class HomeViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var loginButton : UIButton!
    @IBOutlet weak var logoutButton : UIButton!
    
    let viewModel = HomeViewModel()
    
    fileprivate func checkLoggedInUser() {
        if viewModel.isLoggedIn() {
            loginButton.isHidden = true
            logoutButton.isHidden = false
        }else{
            loginButton.isHidden = false
            logoutButton.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImage.roundedImage()
        checkLoggedInUser()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        checkLoggedInUser()
        
        // Do any additional setup after loading the view.
        let alert = UIAlertController(title: "", message: "Logging Out", preferredStyle: .alert)
        viewModel.uiLogoutState.bindAndFire(listener: { (uiModel) in
            if (uiModel.showProgress) {
                self.showWaiting(alert: alert)
            }
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let successMessage = showSucces.consume() {
                alert.dismiss(animated: true, completion: nil)
                DispatchQueue.main.async {
                    self.checkLoggedInUser()
                }
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func grabACartAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "CommandStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainTabViewController") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func SignOut(_ sender : UIButton){
        viewModel.logout()
        if let accesstoken = FacebookCore.AccessToken.current{
            let loginManager = LoginManager()
            loginManager.logOut()
        }
        if let currentUser = GIDSignIn.sharedInstance()?.currentUser {
            GIDSignIn.sharedInstance()?.signOut()
        }
    }
    
    @IBAction func navigateToSignNn(_ sender: UIButton) {
            
    }


}
