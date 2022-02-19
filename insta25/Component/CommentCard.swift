//
//  CommentCard.swift
//  insta25
//
//  Created by william plaetzer on 1/28/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CommentCard: View {
    
    var comment: CommentModel
    
    
    
    
    
    
    
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: comment.profile)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 30, height: 30, alignment: .center)
                .shadow(color: .gray, radius: 3)
                .padding(.leading)
            
            VStack(alignment: .leading){
                Text(comment.username).font(.subheadline).bold()
                Text(comment.comment).font(.caption)
            }
            Spacer()
            
            
            Text((Date(timeIntervalSince1970: comment.date)).timeAgo() + " ago").font(.subheadline)
        }
    }
}
