//
//  CoinModel.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/3.
//

import Foundation



// Coin API Result

/*
 {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
     "current_price": 37550,
     "market_cap": 711606016756,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 788715917622,
     "total_volume": 15424323274,
     "high_24h": 39138,
     "low_24h": 37560,
     "price_change_24h": -1221.536312139193,
     "price_change_percentage_24h": -3.15064,
     "market_cap_change_24h": -20283858892.66992,
     "market_cap_change_percentage_24h": -2.77144,
     "circulating_supply": 18946906,
     "total_supply": 21000000,
     "max_supply": 21000000,
     "ath": 69045,
     "ath_change_percentage": -45.60006,
     "ath_date": "2021-11-10T14:24:11.849Z",
     "atl": 67.81,
     "atl_change_percentage": 55291.34091,
     "atl_date": "2013-07-06T00:00:00.000Z",
     "roi": null,
     "last_updated": "2022-02-02T16:03:44.485Z",
     "sparkline_in_7d": {
       "price": [
         38106.969734092716,
         37844.12888645299,
         38184.41621869904,
         38244.32492755344,
         38005.827903658734,
         38298.77290726386,
         38096.996591364295,
         38566.22508438554,
         37238.388243166875,
         37118.28558873019,
         36480.07828971702,
         36776.53224146219,
         37007.385905588635,
         35915.054205488246,
         36104.216386999695,
         35622.94356709955,
         36058.50457844193,
         36043.99343671098,
         36246.18326868031,
         36287.64805612861,
         36543.167342822904,
         36622.35017721683,
         36408.24478693469,
         36681.13748833145,
         36797.44768412442,
         36860.84082806735,
         37053.06453570276,
         36657.860035486054,
         36515.78841383556,
         36374.57898816156,
         36322.33407767829,
         36308.358021454165,
         35854.53743677616,
         36516.13137243078,
         36974.7497498298,
         37276.839558174994,
         37199.53177609241,
         36984.75572190026,
         37021.717042986296,
         37379.243178104836,
         37193.626826836466,
         37272.78912117869,
         37024.86417781171,
         36966.75580970853,
         36684.82822887803,
         36603.75472490369,
         36646.257546983055,
         36483.207475402356,
         36301.5145817071,
         36925.06603404632,
         36779.01213350741,
         37239.69611157056,
         37128.57563897641,
         36894.47776334448,
         37094.66235234937,
         37237.829196127204,
         37815.78690547874,
         37907.74005009467,
         37742.296334791674,
         37852.57902803263,
         37819.36313990765,
         37593.729428346,
         37573.643312332555,
         37794.06295491775,
         37899.818394770795,
         37720.475315120035,
         37778.493805870276,
         37900.289201708285,
         37858.54550101492,
         37759.295584816115,
         37875.20727398643,
         37812.85314111857,
         37897.47347656098,
         38224.64048284969,
         37739.20512207764,
         37540.930535916974,
         37548.040793352346,
         37703.04337475641,
         37998.843588172014,
         37941.73260551178,
         38406.75291910887,
         38509.11533552563,
         38191.791040398246,
         38232.17873217708,
         37921.774661955365,
         37957.230551716544,
         38020.176788120276,
         37987.1684020853,
         38182.789852421374,
         38231.587452794774,
         38141.19420739754,
         38333.50041978721,
         38076.78904800266,
         38001.19915301446,
         38202.80588134877,
         38180.551589075665,
         37983.84156103583,
         38017.71130387069,
         37897.223080022726,
         38043.861542859224,
         37922.85097170238,
         38037.91223995522,
         37893.81240536158,
         37575.72871145612,
         37784.91386863746,
         37786.90381449166,
         37874.99796720115,
         37983.151499406464,
         36975.408705168666,
         36920.786339158105,
         37051.64434316899,
         37105.032700188916,
         36989.31895354381,
         37077.888955642586,
         37041.059103198284,
         37211.84114121487,
         37223.13384561173,
         37280.98161423236,
         37339.488549437956,
         37313.29972456987,
         37148.33758867895,
         37357.166573066905,
         37505.22078178089,
         37757.49385305088,
         38338.06499313098,
         38557.619230601056,
         38539.65135001987,
         38510.304162121494,
         38563.86326209492,
         38481.198551313806,
         38494.392526614065,
         38555.53446121157,
         38374.49481172406,
         38316.50245069531,
         38491.70642338461,
         38652.80247638571,
         38600.277151126575,
         38580.94684727575,
         38355.652661642496,
         38479.009645414124,
         38481.766036144036,
         38606.76841192672,
         38318.50567420606,
         38277.927203377985,
         38464.1841120973,
         38653.38653722551,
         38967.772445988,
         38466.31008493793,
         38660.80265670074,
         39048.30602879875,
         38943.572365198306,
         38589.78859590186,
         38461.64620483799,
         38730.80041058787,
         38818.329306445834,
         38728.89008488232,
         38801.34254479085,
         38641.94738121112,
         38508.799332178525,
         38720.7404284395,
         38648.40649863093,
         38594.2490461442,
         38459.62025924167,
         38331.88354728735,
         38352.523819775815,
         38552.57680091829,
         38596.204034363196,
         38677.2566684244
       ]
     },
     "price_change_percentage_24h_in_currency": -3.1506366271492894
   }
 
 */


struct CoinModel: Identifiable,Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice :Double
    let marketCap:Double?
    let marketCapRank:Int
    let fullyDilutedValuation: Int?
    let totalVolume: Double?
    let high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply,ath:Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    var currentHoldings:Double?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
    }
    
    func updateCurrentHoldings(amount:Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0.0) * currentPrice
    }
    
    
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
