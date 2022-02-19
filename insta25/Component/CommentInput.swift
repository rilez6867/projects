//
//  CommentInput.swift
//  insta25
//
//  Created by william plaetzer on 1/27/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CommentInput: View {
    
    @EnvironmentObject var session: SessionStore
    @ObservedObject var commentService = CommentService()
    @State private var text: String = ""
    
    
    
    init(post: PostModel?, postId: String?) {
        if post != nil {
            commentService.post = post
        } else {
            handleInput(postId: postId!)
        }
        return
      
    }


    
    func handleInput(postId: String) {
        PostService.loadPost(postId: postId) {
            (post) in
            self.commentService.post = post
        }
    }
    
    func sendComment() {
        if !text.isEmpty {
            commentService.addComment(comment: text)
                self.text = ""
            }
        }
        
    
    
    
    var body: some View {
        HStack() {
            WebImage(url: URL(string: session.session!.profileImageUrl)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 30, height: 30, alignment: .center)
                .shadow(color: .gray, radius: 3)
                .padding(.trailing)
            
            HStack {
                TextEditor(text: $text)
                    .frame(height: 50)
                    .padding(4)
                    .background(RoundedRectangle(cornerRadius: 8, style: .circular).stroke(Color.black, lineWidth: 2))
                
                
                Button(action: sendComment) {
                    Image(systemName: "paperplane").imageScale(.large).padding(.leading)
                }
            }
        }
    }
}

//struct CommentInput_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentInput()
//    }
//}
