//
//  UIApplication.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/20.
//

import Foundation
import UIKit


extension UIApplication{
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil , for: nil )
    }
    
    
}
