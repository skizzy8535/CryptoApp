//
//  CoinViewModel.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/13.
//

import Foundation
import Combine
import UIKit


class CoinViewModel:ObservableObject{

    @Published var showCoinImage:UIImage?
    let coin :CoinModel?
    
    
    var coinImageCancellable = Set<AnyCancellable>()
   
    
    private var coinImageService :CoinImageService
    
    
    init(coin:CoinModel){
        self.coin = coin
        self.coinImageService = CoinImageService(coin: coin)
        getDownloadImage()
    }
    
    

    
    func getDownloadImage(){
        coinImageService.$coinImage
            .sink {(receivedShowImage) in
                self.showCoinImage = receivedShowImage
            }.store(in: &coinImageCancellable)
        
    }
    
    
}
