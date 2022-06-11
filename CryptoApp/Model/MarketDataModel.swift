//
//  MarketDataModel.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/25.
//

import Foundation



struct MarketDataModel:Codable{
    let data: StaticData?
}


struct StaticData: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double?
    let updatedAt: Int?

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        case updatedAt = "updated_at"
    }
    
    var marketCap:String{
        
        if let item = totalMarketCap.first(where: { $0.key == "usd"}){
            return "$" + item.value.formattedWithAbbreviations()
        }
        
        return ""
    }
    
    
    
    var volume:String{
        
        if let item = totalVolume.first(where: { $0.key == "usd"}){
            return "$" + item.value.formattedWithAbbreviations()
        }
        
        return ""
    }
    
    var btcDominance:String{
        if let item = marketCapPercentage.first(where: { $0.key == "btc"}){
            return item.value.transformPercentToTwoDigits()
        }
        
        return ""
    }

}
