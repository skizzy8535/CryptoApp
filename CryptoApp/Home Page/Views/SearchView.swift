//
//  SearchView.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/19.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var searchText :String
    
    var body: some View{
        
        
        HStack(spacing:4) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.customizeColor.secondaryTextColor : Color.customizeColor.accentColor)
            
            TextField("Search by name or symbol .... ", text: $searchText)
                .disableAutocorrection(true)
                .foregroundColor(Color.customizeColor.accentColor)
                .overlay(
                  Image(systemName: "x.circle.fill")
                      .foregroundColor(Color.customizeColor.accentColor)
                      .offset(x: 10)
                      .onTapGesture {
                          UIApplication.shared.endEditing()
                          searchText = ""
                      }
                      .opacity(searchText.isEmpty ? 0.0 : 1.0)
                  ,alignment: .trailing
                )
              
        } .font(.headline)
          .padding()
          .background(
            RoundedRectangle(cornerRadius: 20.0)
                .fill(Color.customizeColor.backgroundColor)
                .shadow(
                    color: Color.customizeColor.accentColor.opacity(0.1),
                    radius: 10, x: 0, y: 0)
          )
          .padding()
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            SearchView(searchText: .constant(""))
                .previewLayout(.sizeThatFits)
                
            SearchView(searchText: .constant(""))
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark)
        }
        
    }
}
