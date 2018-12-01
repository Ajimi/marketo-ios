//
//  ProductCollectionView.swift
//  marketo
//
//  Created by selim ajimi on 11/25/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class ProductCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        
        return cell
    }
    
    
    

}
