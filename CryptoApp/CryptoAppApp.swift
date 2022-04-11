//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/2.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    
    @StateObject var homeviewModel:HomeViewModel = HomeViewModel()
    @State var showLaunchScreen:Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.customizeColor.accentColor)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.customizeColor.accentColor)]
    }
    
    
    var body: some Scene {
        
        
        WindowGroup {
            ZStack {
                NavigationView {
                HomeView()
                    .navigationBarHidden(true)
                }
                    .environmentObject(homeviewModel)
                
                ZStack{
                    if showLaunchScreen {
                        LaunchView(showLaunchScreen: $showLaunchScreen)
                            .transition(.move(edge: .leading))
                    }
                }.zIndex(2.0)
            }
            
        }
    
    }
}
