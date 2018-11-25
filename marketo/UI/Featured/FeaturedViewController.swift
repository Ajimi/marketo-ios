//
//  FeaturedViewController.swift
//  marketo
//
//  Created by Moncef Guettat on 11/25/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class FeaturedViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.collectionView){
            let cel = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath)
            return cel;
        }else{
            let cel = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCatCell", for: indexPath)
            return cel;
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
