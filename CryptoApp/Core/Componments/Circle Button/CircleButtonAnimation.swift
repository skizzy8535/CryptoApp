//
//  CircleButtonAnimation.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/2.
//

import SwiftUI

struct CircleButtonAnimation: View {
    
    @Binding var animated:Bool
    
    
    var body: some View {
       Circle()
            .stroke(lineWidth: 3.0)
            .scale(animated ? 1.0 : 0.0)
            .opacity(animated ? 0.0 : 1.0)
            .animation(animated ? Animation.easeOut(duration: 1.0) : .none)
    }
}

struct CircleButtonAnimation_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimation(animated: .constant(true))
    }
}
