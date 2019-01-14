//
//  DemoTableViewController.swift
//  marketo
//
//  Created by Admin on 1/14/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import UIKit
import FoldingCell

class DemoTableViewController: UITableViewController {
    
    let closeHeight: CGFloat = 91
    let openHeight: CGFloat = 166
    var itemHeight = [CGFloat](repeating: 91.0, count: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
    }
}

// MARK: Helpers
extension DemoTableViewController {
    
    private func registerCell() {
        tableView.register(DemoFoldingCell.self, forCellReuseIdentifier: DemoFoldingCell.description())
   }
    
}

// MARK: - Table view data source
extension DemoTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemHeight.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DemoFoldingCell.description(), for: indexPath)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
    
        var duration = 0.0
        if itemHeight[indexPath.row] == closeHeight { // open cell
            itemHeight[indexPath.row] = openHeight
            cell?.setSelected(true, animated: true)
            duration = 0.5
        } else {// close cell
            itemHeight[indexPath.row] = closeHeight
            cell?.setSelected(false, animated: true)
            duration = 1.1
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
        
    }
}
