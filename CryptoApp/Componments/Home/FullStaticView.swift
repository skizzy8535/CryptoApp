//
//  FullStaticView.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/25.
//

import SwiftUI

struct FullStaticView: View {
    
    @EnvironmentObject var homeviewModel: HomeViewModel
    @Binding var showPortfolio :Bool
    
    
    var body: some View {
        HStack{
            ForEach(homeviewModel.stats) { staticItem in
                StatisticsView(statisticsModel: staticItem)
                    .frame(width: UIScreen.main.bounds.width/3)
            }
        }
        .frame(width: UIScreen.main.bounds.width ,
               alignment: showPortfolio ? .trailing:.leading )
    }
}

struct FullStaticView_Previews: PreviewProvider {
    static var previews: some View {
        FullStaticView(showPortfolio: .constant(false))
            .environmentObject(developProvider.coinHomeVm)
    }
}
