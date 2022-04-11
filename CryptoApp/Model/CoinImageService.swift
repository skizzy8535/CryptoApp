//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/12.
//

import Foundation
import SwiftUI
import Combine



class CoinImageService:ObservableObject{
    
    
    @Published var coinImage:UIImage?
    @Published var coin:CoinModel
    var coinImageCancelable:AnyCancellable?
    var folderName = "coin_images"
    var localManager  = LocalFileManager.instance
    var localImageName:String
    
    
    init(coin:CoinModel){
        self.coin = coin
        self.localImageName = coin.id
        getImage()
    }

    func getImage(){
        
        if let getLocalImage = localManager.getImage(folderName: folderName, imageName: localImageName){
            coinImage = getLocalImage
            print("Retrieved From FileManager")
        }else{
            downloadCoinImage()
            print("Picture came from download")
        }
    }
    
    

    func downloadCoinImage(){
        
        guard let coinImageURL = URL(string: coin.image) else{
            return
        }
        
        coinImageCancelable =  NetWorkingManager.downloadCoins(urlString: coinImageURL)
                                        .tryMap({ coinImageData -> UIImage in
                                            return UIImage(data: coinImageData) ?? UIImage(systemName: "hourglass")!
                                          })
                                        .sink(receiveCompletion: NetWorkingManager.completionHandler, receiveValue: { (receivedDownloadImage) in
                                               self.coinImage = receivedDownloadImage
                                               self.coinImageCancelable?.cancel()
                                               self.localManager.saveImage(image: receivedDownloadImage, folderName: self.folderName, imageName: self.localImageName)
                                         })
        
             }
    
    
}
