//
//  CoinDetailViewModel.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/3/30.
//

import Foundation
import Combine

class CoinDetailViewModel:ObservableObject {
    
    
    private var coinDetailService :CoinDetailService?
    private var coinDetailCancellable = Set<AnyCancellable>()
    @Published var overViewDetailStats :[StatisticsModel] = []
    @Published var additionalDetailStats :[StatisticsModel] = []
    @Published var coinDescription:String? = ""
    @Published var coinHomePageLink:String? = ""
    @Published var subredditLink:String? = ""
    @Published var coin:CoinModel

    
    
    
    init(coin :CoinModel){
        self.coin = coin
        coinDetailService = CoinDetailService(coin: coin)
        getCoinDetail()
        
    }
    
    func getCoinDetail(){
      
        coinDetailService?.$coinDetail
            .combineLatest($coin)
            .map({(coinDetail,coinModel) -> (overView:[StatisticsModel],additional:[StatisticsModel]) in
                
                // Overview
                
                var overviewStats : [StatisticsModel] = []
                
                let currentPriceStats = StatisticsModel(title: "Current Price",
                                                        value: coinModel.currentPrice.transformValueToTwoDigits() ,
                                                        percentageChange: coinModel.priceChangePercentage24H
                                                      )
                let currentMarketCap = StatisticsModel(title: "Market Capitalization",
                                                       value: coinModel.marketCap?.formattedWithAbbreviations() ?? "0.00",
                                                       percentageChange: coinModel.marketCapChangePercentage24H)
                
                let currentRankStats = StatisticsModel(title: "Rank", value: "\(coinModel.marketCapRank)")
                
                let currentVolume = StatisticsModel(title: "Volume", value: coinModel.totalVolume?.formattedWithAbbreviations() ?? "0.00")
                
                                                        overviewStats.append(contentsOf: [
                                                            currentPriceStats,
                                                            currentMarketCap,
                                                            currentRankStats,
                                                            currentVolume
                                                        
                                                        ])
                
                // Additional Stats
                
                var additionalStats : [StatisticsModel] = []

                
                let highPriceIn24Hours = StatisticsModel(title: "24h High", value: coinModel.high24H?.transformValueToTwoDigits() ?? "$0.00")
                let lowPriceIn24Hours = StatisticsModel(title: "24h Low", value: coinModel.low24H?.transformValueToTwoDigits() ?? "$0.00")
                
                let priceChangeIn24Hours = StatisticsModel(title: "24h Price Change",
                                                           value: coinModel.priceChange24H?.transformValueToTwoDigits() ?? "$0.00",
                                                           percentageChange: coinModel.priceChangePercentage24H)
                
                let marketChangeIn24Hours = StatisticsModel(title: "24h Market Cap Change",
                                                           value: coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "$0.00",
                                                           percentageChange: coinModel.marketCapChangePercentage24H)
                
                let blockTime = StatisticsModel(title: "Block Time",
                                                value:  "\(coinDetail?.blockTimeInMinutes ?? 0)" )
                
                let hashingValue = StatisticsModel(title: "Hashing Algorithm",
                                                   value: coinDetail?.hashingAlgorithm ?? "N/A")
                
                
                
                additionalStats.append(contentsOf: [
                    highPriceIn24Hours,
                    lowPriceIn24Hours,
                    priceChangeIn24Hours,
                    marketChangeIn24Hours,
                    blockTime,
                    hashingValue
                
                ])
                
                return (overviewStats,additionalStats)
                
            })
            .sink(receiveValue: { (getCoinDetail) in
                self.overViewDetailStats = getCoinDetail.overView
                self.additionalDetailStats = getCoinDetail.additional
        })
            .store(in: &coinDetailCancellable)

        coinDetailService?.$coinDetail
          .sink(receiveValue: { (receivedCoinDetail) in
            self.coinDescription = receivedCoinDetail?.readableDescription
            self.coinHomePageLink = receivedCoinDetail?.links?.homepage?.first
            self.subredditLink = receivedCoinDetail?.links?.subredditURL
        })
          .store(in: &coinDetailCancellable)
        
        
     
        
    }
    
    
    
}
