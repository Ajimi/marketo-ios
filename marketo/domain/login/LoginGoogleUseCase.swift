//
//  loginGoogleUseCase.swift
//  marketo
//
//  Created by Moncef Guettat on 12/2/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import GoogleSignIn

class LoginGoogleUseCase: NSObject,GIDSignInDelegate {
    
    var completion : ((Result<String>)->Void)?
    
    let loginRepository : UserRepository
    init(loginRepository: UserRepository = UserRepository()){
        self.loginRepository = loginRepository
        super.init()
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func execute(completion:@escaping (Result<String>)->Void) {
        
        self.completion = completion
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            let idToken = user.authentication.idToken // Safe to send to the server
            //let fullName = user.profile.name
            //let givenName = user.profile.givenName
            //let familyName = user.profile.familyName
            //let email = user.profile.email
            print(idToken!)
            self.loginRepository.loginSocialMedia(a: User(fullName: user.profile.name, username: user.userID, password: user.userID, email: user.profile.email, type: "google"),with: "google", withAccessToken: idToken!)
            self.completion!(Result(value : {
                return "Login Successful"
            }))
            
        } else {
            self.completion!(Result(value : {
                throw error
            }))
        }
    }
}
