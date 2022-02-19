//
//  UserProfileView.swift
//  insta25
//
//  Created by william plaetzer on 1/15/22.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseAuth
struct UserProfileView: View {
   
    var user: User
    
    @StateObject var profileService = ProfileService()
    @ State private var selection = 1
    
    let threeColumns = [GridItem(), GridItem(), GridItem()]
    
    
    
    
    
    
    
    var body: some View {
        ScrollView {
        ProfileHeader(user: user, postsCount: profileService.posts.count, following:
                        $profileService.following, followers:
                            $profileService.followers)
            HStack{
                FollowButton(user: user, followCheck: $profileService.followCheck, followingCount: $profileService.following, followersCount: $profileService.followers)
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
           
            
            
            
            }  else {
//                    if(self.session.session == nil) { Text("")}
//                    else {
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
                
        }.navigationBarTitle(Text(self.user.username))
        .onAppear{
            self.profileService.loadUserPosts(userId:  self.user.uid)
        }

//struct UserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfileView()
//    }
//}
}
}
