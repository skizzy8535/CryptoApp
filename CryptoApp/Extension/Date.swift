//
//  Date.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/4/4.
//

import Foundation


extension Date {
    
    init(coinGeckoDateString:String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: coinGeckoDateString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    
    private var shortFormatter:DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    
    func returnShortDateString() -> String {
        return shortFormatter.string(from: self)
    }
    
    
    
    
}
