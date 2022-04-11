//
//  EditPortfolioCoinView.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/3/1.
//

import SwiftUI

struct EditPortfolioCoinView: View {
    
    @State var coinModel:CoinModel
    
    var body: some View {
        VStack {
            CoinImageView(coin: coinModel)
                .frame(width: 50, height: 50)
            Text(coinModel.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.customizeColor.accentColor)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coinModel.name)
                .font(.caption)
                .foregroundColor(Color.customizeColor.secondaryTextColor)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
   
}

struct EditPortfolioCoinView_Previews: PreviewProvider {
    static var previews: some View {
        EditPortfolioCoinView(coinModel: developProvider.coinModel)
    }
}
