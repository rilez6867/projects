//
//  Dumb.swift
//  insta25
//
//  Created by william plaetzer on 2/6/22.
//

import Foundation



//
//func loadComment() {
//self.comments = []
//self.isLoading = true
//
//CommentService.loadUsercomments(postId: postId, onSuccess: {
//    (comments) in
//
//    if self.comments.isEmpty {
//        self.comments = comments
//    }
//
//    if !self.comments.isEmpty {
//        self.comments = comments
//    }
//}
//)
//
//
//
//    func loadUsercomments(postId: String, onSuccess: @escaping(_ comment: [CommentModel]) -> Void) {
//
//     CommentService.commentsId(postId: postId).collection("comments").getDocuments{
//
//     (snapshot,error) in
//
//     guard let snap = snapshot else {
//         print("Error")
//         return
//     }
//
//     var comments = [CommentModel]()
//
//         for doc in snap.documents {
//             let dict = doc.data()
//             guard let decoder = try? CommentModel.init(fromDictionary: dict)
//
//             else {
//                 return
//             }
//             comments.append(decoder)
//         }
//
//     onSuccess(comments)
//
//
//
//
// }
