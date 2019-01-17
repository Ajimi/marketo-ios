//
//  MoreViewController.swift
//  marketo
//
//  Created by Admin on 1/16/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import GoogleSignIn


struct MoreCellDetail {
    let image: String
    let label: String
    let type: CellType
}

enum CellType {
    case feedback
    case password
    case disconnect
    case favorite
    case signin
    case username
}
private let signInUserCell = "signInUserCell"
private let actionButtonCell = "actionButtonCell"
private let usernameButtonCell = "usernameButtonCell"



private let tableData = [
    MoreCellDetail(image: "shopping_cart", label: "My Basket",type:  .favorite),
    MoreCellDetail(image: "thumbs_up", label: "Give us feedback", type: .feedback),
    MoreCellDetail(image: "pencil", label: "Change password", type: .password),
    MoreCellDetail(image: "lock", label: "Disconnect", type: .disconnect),
]

class MoreViewController: UIViewController {

    
    
    @IBOutlet weak var moreTableView: UITableView!
    
    let viewModel = MoreViewModel()
    var isUserLoggedIn = false
    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moreTableView.delegate = self
        moreTableView.dataSource = self
        
        
        moreTableView.estimatedRowHeight = moreTableView.rowHeight
        moreTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        moreTableView.reloadData()
        viewModel.updateUI()
        viewModel.uiUserState.bindAndFire { (uiModel) in
            if (uiModel.showProgress){
                print("In progress stat")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                self.isUserLoggedIn = false
                self.moreTableView.reloadData()
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let user = showSucces.consume() {
                // TODO user is connected display change
                self.user = user
                self.isUserLoggedIn = true
                self.moreTableView.reloadData()
            }
        }
        
        
        viewModel.navigateToSignInAction.bindAndFire { (model) in
            guard let event = model else {
                return
            }
            if !event.consumed, let _ = event.consume() {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let vc = storyboard.instantiateViewController(withIdentifier: "SignInView") as? LoginViewController {
                    vc.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
            }
        }
        
        viewModel.navigateToFavoriteAction.bindAndFire { (model) in
            guard let event = model else {
                return
            }
            if !event.consumed, let _ = event.consume() {
//                let storyboard = UIStoryboard(name: "CommandStoryboard", bundle: nil)
//                if let vc = storyboard.instantiateViewController(withIdentifier: "FavoriteView") as? FavoriteViewController {
//                    self.present(vc, animated: true, completion: nil)
//                }
                //self.dismiss(animated: true, completion:{
                    self.navigationController?.tabBarController?.selectedIndex = 2
               // })
                
                
                
                //                self.performSegue(withIdentifier: "navigateToFavorite", sender: nil)
            }
        }
        
        viewModel.feedbackAction.bindAndFire { (model) in
            guard let event = model else {
                return
            }
            if !event.consumed, let _ = event.consume() {
              // TODO add Change FeedBack
            }
        }
        
        viewModel.disconnectAction.bindAndFire { (model) in
            guard let event = model else {
                return
            }
            if !event.consumed, let _ = event.consume() {
                self.disconnect()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                if let vc = storyboard.instantiateViewController(withIdentifier: "HomeView") as? HomeViewController {
                    var navController = UINavigationController(rootViewController: vc)
                    navController.navigationBar.barTintColor = self.hexStringToUIColor(hex: "#ED8E00")
                    self.present(navController, animated: true, completion: nil)
                }
            }
        }
        
        viewModel.changePasswordAction.bindAndFire { (model) in
            guard let event = model else {
                return
            }
            if !event.consumed, let _ = event.consume() {
                self.showPasswordChangeAlert()
            }
        }
    }
    
    
    
    func disconnect() {
        viewModel.logout()
        if let accesstoken = FacebookCore.AccessToken.current{
            let loginManager = LoginManager()
            loginManager.logOut()
        }
        if let currentUser = GIDSignIn.sharedInstance()?.currentUser {
            GIDSignIn.sharedInstance()?.signOut()
        }
    }
    
    func showPasswordChangeAlert(){
        let alertController = UIAlertController(title: "Change password", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        }
        let confirmAction = UIAlertAction(title: "Confirm the modification", style: .default) { [weak alertController] _ in
            guard let alertController = alertController, let textField = alertController.textFields?.first else { return }
            
            // Change password print()
            self.viewModel.changePassword(password: textField.text!)
        }
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        // Present the alert
        present(alertController, animated: true, completion: nil)
    }
}
extension MoreViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isUserLoggedIn {
            return 5
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if isUserLoggedIn {
                let cell = moreTableView.dequeueReusableCell(withIdentifier: usernameButtonCell, for: indexPath) as! UserNameTableViewCell

                cell.delegate = self
                let content = MoreCellDetail(image: user?.id?.description ?? "", label: user?.username ?? " " , type:.username )

                cell.configure(with: content)
                return cell
            } else {
                let cell = moreTableView.dequeueReusableCell(withIdentifier: signInUserCell, for: indexPath) as! SignInUserTableViewCell
                cell.delegate = self
                cell.configure(with: "user")
                return cell
            }
        }
        
        let cell = moreTableView.dequeueReusableCell(withIdentifier: actionButtonCell, for: indexPath) as! ActionButtonTableViewCell
        
        cell.configure(with: tableData[indexPath.row - 1])
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        if cell.isKind(of: ActionButtonTableViewCell.self) {
            if let actionCell = cell as? ActionButtonTableViewCell {
                actionCell.didTapActionButton() // This will call the delegate
            }
            return
        }
        
        if cell.isKind(of: UserNameTableViewCell.self){
            if let actionCell = cell as? UserNameTableViewCell {
                actionCell.didTapUsername()
            }
            return
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if isUserLoggedIn {
                return 189
            } else {
                return 136
            }
        }
        
        return 67
    }
}

extension MoreViewController: SignInUserTableViewCellDelegate, UserNameTableViewDelegate, ActionButtonTableViewCellDelegate {
    func didTapSignIn(_ sender: SignInUserTableViewCell) {
        viewModel.checkTapAction(with: CellType.signin)
        print(CellType.signin)
    }
    
    func didTapUserName(_ sender: UserNameTableViewCell) {
        viewModel.checkTapAction(with: CellType.username)
        print(CellType.username)
    }
    
    func didTapActionButton(_ sender: ActionButtonTableViewCell) {
        if let detail = sender.cellDetail {
            viewModel.checkTapAction(with: detail.type)
            print(detail.type)	
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}


