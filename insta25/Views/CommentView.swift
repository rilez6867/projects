//
//  CommentView.swift
//  insta25
//
//  Created by william plaetzer on 1/29/22.
//

import SwiftUI

struct CommentView: View {
    
   @StateObject var commentService = CommentService()
     var comments: [CommentModel] = []
    var post: PostModel?
    var postId: String?
    
    
    
    
    
    
    
    
    var body: some View {
        VStack(spacing: 10){
            ScrollView{
                if !commentService.comments.isEmpty{
                    ForEach(commentService.comments) {
                        (comment) in
                        CommentCard(comment: comment).padding()
                    }
                }
            }
            CommentInput(post: post, postId: postId)
        }
        .navigationTitle("Comments")
        
        .onAppear{
            self.commentService.postId = self.post == nil ? self.postId : self.post?.postId 
            
            self.commentService.loadComments()
        }
        
        .onDisappear{
            if self.commentService.listener != nil {
                self.commentService.listener.remove()
            }
        }
        
        
    }
        
     
//    mutating func loadUsercomments(postId: String) {
//        CommentService.loadUsercomments(postId: postId) {
//            (comments) in
//            self.comments = comments
//        }

//struct CommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentView()
//    }
//}
    }


