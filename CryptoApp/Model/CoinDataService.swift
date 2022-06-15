//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/9.
//

import Foundation
import Combine



class CoinDataService:ObservableObject {
    

    @Published var allDownloadCoinData :[CoinModel] = []
    var coinSubscription : AnyCancellable?
    
    
    init(){
        downloadCoinData()
    }
    
    func downloadCoinData(){
        
        guard let coinURL = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h") else{
            return
        }
        
        
        coinSubscription = NetWorkingManager.downloadCoins(urlString: coinURL)
                                .decode(type: [CoinModel].self, decoder: JSONDecoder())
                                .sink(receiveCompletion:NetWorkingManager.completionHandler, receiveValue: { (receivedCoinData) in
                                    self.allDownloadCoinData = receivedCoinData
                                    self.coinSubscription?.cancel()
                                })
                              
    }
    

}
