//
//  String.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/4/5.
//

import Foundation

extension String{
    
    var removeHTMLOccurrences:String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
