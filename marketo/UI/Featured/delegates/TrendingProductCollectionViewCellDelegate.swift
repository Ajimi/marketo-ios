//
//  TrendingProductCollectionViewCellDelegate.swift
//  marketo
//
//  Created by Admin on 12/9/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
protocol TrendingProductCollectionViewCellDelegate : class {
    func trendingCellDidTapFavorite(_ sender: TrendingProductCollectionViewCell)
    func trendingCellDidTapBasket(_ sender: TrendingProductCollectionViewCell)
}

