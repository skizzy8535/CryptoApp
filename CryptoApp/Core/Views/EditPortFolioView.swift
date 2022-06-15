//
//  EditPortFolioView.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/3/1.
//

import SwiftUI

struct EditPortFolioView: View {

    @EnvironmentObject var homeviewModel: HomeViewModel
    @Environment(\.dismiss) var dismiss
    @State var selectedCoin:CoinModel? = nil
    @State var quantityText:String = ""
    @State var showCheckMark:Bool = false
    
    var body: some View {
        NavigationView{
            
            ScrollView{
                VStack{
                    SearchView(searchText: $homeviewModel.searchText)
                    showSearchedCoin
                    
                    if selectedCoin != nil {
                        editSearchedCoin
                    }
                }
            }.navigationTitle("Edit Portfolio")
            .toolbar {
                
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.headline)
                        }

                    }
                        
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack(spacing:10){
                            Image(systemName: "checkmark")
                                  .opacity(showCheckMark ? 1.0 : 0.0)
                              
                              Button {
                                  savePortFolio()
                              } label: {
                                  Text("save".uppercased())
                                      .opacity( (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)
                              }.font(.headline)
                        }
                    }
                }
            .onChange(of: homeviewModel.searchText) { newValue in
                if newValue == "" {
                    removeCoinRenderData()
                }
            }
            
        }
    }
    
    func returnQuantityValue()->Double{
        if let quantityNumber = Double(quantityText) {
            return quantityNumber*(selectedCoin?.currentPrice ??
                                   0.00)
        }
        return 0
    }
    
    
    func savePortFolio(){
        
        guard let savedCoin = selectedCoin ,
            let amount = Double(quantityText) else{
            return
        }
        
        
        homeviewModel.updatePortfolio(coin: savedCoin, amount: amount)
    
        
        withAnimation(.spring()) {
            showCheckMark = true
            removeCoinRenderData()
        }
        
        
        
        UIApplication.shared.endEditing()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
            showCheckMark = false
        }
        
        
    }
    
    
    func removeCoinRenderData(){
        selectedCoin = nil
        homeviewModel.searchText = ""
    }
    
    
    func correctCoinHelper(coin:CoinModel){
        
        selectedCoin = coin
        
        if let portfolioCoin = homeviewModel.portfolioCoins.first(where: {$0.id == coin.id}) ,
           let quantity = portfolioCoin.currentHoldings
               {
                quantityText = "\(quantity)"
        }else{
                quantityText = ""
        }
        
    }
    
}



struct EditPortFolioView_Previews: PreviewProvider {
    static var previews: some View {
        EditPortFolioView()
            .environmentObject(developProvider.coinHomeVm)
    }
}


extension EditPortFolioView{
    
    private var showSearchedCoin: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(homeviewModel.searchText.isEmpty ? homeviewModel.portfolioCoins: homeviewModel.allCoins) { coin in
                    EditPortfolioCoinView(coinModel: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                correctCoinHelper(coin:coin)
                            }
                        }
                        .background(
                         
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    selectedCoin?.id == coin.id ? Color.customizeColor.greenColor : Color.clear
                                       , lineWidth: 2.0)
                        
                        
                        )
                }
            }
            .frame(height: 100)
            .padding(.leading)
        }
        
    }
    
    private var editSearchedCoin: some View {
        VStack(spacing:20){
            HStack{
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text((selectedCoin?.currentPrice ?? 0.00).transformValueToTwoDigits())
            }
            Divider()
            HStack{
                Text("Quantity:")
                Spacer()
                TextField("Ex: 1.6", text: $quantityText)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
            }
            Divider()
            HStack{
                Text("Current value:")
                Spacer()
                Text(returnQuantityValue().transformValueToTwoDigits())
                
            }
            
        }
        .padding()
        .animation(.none)
        .font(.headline)
    }

}
