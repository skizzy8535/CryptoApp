//
//  ChartView.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/3/31.
//

import SwiftUI

struct ChartView: View {
    
    var chartData :[Double] = []
    var maxY :Double
    var minY :Double
    var firstMoney : Double
    var lastMoney :Double
    var priceChange:Double
    var lineColor:Color
    @State var percentChange :Double = 0.0
    var endDate:Date
    var startDate:Date
    
    init(coin:CoinModel){
        chartData = coin.sparklineIn7D?.price ?? []
        maxY = chartData.max() ?? 0
        minY = chartData.min() ?? 0
        firstMoney = chartData.first ?? 0
        lastMoney = chartData.last ?? 0
        priceChange = lastMoney - firstMoney
        lineColor = (priceChange > 0) ? Color.customizeColor.greenColor : Color.customizeColor.redColor
        endDate = Date(coinGeckoDateString: coin.lastUpdated ?? "")
        startDate = Date(coinGeckoDateString: coin.lastUpdated ?? "").addingTimeInterval(-7*24*60*60)
        
    }
    
    
    var body: some View {
        VStack {
            mainChartView
                .frame(height: 200)
                .background(
                    backgroundView
                )
                .overlay(
                     numberOverlay.padding(.horizontal, 4)
                    ,alignment: .leading
                )
            
            dateOverlay.padding(.horizontal, 4)
        }
        .onAppear {
              DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.linear(duration: 3.0)) {
                      percentChange = 1.0
                    }
                }
        }
        
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: developProvider.coinModel)
    }
}



extension ChartView {
    var mainChartView :some View {
        GeometryReader { geometry in
            Path{ path in
                
                for index in chartData.indices {
                    
                    let xPosition = geometry.size.width / CGFloat(chartData.count) * CGFloat(index+1)
                    
                    let yAxis = maxY - minY
                    let yPosition = (1 - CGFloat(
                        (chartData[index] - minY)
                    ) / yAxis) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x:xPosition,y:yPosition))
                    }
                    
                    
                     path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                
                }

            }
            .trim(from: 0, to: percentChange)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 3.0, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor.opacity(0.5), radius: 2)
            .shadow(color: lineColor.opacity(0.25), radius: 2)
            
        }
    }
    
    var backgroundView :some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    var numberOverlay:some View {
        
        VStack(alignment: .leading){
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY)/2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }.foregroundColor(Color.customizeColor.secondaryTextColor)

    }

    
    var dateOverlay:some View {
        
        HStack(){
            Text(startDate.returnShortDateString())
            Spacer()
            Text(endDate.returnShortDateString())
        }.foregroundColor(Color.customizeColor.secondaryTextColor)

    }
    
}
