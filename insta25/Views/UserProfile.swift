//
//  UserProfile.swift
//  insta25
//
//  Created by william plaetzer on 1/6/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserProfile: View {
   
    
    @State private var value: String = ""
    @State var users: [User] = []
    @State var isLoading = false
    
    
    func searchhUsers() {
        isLoading = true
        SearchService.searchUser(input: value) {
            (users) in
            self.isLoading = false
            self.users = users
        }
    }
    
    
    
    
    
    
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: . leading){
                SearchBar(value: $value).padding().onChange(of: value, perform: {
                    new in
                    searchhUsers()
                })
            
                if !isLoading {
                    ForEach(users, id:\.uid) {
                        user in
                        
                        NavigationLink(destination: UserProfileView(user: user)) {
                        
                        HStack{
                            WebImage(url: URL(string: user.profileImageUrl)!)
                                .resizable()
                                .padding()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 60, height: 60, alignment: .trailing)
                            
                            
                            
                            
                            
                            
                            
                            Text(user.username).font(.subheadline).bold()
                        }
                      //  Divider().background(Color.black)
                    }
                }
                }
            
            }
        }.navigationTitle("User Search")
    }
}


struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
