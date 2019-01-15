//
//  StatisticsViewController.swift
//  marketo
//
//  Created by Admin on 1/14/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import UIKit
import FoldingCell

class StatisticsViewController: UIViewController {

    private let viewModel : StatisticsViewModel = StatisticsViewModel()
    @IBOutlet weak var statByMarketsTableView: UITableView!
    @IBAction func switchStat(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            statByMarketsTableView.isHidden = false
        }else{
            statByMarketsTableView.isHidden = true
        }
        
    }
    
    
    var cellHeights = (0..<1).map { _ in C.CellHeight.close }

    
     override func viewDidLoad() {
        super.viewDidLoad()
        statByMarketsTableView.delegate = self
        statByMarketsTableView.dataSource = self

        
        viewModel.updateUI()

        viewModel.uiState.bindAndFire { (uiModel) in
            if (uiModel.showProgress){
                print("In progress stat")
            }
            if let showError = uiModel.showError, !showError.consumed, let errorMessage = showError.consume() {
                print("there Was an error loading stat \(errorMessage)")
            }
            
            if let showSucces = uiModel.showSuccess, !showSucces.consumed, let _ = showSucces.consume() {
                DispatchQueue.main.async {
                    self.cellHeights = (0..<self.viewModel.productStatByMarket!.count).map { _ in C.CellHeight.close }
                    self.statByMarketsTableView.reloadData()
                }
            }
            
        }
        
    
    }
    

}

extension StatisticsViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selim") as! StatsByMarketCell
        
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        
        let bestTotal = viewModel.productStatByMarket!.max(by: { (market1, market2) -> Bool in
            return market1.total! > market2.total!
        })?.total
        
        cell.configure(market: viewModel.productStatByMarket![indexPath.row], bestTotal: bestTotal!)
        
        return cell
    }
    
    
    
    fileprivate struct C {
        struct CellHeight {
            static let close: CGFloat = 116 // equal or greater foregroundView height
            static let open: CGFloat = 254 // equal or greater containerView height
        }
    }
    
    
    
    // MARK: - Table view data source
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.productStatByMarket?.count ?? 0
    }
    
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
        
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case let cell as FoldingCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == C.CellHeight.close
        if cellIsCollapsed {
            cellHeights[indexPath.row] = C.CellHeight.open
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = C.CellHeight.close
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0,options: .curveEaseOut, animations: {
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
        
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard case let cell as StatsByMarketCell = cell else {
            return
        }
        
        cell.backgroundColor = .clear
        
        if cellHeights[indexPath.row] == C.CellHeight.close {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
        
        
    }
    
}

