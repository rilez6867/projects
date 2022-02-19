//
//  ButtonModifer.swift
//  insta25
//
//  Created by william plaetzer on 12/7/21.
//

import SwiftUI

struct ButtonModifer: ViewModifier {
    
    func body(content: Content) -> some View {
        content
        
            .frame(minWidth:0, maxWidth: .infinity)
            .frame(height:20)
            .padding()
            .foregroundColor(.white)
            .font(.system(size: 14, weight: .bold))
            .background(Color.black)
            .cornerRadius(5.0)
    }
    
    
    
}
