//
//  Profile.swift
//  insta25
//
//  Created by william plaetzer on 12/22/21.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseAuth

struct Profile: View {
    @EnvironmentObject var session: SessionStore
    @ State private var selection = 1
    @StateObject var profileService = ProfileService()
    @State private var isLinkActive = false
    
    
    let threeColumns = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
//        NavigationView {
        ScrollView {
        VStack {
            ProfileHeader(user: self.session.session, postsCount: profileService.posts.count, following: $profileService.following, followers: $profileService.followers)
        
            NavigationLink(destination: EditProfile(session: self.session.session), isActive: $isLinkActive){
            Button(action: {self.isLinkActive = true}) {
                Text("Edit Profile").font(.title).modifier(ButtonModifer())
            }.padding(.horizontal)
        }.padding(.horizontal)
            Picker("", selection: $selection) {
                Image(systemName: "circle.grid.2x2.fill").tag(0)
                Image(systemName: "person.circle").tag(1)
            }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal)
            if selection == 0 {
                LazyVGrid(columns: threeColumns) {
                    ForEach(self.profileService.posts, id:\.postId) {
                     (post) in
                        
                        WebImage(url: URL(string: post.mediaURL)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.height/3).clipped()
                    }
                }
            }
            else {
                if(self.session.session == nil) { Text("")}
                else {
                ScrollView{
                    VStack{
                        ForEach(self.profileService.posts, id:\.postId) {
                            (post) in
                            PostCardImage(post:post)
                            PostCard(post:post)
                        }
                    }
                }
            }
            
            }
        
        
        }.navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        
        
        .navigationBarItems(leading: Button(action: {
            self.session.logout()
        }) {
            
            NavigationLink(destination: UserProfile()) {
            Image(systemName: "person.fill")
            }
            
            
        }, trailing: Button(action: {}) {
            Image(systemName: "arrow.right.circle.fill")
        })
        .onAppear{
            self.profileService.loadUserPosts(userId: Auth.auth().currentUser!.uid)
        }
        
}
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}


}
