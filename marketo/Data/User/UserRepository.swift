//
//  UserRepository.swift
//  marketo
//
//  Created by selim ajimi on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire
import JWTDecode
protocol UserDataSource: DataSource {
    // TODO :Add methods
    
}

class UserRepository {
    
    // Constructor must have local data source and remote data souree
    let remoteRepository: UserRemoteRepository
    let localRepository: UserLocalRepository
    
    init(remoteRepository: UserRemoteRepository = UserRemoteRepository(), localRepository: UserLocalRepository = UserLocalRepository()) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
    
    func login(a user: User, completion:@escaping (Result<AccessToken>)->Void){

    
        remoteRepository.login(a: user) { (result) in
            switch result {
            case .success(let accessToken):
                // TODO get user detail
                // TODO extract user id
                //print
                let id = self.getUserIdFrom(token: accessToken.accessToken)
                print(id)
                self.remoteRepository.readUser(id: id, token: accessToken.accessToken, completion: { (response) in
                    switch response {
                    case .success(let currentUser):
                        //print(accesst)
                        self.localRepository.login(a: currentUser, withAccessToken: accessToken.accessToken)
                        completion(result)
                        print("success")

                    case .failure(let error):
                        print("error")
                        print(error)
                        completion(result)
                    }
                })
            case .failure(let error):
                // TO DO : Error handling here
                completion(result)
                print("\(error.localizedDescription)")
            }
        }
    }
    
    private func getUserIdFrom(token: String) -> Int {
        let jwt = try! decode(jwt: token)
        /*print(jwt)
        let claim = jwt.claim(name: "usersId")
        if let userId = claim.string {
            print(userId)
            return Int(userId)!
        }*/
        return jwt.body["usersId"] as! Int
    }

    
    func loginSocialMedia(a user:User, with type : String, withAccessToken accessToken : String){
        localRepository.login(a: user , withAccessToken: accessToken)
        self.register(a:user, completion: checkResponseFor)
    }
    
    func checkResponseFor(response : Result<User>) {
        switch response {
        case .success(let user):
            print(user)
        case .failure(let error):
            print(error)
        }
    }
    
    func register(a user: User, completion:@escaping (Result<User>)->Void){
        remoteRepository.register(a: user, completion: completion)
    }
    
    func loggedOut() -> Bool {
        localRepository.logout()
        return true
    }
    
    func isLoggedIn() -> Bool {
        return localRepository.isLoggedIn()
    }
    
    func getUser() -> User? {
        return localRepository.user
    }
    
    func modifyPassword(password: String, id: Int){
        remoteRepository.modifyPassword(user: PasswordChangeRequest(password: password, userId: id), token: localRepository.authTokenRepository.authToken!)
    }
}


struct PasswordChangeRequest{
    let password: String
    let userId: Int
}
