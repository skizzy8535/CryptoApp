//
//  StaticView.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/24.
//

import SwiftUI

struct StatisticsView: View {
  
    let statisticsModel :StatisticsModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            Text(statisticsModel.title)
                .font(.caption)
                .foregroundColor(Color.customizeColor.secondaryTextColor)
            Text(statisticsModel.value)
                .font(.headline)
                .bold()
                .foregroundColor(Color.customizeColor.accentColor)
            
            
            HStack(spacing:4) {
                
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .foregroundColor((statisticsModel.percentageChange ?? 0.00) > 0 ? Color.customizeColor.greenColor :
                        Color.customizeColor.redColor)
                    .opacity((statisticsModel.percentageChange ?? 0.00) != 0 ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: (statisticsModel.percentageChange ?? 0.00) > 0 ? 0 : 180))
                
                Text(statisticsModel.percentageChange?.transformPercentToTwoDigits() ?? "")
                    .foregroundColor((statisticsModel.percentageChange ?? 0.00) > 0 ? Color.customizeColor.greenColor :
                        Color.customizeColor.redColor)
                    .opacity((statisticsModel.percentageChange ?? 0.00) != 0 ? 1.0 : 0.0)
            }
                
        }.background(Color.customizeColor.backgroundColor)
    }
}

struct StaticView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            StatisticsView(statisticsModel: developProvider.marketCapStatisticsVm)
                .previewLayout(.sizeThatFits)
            
            
            StatisticsView(statisticsModel: developProvider.btcDominanceStatisticsVm)
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark)
        }
    }
}
