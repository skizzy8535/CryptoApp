//
//  DetailView.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/3/18.
//

import Foundation
import SwiftUI



struct DetailLoadingView:View{
    
    @Binding var coin :CoinModel?


    var body: some View {
        
        ZStack{
           if let coin = coin{
              DetailView(coin: coin)
           }
        }
    }
}



struct DetailView: View {

    @StateObject var coinDetailVm :CoinDetailViewModel
    
    @State var gridItems :[GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var defaultSpacing :CGFloat = 30.0
    @State var showPartStories:Bool = true
    
    init(coin:CoinModel){
        _coinDetailVm = StateObject(wrappedValue: CoinDetailViewModel(coin:coin))
        print("Initialized \(coin.name)")
        
    }
    
    
    var body: some View {
        
        ScrollView{
               VStack{
                
            ChartView(coin: coinDetailVm.coin)
                       .padding(.vertical)
                
                VStack(spacing:20){
                    overviewTitle
                    Divider()
                    overviewStories
                    overviewItems
                    additionalTitle
                    Divider()
                    additionalItems
                    websiteSection
                }.padding()
                   
                
            }
        }
        .navigationTitle(coinDetailVm.coin.name)
        .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingBarItems
                }
            }
        }
        
    }
    


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailView(coin: developProvider.coinModel)
        }
    }
}



extension DetailView {
    
    private var overviewTitle:some View {
            Text("Overview")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.customizeColor.accentColor)
                    .frame(maxWidth:.infinity , alignment: .leading)
                    .padding()
}
    
    private var overviewItems: some View {
        
        LazyVGrid(columns: gridItems, alignment: .leading, spacing: defaultSpacing, pinnedViews: []) {
            ForEach(coinDetailVm.overViewDetailStats) { overviewItem in
                StatisticsView(statisticsModel:overviewItem)
            }
        }.padding()
    }
    
    private var overviewStories :some View{
        VStack(alignment: .leading){
          if let coinDescription = coinDetailVm.coinDescription {
            Text(coinDescription)
                .font(.callout)
                .foregroundColor(Color.customizeColor.secondaryTextColor)
                .lineLimit(showPartStories ? 3 : nil)
              Button {
                  withAnimation(.spring()) {
                      showPartStories.toggle()
                  }
              } label: {
                  Text(showPartStories ? "Read More" : "Less")
                      .font(.caption)
                      .accentColor(.blue)
                      .animation(.none)
              }

              
              
           }
        }
    }
    
    private var additionalTitle:some View {
        Text("Additional Details")
                .font(.title)
                .bold()
                .foregroundColor(Color.customizeColor.accentColor)
                .frame(maxWidth:.infinity , alignment: .leading)
                .padding()
    }
    
    private var additionalItems:some View {
        
        LazyVGrid(columns: gridItems, alignment: .leading, spacing: defaultSpacing, pinnedViews: []) {
            ForEach(coinDetailVm.additionalDetailStats) { additionalItem in
                StatisticsView(statisticsModel:additionalItem)
            }
        }.padding()
        
    }
    
    private var trailingBarItems :some View {
      
            HStack(spacing:5){
                
                CoinImageView(coin: coinDetailVm.coin)
                    .frame(width: 25, height: 25)
                Text(coinDetailVm.coin.symbol.uppercased())
                    .foregroundColor(Color.customizeColor.secondaryTextColor)
            }

    }
 
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let websiteString = coinDetailVm.coinHomePageLink,
               let url = URL(string: websiteString) {
                Link("Website", destination: url)
            }
            
            if let redditString = coinDetailVm.subredditLink,
               let url = URL(string: redditString) {
                Link("Reddit", destination: url)
            }
            
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
}


