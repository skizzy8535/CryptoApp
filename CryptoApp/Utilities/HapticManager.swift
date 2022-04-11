//
//  HapticManager.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/3/16.
//

import Foundation
import UIKit


class HapticManager {
    
    static let generator = UINotificationFeedbackGenerator()
    
    static func notificationType(type:UINotificationFeedbackGenerator.FeedbackType){
        
        generator.notificationOccurred(type)
        
    }
    
    
}

