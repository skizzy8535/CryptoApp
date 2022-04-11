//
//  HomeView.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/2.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var homeviewModel: HomeViewModel
    @State var animated:Bool = false
    @State var showPortfolio :Bool = false
    @State var showSettingPage :Bool = false
    @State var showEditPortfolioPage :Bool = false
    
    @State var selectedCoin:CoinModel? = nil
    @State var showDetailView:Bool = false
    
    
    
    var body: some View {
        
        
        ZStack {
            
            Color.customizeColor.backgroundColor.ignoresSafeArea()
                .sheet(isPresented:$showEditPortfolioPage ,content:{
                        EditPortFolioView()
                            .environmentObject(homeviewModel)
                })
            
            VStack {
                headerView
                FullStaticView(showPortfolio: $showPortfolio)
                SearchView(searchText: $homeviewModel.searchText)
                columnTitles
                         
                
                if showPortfolio{
                    portfoiloCoinListView
                        .transition(.move(edge: .trailing))
                }
                
                
                if !showPortfolio{
                    coinListView
                        .transition(.move(edge: .leading))
                }
                
                Spacer(minLength: 0)
            }
               .sheet(isPresented: $showSettingPage, content: {
                SetttingView()
            })
        }
        .background(
            NavigationLink(
                destination: DetailLoadingView(coin: $selectedCoin),
                isActive: $showDetailView,
                label: { EmptyView() })
        )
        
      }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView(showPortfolio: false)
                .environmentObject(developProvider.coinHomeVm)
                .previewLayout(.sizeThatFits)
        }

    }
}



extension HomeView{
    
    private var headerView: some View {
        HStack {

             CircleButtonView(imageName: showPortfolio ? "plus" : "info")
                 .animation(.none)
                 .onTapGesture {
                     if showPortfolio{
                         showEditPortfolioPage.toggle()
                     }
                 
                     if !showPortfolio{
                         showSettingPage.toggle()
                     }
                 }
                 .background(
                     CircleButtonAnimation(animated: $showPortfolio)
                 )
             
             Spacer()
             
             Text(showPortfolio ? "My Portfolio" : "Live Price")
                 .font(.headline)
                 .fontWeight(.bold)
                 .animation(.none)
             
             Spacer()
             
             CircleButtonView(imageName: "chevron.right")
                 .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                 .onTapGesture {
                     withAnimation {
                         showPortfolio.toggle()
                     }
                 }

       }
    }
    
    private var  columnTitles : some View {
        HStack{
            HStack{
                
                HStack {
                    Text("Coin")
                    Image(systemName: "chevron.down")
                        .rotationEffect(Angle(degrees: homeviewModel.sortStatus == .rank ? 0 : 180) )
                }.onTapGesture {
                    withAnimation(.default) {
                        if homeviewModel.sortStatus == .rank {
                            homeviewModel.sortStatus = .rankReversed
                        }else {
                            homeviewModel.sortStatus = .rank
                        }
                    }
                }
                
                
                Spacer()
                if showPortfolio {
                 
                     HStack {
                         Text("Holdings")
                         Image(systemName: "chevron.down")
                             .rotationEffect(Angle(degrees: homeviewModel.sortStatus == .holding ? 180 : 0) )
                     }
                       .onTapGesture {
                           withAnimation(.default) {
                               if homeviewModel.sortStatus == .holding {
                                   homeviewModel.sortStatus = .holdingReversed
                               }else {
                                   homeviewModel.sortStatus = .holding
                               }
                           }
                     }
                }
                
                HStack {
                    Text("Price")
                    
                    Image(systemName: "chevron.down")
                        .rotationEffect(Angle(degrees: homeviewModel.sortStatus == .price ? 0 : 180) )
                    
                    Button {
                        withAnimation(.linear(duration: 2.0)) {
                            homeviewModel.reloadData()
                        }
                    } label: {
                        Image(systemName: "goforward")
                            .rotationEffect(Angle(degrees: homeviewModel.isLoading ? 360 : 0 ), anchor: .center)
                    }
                    
                }
                .onTapGesture {
                    withAnimation(.default) {
                        if homeviewModel.sortStatus == .price {
                           homeviewModel.sortStatus = .priceReversed
                        }else {
                            homeviewModel.sortStatus = .price
                         }
                    }
                }
                .frame(width: UIScreen.main.bounds.width/3, alignment: .trailing)
            }
                .font(.caption)
                .foregroundColor(Color.customizeColor.secondaryTextColor)
                .padding(.horizontal)
        }
    }
    
    private var coinListView : some View {
        List{
            
            
            ForEach(homeviewModel.allCoins) { coinItem in
                
                CoinRowView(coin: coinItem, ifHaveHoldings: showPortfolio)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coinItem)
                    }
                
                    .listRowBackground(Color.customizeColor.backgroundColor)
            }
            
            
        }.listStyle(PlainListStyle())
         
    }
    
    
    private var portfoiloCoinListView: some View {
        
        List{
            ForEach(homeviewModel.portfolioCoins) { coinItem in
                CoinRowView(coin: coinItem, ifHaveHoldings: showPortfolio)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coinItem)
                    }
                
                    .listRowBackground(Color.customizeColor.backgroundColor)
            }
        }.listStyle(PlainListStyle())
  
        
    }
    
    
    private func segue(coin:CoinModel){
        selectedCoin = coin
        showDetailView.toggle()
        
    }
    
    

    
}
 
/*
 .onAppear {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
 .transition(.move(edge: .trailing))
 
 
 .onAppear {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
 .transition(.move(edge: .leading))

 */
