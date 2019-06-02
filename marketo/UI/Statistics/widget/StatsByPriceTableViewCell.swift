//
//  StatsByPriceTableViewCell.swift
//  marketo
//
//  Created by Moncef Guettat on 1/16/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import UIKit
import FoldingCell

private let statByPriceMarketDetailCellReuseIdentifier = "statByPriceMarketDetailCellReuseIdentifier"

private let statByPriceMarketDetailHeaderReuseIdentifier = "statByPriceMarketDetailHeaderReuseIdentifier"

class StatsByPriceTableViewCell: FoldingCell,Configurable {
    typealias DataType = ProductStatisticsByPrice
    @IBOutlet weak var headerProductName: UILabel!
    @IBOutlet weak var headerMarketName: UILabel!
    @IBOutlet weak var headerQuantity: UILabel!
    @IBOutlet weak var headerPrice: UILabel!
    @IBOutlet weak var headerDiff: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    
    @IBOutlet weak var detailProductName: UILabel!
    @IBOutlet weak var detailMarketName: UILabel!
    @IBOutlet weak var detailQuantity: UILabel!
    @IBOutlet weak var detailPrice: UILabel!
    @IBOutlet weak var detailDiff: UILabel!
    @IBOutlet weak var detailMarkName: UILabel!
    @IBOutlet weak var detailTypeName: UILabel!
    @IBOutlet weak var detailAllPricesTableView: UITableView!
    @IBOutlet weak var detailImage: UIImageView!
    
    var product : ProductStatisticsByPrice?
    var worst : Float?
    
    func configure(with content: ProductStatisticsByPrice) {
        
        product = content
        worst = getWorstPrice(prices: content.prices!)
        
        headerProductName.text = content.name!
        headerMarketName.text = content.bestPrice?.market?.text
        headerQuantity.text = content.quantity?.description
        headerPrice.text = "$ "+(content.bestPrice?.value.description)!
        headerDiff.text = "$ " + (worst! - content.bestPrice!.value).description
        
        headerImage.kf.setImage(
        with: URL(string: content.image!),
        placeholder: UIImage(named: "logo"),
        options: [
        .scaleFactor(UIScreen.main.scale),
        .transition(.fade(1)),
        .cacheOriginalImage
        ])
        
        detailProductName.text = content.name!
        detailMarketName.text = content.bestPrice?.market?.text
        detailQuantity.text = content.quantity?.description
        detailPrice.text = "$ "+(content.bestPrice?.value.description)!
        detailDiff.text = "$ " + (worst! - content.bestPrice!.value).description
        detailMarkName.text = content.mark?.name
        detailTypeName.text = content.type?.name
        detailImage.kf.setImage(
            with: URL(string: content.image!),
            placeholder: UIImage(named: "logo"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
        detailAllPricesTableView.dataSource = self as! UITableViewDataSource
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension StatsByPriceTableViewCell{

    func getWorstPrice(prices : Prices) -> Float {
        
        return prices.max { (price1, price2) -> Bool in
            return price1.value < price2.value
        }!.value
        
        
    }
    
}

extension StatsByPriceTableViewCell: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (product?.prices?.count)! + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: statByPriceMarketDetailHeaderReuseIdentifier) as! UITableViewCell
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: statByPriceMarketDetailCellReuseIdentifier) as! StatByPriceMarketPriceTableViewCell
        
        cell.configure(price: (product?.prices![indexPath.row-1])!, unit: (product?.unitPrices![indexPath.row-1])!, worst: worst!)
        
        return cell
    }
    
}
