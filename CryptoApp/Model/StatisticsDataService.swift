//
//  StaticDataService.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/24.
//

import Foundation
import SwiftUI
import Combine


class StatisticsDataService:ObservableObject{
    
    @Published var stats :StaticData? = nil
    var statisticsCancellable:AnyCancellable?
    

    
    
    init(){
        getStaticData()
    }
    
    func getStaticData(){
        
        guard let statisticsURL = URL(string: "https://api.coingecko.com/api/v3/global") else{
            return
        }
        
        
        statisticsCancellable = NetWorkingManager.downloadCoins(urlString: statisticsURL)
                                .decode(type: MarketDataModel.self, decoder: JSONDecoder())
                                .sink(receiveCompletion: NetWorkingManager.completionHandler, receiveValue: { (receivedGlobalData) in
                                    self.stats = receivedGlobalData.data
                                    self.statisticsCancellable?.cancel()
                                })
        
        
        
    }
    
}
