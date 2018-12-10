//
//  CategoryViewController.swift
//  marketo
//
//  Created by Othmen on 12/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

private let markReuseIdentifier = "markCell"
private let typeReuseIdentifier = "typeCell"
private let categoryReuseIdentifier = "categoryCell"


class CategoryViewController: UIViewController {
    
    @IBOutlet weak var categoriesCollectionView : UICollectionView!
    @IBOutlet weak var typesCollectionView : UICollectionView!
    @IBOutlet weak var marksTableView : UITableView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension CategoryViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = marksTableView.dequeueReusableCell(withIdentifier: markReuseIdentifier) as! MarkTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showProducts", sender: nil)
    }
    
}

extension CategoryViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell
        if collectionView == self.categoriesCollectionView {
            cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: categoryReuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        }else{
            cell = typesCollectionView.dequeueReusableCell(withReuseIdentifier: typeReuseIdentifier, for: indexPath) as! TypeCollectionViewCell
        }
        return cell
    }
}
