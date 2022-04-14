//
//  SetttingView.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/3/9.
//

import SwiftUI

struct SetttingView: View {
    var body: some View {
        NavigationView{
            
            List{
            
                // 1st
                    Section {
                        VStack(alignment: .leading){
                        Image("CryptoTranspent")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Text("The project uses MVVM Architecture, CoreData and Combine. Prices may be slightly delayed.")
                            .font(.footnote)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                    } header: {
                        Text("Crypto App")
                    }
                    .padding(.vertical)
                    
               // 2nd
                
                Section {
                    VStack(alignment: .leading){
                      Image("CoinGeckoLogo")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                      Text("CoinGecko provides a fundamental analysis of the crypto market. In addition to tracking price, volume and market capitalisation, CoinGecko tracks community growth, open-source code development, major events and on-chain metrics.")
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    Link("Visit CoinGecko", destination: URL(string: "https://www.coingecko.com/")!)
                        .foregroundColor(Color.blue)
                } header: {
                    Text("About CoinGecko")
                }.font(.footnote)
                .padding(.vertical)

                
               // 3rd
                Section(content: {
                    Link("Terms of Service" , destination: URL(string: "https://www.coingecko.com/en/terms")!)  .foregroundColor(Color.blue)
                    Link("Privacy Policy" , destination: URL(string: "https://www.coingecko.com/en/privacy")!)  .foregroundColor(Color.blue)
                    Link("Learn More" , destination: URL(string: "https://www.coingecko.com/en/faq")!)  .foregroundColor(Color.blue)
                }, header: {
                    Text("Application")
                }).font(.footnote)
                  .padding(.vertical)
                
        }
            .navigationTitle("Settings")
   }
}



}
struct SetttingView_Previews: PreviewProvider {
    static var previews: some View {
        SetttingView()
    }
}
