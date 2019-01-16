//
//  TestCell.swift
//  marketo
//
//  Created by Moncef Guettat on 1/15/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import FoldingCell
import UIKit

private let statByMarketProductPriceReuseIdentifier = "statByMarketProductPriceReuseIdentifier"
private let statByMarketProductPriceHeaderReuseIdentifier = "statByMarketProductPriceHeaderReuseIdentifier"


class StatsByMarketTableViewCell: FoldingCell {
    
    var market : ProductStatisticsByMarket?
    
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var bestDiff: UILabel!
    @IBOutlet weak var marketName: UILabel!
    @IBOutlet weak var skippedProducts: UILabel!
    @IBOutlet weak var detailMarketName: UILabel!
    @IBOutlet weak var detailTotal: UILabel!
    @IBOutlet weak var detailBestDiff: UILabel!
    @IBOutlet weak var detailSkippedProducts: UILabel!
    @IBOutlet weak var pricesTableView: UITableView!
    
    func configure(market: ProductStatisticsByMarket,bestTotal : Int) {
        self.market = market
        
        total.text = "$ "+market.total!.description
        detailTotal.text = "$ "+market.total!.description
        
        skippedProducts.text = market.skippedPrices!.description
        detailSkippedProducts.text = market.skippedPrices!.description
        
        marketName.text = market.name!
        detailMarketName.text = market.name
        
        bestDiff.text = "$ "+(market.total! - bestTotal).description
        detailBestDiff.text = "$ "+(market.total! - bestTotal).description
        
        pricesTableView.dataSource = self as! UITableViewDataSource
    
        
    }
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension StatsByMarketTableViewCell: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((market?.prices?.count)! + 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: statByMarketProductPriceHeaderReuseIdentifier) as! UITableViewCell
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: statByMarketProductPriceReuseIdentifier) as! StatByMarketProductPricesTableViewCell
            
            cell.configure(priceParam: (market?.prices?[indexPath.row-1])!, unitPriceParam: (market?.unitPrices?[indexPath.row-1])!)
            
            return cell
            
        }
        
    }
    
    
    
    
}
