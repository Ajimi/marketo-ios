//
//  BasketCellDelegate.swift
//  marketo
//
//  Created by Admin on 12/9/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
protocol BasketProducTableViewCellDelegate : class {
    func basketCellDidTapStepper(_ sender: BasketProductTableViewCell, _ value: Int)
    func basketCellDidTapRemove(_ sender: BasketProductTableViewCell)
}



//weak var delegate: BasketCellDelegate?

// class 
