//
//  CircleButtonView.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/2.
//

import SwiftUI

struct CircleButtonView: View {
    
   var imageName:String
    
    var body: some View{
        Image(systemName: imageName)
            .font(.headline)
            .foregroundColor(Color.customizeColor.accentColor)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .fill(Color.customizeColor.backgroundColor)
                    .shadow(color: Color.customizeColor.accentColor.opacity(0.4), radius: 10)
            )
            .padding()
            
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        
        CircleButtonView(imageName: "info")
            .previewLayout(.sizeThatFits)
        
        CircleButtonView(imageName: "plus")
            .previewLayout(.sizeThatFits)
            .colorScheme(.dark)
    }
}
