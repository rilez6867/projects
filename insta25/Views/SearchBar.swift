//
//  SearchBar.swift
//  insta25
//
//  Created by william plaetzer on 1/4/22.
//

import SwiftUI
import Foundation

struct SearchBar: View {
   
    @Binding var value: String
  @State var isSearching = false
    
    
    
    
    var body: some View {
        HStack {
            TextField("Search users here",
                      text: $value).padding(.leading, 24)
            
        }.padding()
        .background(Color(.systemGray5))
        .cornerRadius(6.0)
        .padding(.horizontal)
        
        .onTapGesture(perform: {
            isSearching = true
        })
        
        .overlay(
            HStack{
                Image(systemName: "magnifyingglass")
                Spacer()
            
                Button(action:{value = ""}) {
                Image(systemName: "xmark.circle.fill")
            
                }
            
            }.padding(.horizontal, 32)
            .foregroundColor(.gray)
        
    )
}
}
        
        
       
    


//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBar()
//    }
//}
