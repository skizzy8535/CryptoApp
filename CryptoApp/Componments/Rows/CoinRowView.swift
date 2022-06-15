//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/3.
//

import SwiftUI

struct CoinRowView: View {
    
   let coin:CoinModel
   let ifHaveHoldings: Bool
   
    var body: some View {
        HStack{
            leftColumn
            Spacer()
            
            if ifHaveHoldings{
                centerColumn
            }
               rightColumn
           }
        .background(Color.customizeColor.accentColor.opacity(0.001))
    }
    
    
    
}
struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CoinRowView(coin: developProvider.coinModel, ifHaveHoldings: false)
                .previewLayout(.sizeThatFits)
            CoinRowView(coin: developProvider.coinModel, ifHaveHoldings: true)
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark)
        }
    }
}


extension CoinRowView{
    
    private var leftColumn :some View {
        HStack {
            Text("\(coin.marketCapRank)")
                .font(.caption)
                .foregroundColor(Color.customizeColor.secondaryTextColor)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .fontWeight(.bold)
                .padding(.leading,8)
        }.padding(.leading,8)
    }
    
    
    private var centerColumn :some View {
        
        VStack(alignment:.trailing){
            Text(coin.currentHoldingsValue.transformValueToTwoDigits())
                .foregroundColor(Color.customizeColor.accentColor)
            Text("\(coin.currentHoldings?.transformNumToTwoDigits() ?? "0.00")")
                .font(.footnote)
             
        }
    }
    
    
    private var rightColumn:some View{
        VStack(alignment:.trailing){
            Text("\(coin.currentPrice.transformValueToTwoDigits())")
                .fontWeight(.bold)
            Text(coin.priceChangePercentage24HInCurrency!.transformPercentToTwoDigits())
                .font(.subheadline)
                .foregroundColor(coin.priceChangePercentage24HInCurrency! >= 0 ? Color.customizeColor.greenColor : Color.customizeColor.redColor )
        }
        .frame(width: UIScreen.main.bounds.width/3, alignment: .trailing)
            .padding(.trailing,8)
       }
    
}
