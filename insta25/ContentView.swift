//
//  ContentView.swift
//  insta25
//
//  Created by william plaetzer on 12/5/21.
//

import SwiftUI

struct ContentView: View {
   
    
    
    @EnvironmentObject var session: SessionStore
    
    func listen() {
        session.listen()
    }
    
    var body: some View {
       
        Group{
            if(session.session != nil) {
                HomeView()
            } else {
                SignInView()
            }
        }.onAppear(perform: listen)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
