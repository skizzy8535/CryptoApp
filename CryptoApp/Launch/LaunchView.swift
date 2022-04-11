//
//  LaunchView.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/4.
//

import SwiftUI

struct LaunchView: View {
    
    @State var lauchScreenWord:[String] = "Loading your portfolio...".map({String($0)})
    
    @Binding var showLaunchScreen:Bool
    @State var launchScreenTextAnimation = false
    @State var count :Int = 0
    @State var round : Int = 0
    @State var timer = Timer.publish(every: 0.08, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        
        ZStack{
            
            Color.customizeColor.backgroundColor.ignoresSafeArea()
            
            Image("CryptoTranspent")
                .resizable()
                .frame(width: 100, height: 100)
    
            
       ZStack{
                
                if launchScreenTextAnimation{
                    HStack(spacing:0){
                        ForEach(lauchScreenWord.indices) { index in
                              Text(lauchScreenWord[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .offset(y: count == index ? -6 : 0)
                        }
                    }.transition(AnyTransition.scale.animation(.easeIn))
                    
                }
            }.offset(y: 80)
            
        
        }.onAppear(perform: {
            launchScreenTextAnimation.toggle()
        })
        .onReceive(timer) { _ in
            
            withAnimation(.spring()) {
                let lastIndex = lauchScreenWord.count-1
                
                if count == lastIndex {
                    count = 0
                    round += 1
                    
                    if round >= 2 {
                        showLaunchScreen = false
                    }
                }else{
                    count += 1
                }
            }
        }
        
       
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchScreen: .constant(true))
    }
}
