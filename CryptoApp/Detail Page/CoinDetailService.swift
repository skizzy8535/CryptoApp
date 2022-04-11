//
//  CoinDetailService.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/3/30.
//

import Foundation
import Combine

class CoinDetailService :ObservableObject {
    
    @Published var coinDetail :CoinDetailModel? = nil
    let coin:CoinModel
    var coinDetailDataCancellable:AnyCancellable?
    
    
    init(coin:CoinModel){
        self.coin = coin
        downloadCoinDetailData()
    }
    
    
    func downloadCoinDetailData(){
        
        
        guard let coinURL = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")  else {
             return
        }
        
        coinDetailDataCancellable = NetWorkingManager.downloadCoins(urlString: coinURL)
                                         .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
                                         .sink(receiveCompletion: NetWorkingManager.completionHandler, receiveValue: { (receivedCoinDetailData) in
                                             self.coinDetail = receivedCoinDetailData
                                             self.coinDetailDataCancellable?.cancel()
                                         })
        
        
    }
    
    
    
}
