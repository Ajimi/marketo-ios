//
//  UIViewFavoriteEmptyState.swift
//  marketo
//
//  Created by Admin on 12/9/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class UIViewFavoriteEmptyState: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Setup view from .xib file
        initialize()
    }
    
    func initialize() {
        Bundle.main.loadNibNamed("FavoriteEmptyState", owner: self, options: nil)
        
    }

}
