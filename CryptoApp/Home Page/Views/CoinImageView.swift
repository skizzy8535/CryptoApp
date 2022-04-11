//
//  CoinImageView.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/12.
//

import SwiftUI

struct CoinImageView:View{    

    @StateObject var coinVm :CoinViewModel
    
    init(coin:CoinModel){
      _coinVm = StateObject(wrappedValue: CoinViewModel(coin: coin))
    }
   
    
    
    var body: some View{
        
        if let showImage = coinVm.showCoinImage {
            Image(uiImage: showImage)
                .resizable()
                .scaledToFit()
            
        }else{
            Image(systemName: "hourglass")
                .foregroundColor(Color.customizeColor.accentColor)
        }
  
        
    }
    
    
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin:developProvider.coinModel)
    }
}
