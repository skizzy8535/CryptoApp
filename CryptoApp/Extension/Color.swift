//
//  Color.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/2.
//

import Foundation
import SwiftUI


extension Color {
    
    static let customizeColor = ManualCustomizeColor()
    static let launchScreenColor = LaunchScreenColor()
}



struct ManualCustomizeColor{
    
    let accentColor = Color("AccentColor")
    let backgroundColor = Color("BackgroundColor")
    let redColor = Color("RedColor")
    let greenColor = Color("GreenColor")
    let secondaryTextColor = Color("SecondaryTextColor")
  
    
}




struct LaunchScreenColor{
    let accentColor = Color("LaunchAccent")
    let backgroundColor = Color("LaunchBackground")
}
