//
//  Extension.swift
//  marketo
//
//  Created by Moncef Guettat on 11/25/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Alert Extensions
extension UIViewController {
    func showAlert(withTitle: String, withMessage: String) {
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
    
    func showWaiting(alert:UIAlertController){
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
}
