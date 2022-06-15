//
//  Double.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/3.
//

import Foundation



extension Double {
    
    
     var currencyto2Digits:NumberFormatter{
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func transformValueToTwoDigits() -> String{
        let number = NSNumber(value: self)
        return currencyto2Digits.string(from: number) ?? "$0.0"
    }
    
    func transformNumToTwoDigits() -> String{
        return String(format: "%.2f", self)
    }
    
    func transformPercentToTwoDigits() -> String{
        return transformNumToTwoDigits() + "%"
    }
    
    
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.transformNumToTwoDigits()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.transformNumToTwoDigits()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.transformNumToTwoDigits()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.transformNumToTwoDigits()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.transformNumToTwoDigits()

        default:
            return "\(sign)\(self)"
        }
    }
    
}
