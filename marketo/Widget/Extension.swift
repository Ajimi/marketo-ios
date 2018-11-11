//
//  ImageViewExtension.swift
//  marketo
//
//  Created by Moncef Guettat on 11/11/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func roundedImage() {
        self.layer.cornerRadius = self.frame.size.width / 2.0
        self.clipsToBounds = true
    }
}