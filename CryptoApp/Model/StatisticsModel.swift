//
//  StaticModel.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/24.
//

import Foundation


struct StatisticsModel:Identifiable{
    
    let id : String = UUID().uuidString
    let title:String
    let value: String
    let percentageChange:Double?
    
    init(title:String,value:String,percentageChange:Double? = nil){
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
    
    
}
