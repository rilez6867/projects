//
//  ProfileHeader.swift
//  insta25
//
//  Created by william plaetzer on 12/27/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileHeader: View {
    var user: User?
   
    var postsCount: Int
    @Binding var following: Int
    @Binding var followers: Int
    
    var body: some View {
        VStack{
            if user != nil {
                WebImage(url: URL(string: user!.profileImageUrl)!)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100, alignment: .trailing).padding(.leading)
            } else {
                
                Color.init(red: 0.9, green: 0.9, blue: 0.9).frame(width:100, height: 100, alignment: .trailing).padding(.leading)
                
                
            }
            
            Text(user!.username).font(.headline).bold().padding(.leading)
        
            
        }
        VStack{
            HStack{
                Spacer()
                VStack{
                    Text("Posts").font(.footnote)
                    Text("\(postsCount)").font(.title).bold()
                }.padding(.top, 60)
                
                
                
                Spacer()
                VStack{
                    Text("Admirers").font(.headline)
                    Text("\(followers)").font(.title).bold()
                }.padding(.top, 60)
                Spacer()
                VStack {
                    Text("Keeping up with").font(.headline)
                    Text("\(following)").font(.title).bold()
                }.padding(.top, 60)
                Spacer()
                    
                    
                }
            }
        }
    }


//struct ProfileHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileHeader()
//    }
//}
