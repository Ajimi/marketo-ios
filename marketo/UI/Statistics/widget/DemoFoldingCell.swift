//
//  DemoCell.swift
//  marketo
//
//  Created by Admin on 1/14/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import FoldingCell
import UIKit
import EasyPeasy
	
class DemoFoldingCell: FoldingCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView = createContainerView()
        foregroundView = createForegroundView()
        
        // super class method configure views
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: AnimationType) -> TimeInterval {
        
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
}

// MARK: Configure
extension DemoFoldingCell {
    
    private func createForegroundView() -> RotatedView {
        let foregroundView = RotatedView(frame: .zero)
        foregroundView.backgroundColor = .red
        foregroundView.translatesAutoresizingMaskIntoConstraints = false
    
        
        contentView.addSubview(foregroundView)
        
        // add constraints
        
        foregroundView.easy.layout(
            Height(75),
            Left(8),
            Right(8)
        )
        
        // add identifier
    
        let top = (foregroundView.easy.layout(Top(8))).first
        top?.identifier = "ForegroundViewTop"
        
        foregroundView.layoutIfNeeded()
        
        return foregroundView
    }
    
    private func createContainerView() -> UIView {
        let containerView = UIView(frame: .zero)
   
        containerView.backgroundColor = .green
        containerView.translatesAutoresizingMaskIntoConstraints = false
    
        
        contentView.addSubview(containerView)
        
        // add constraints
        containerView.easy.layout(
            Height(CGFloat(75 * itemCount)),
            Left(8),
            Right(8)
        )
        
        // add identifier
        let top = (containerView.easy.layout(Top(8))).first
        top?.identifier = "ContainerViewTop"
        
        containerView.layoutIfNeeded()
        
        return containerView
    }
}
