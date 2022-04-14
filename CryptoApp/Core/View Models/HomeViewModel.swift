//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/6.
//

import Foundation
import Combine


class HomeViewModel:ObservableObject{
    
    @Published var allCoins:[CoinModel] = []
    @Published var portfolioCoins:[CoinModel] = []
    @Published var searchText:String = "" 
    @Published var stats :[StatisticsModel] = []
    @Published var isLoading:Bool = false
    @Published var sortStatus:SortOptions = .holding
    
    var downloadCoinService = CoinDataService()
    var downloadCoinCancellAble = Set<AnyCancellable>()

        
    var portfolioDataService = PortfolioDataService()
    
    
    var downloadStatisticsService = StatisticsDataService()

    
    enum SortOptions{
        case rank,rankReversed,holding,holdingReversed,price,priceReversed
    }
    
    
    
    
    init(){
        coinSubscription()
    }
    
    func coinSubscription(){
        $searchText
            .combineLatest(downloadCoinService.$allDownloadCoinData,$sortStatus)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map(upadteHomeViewCoins)
            .sink { (receivedDownlaodCoins) in
                self.allCoins = receivedDownlaodCoins
            }.store(in: &downloadCoinCancellAble)

    
        $allCoins
            .combineLatest(portfolioDataService.$savedPortfolio)
            .map(filterPortfolioCoins)
            .sink { [weak self] (coins) in
                guard let self = self else { return }
                self.portfolioCoins =  self.updateSortedPortfolioCoins(coins: coins)
            }
            .store(in: &downloadCoinCancellAble)
        
        
        
        downloadStatisticsService.$stats
            .combineLatest($portfolioCoins)
            .map(collectMarketData)
            .sink { (fullMarketStats) in
                self.stats = fullMarketStats
                self.isLoading = false
            }.store(in: &downloadCoinCancellAble)
        
    }
    
    
    func updatePortfolio(coin:CoinModel,amount:Double){
        portfolioDataService.update(coin: coin, amount: amount)
    }
    
    
    func reloadData(){
         isLoading = true
         downloadCoinService.downloadCoinData()
         downloadStatisticsService.getStaticData()
    }
    
    
    private func upadteHomeViewCoins(text:String,initCoin:[CoinModel],sortOption:SortOptions)->[CoinModel]{
        var firstHomeViewCoins = filterSearchedCoins(text: text, startedCoins: initCoin)
        updateSortHomeViewCoins(coin: &firstHomeViewCoins, status: sortOption)
        return firstHomeViewCoins
    }
    
    private func filterSearchedCoins(text:String,startedCoins:[CoinModel]) -> [CoinModel] {
           guard !text.isEmpty else{
                return startedCoins
            }
            
            let lowercaseCoin = text.lowercased()
            
            return startedCoins.filter { (coin) -> Bool in
                return coin.name.contains(lowercaseCoin) ||
                       coin.symbol.contains(lowercaseCoin) ||
                       coin.id.contains(lowercaseCoin)
            }
    }
    
    private func updateSortHomeViewCoins(coin: inout [CoinModel],status:SortOptions){
        
        switch status {
        case .rank,.holding:
            coin.sort(by: {$0.marketCapRank < $1.marketCapRank})
        case .rankReversed,.holdingReversed:
            coin.sort(by: {$0.marketCapRank > $1.marketCapRank})
        case .price:
            coin.sort(by: {$0.currentPrice > $1.currentPrice})
        case .priceReversed :
            coin.sort(by: {$0.currentPrice < $1.currentPrice})
        }
        
    }
    
    
     
     private func updateSortedPortfolioCoins(coins: [CoinModel]) -> [CoinModel]{
         
         switch sortStatus {
         case .holding:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue})
         case .holdingReversed:
            return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
         default :
            return coins
         }
     }
     
    
    

    
    private func filterPortfolioCoins(coins:[CoinModel],portfolios:[Portfolio]) -> [CoinModel]{
      
             coins
               .compactMap { (getPortfolioCoins) -> CoinModel? in
               
                 guard let portfolio = portfolios.first(where: {$0.coinID == getPortfolioCoins.id}) else {
                     return nil
                 }
                 
                 return getPortfolioCoins.updateCurrentHoldings(amount: portfolio.amount)
             }

    }
    
    private func collectMarketData (marketStats:StaticData?,portfolioCoins:[CoinModel]) ->  [StatisticsModel]  {
        
             
             var showAllMarketCoinStats :[StatisticsModel] = []
             
             guard let marketStats = marketStats else {
                 return showAllMarketCoinStats
             }
             
             
             let showAllMarketCoinCap = StatisticsModel(title: "Market Cap", value: marketStats.marketCap, percentageChange: marketStats.marketCapChangePercentage24HUsd)
             let showAllMarketCoinVolume = StatisticsModel(title: "24h Volume", value: marketStats.volume)
             let showBtcDominace = StatisticsModel(title: "BTC Dominance", value: marketStats.btcDominance)
             
             
             let currentPortfolioCoinValue = portfolioCoins
                                        .map({$0.currentHoldingsValue})
                                        .reduce(0, +)
             
             let previousPortfolioCoinValue = portfolioCoins.map { coindata -> Double in
                 
                 let coinCurrentPrice = coindata.currentPrice
                 let coinPercentageChange = (coindata.priceChangePercentage24H ?? 0.00) / 100
                 let realPreviousValue = coinCurrentPrice / (1+coinPercentageChange)
                 return realPreviousValue
                 
             }.reduce(0, +)
             
             
             let portfolioCoinFluctuation = ((currentPortfolioCoinValue - previousPortfolioCoinValue) / previousPortfolioCoinValue) * 100
             
             let showPortfolioValue = StatisticsModel(title: "Portfolio Value",
                                                      value: currentPortfolioCoinValue.transformValueToTwoDigits(),
                                                      percentageChange: portfolioCoinFluctuation)
             
             showAllMarketCoinStats.append(contentsOf: [
                 showAllMarketCoinCap,
                 showAllMarketCoinVolume,
                 showBtcDominace,
                 showPortfolioValue
             ])
             
             return showAllMarketCoinStats
             
    }
    
    

    
}
