//
//  CommentService.swift
//  insta25
//
//  Created by william plaetzer on 1/16/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift




class CommentService: ObservableObject {
    
    
    @Published var isLoading = false
    @Published var comments: [CommentModel] = []
    
    
    var postId: String!
    var listener: ListenerRegistration!
    var post: PostModel!
    
    
    
    
    
    
    static var commentsRef = AuthService.storeRoot.collection("comments")
    
    static func commentsId(postId:String) -> DocumentReference {
        return commentsRef.document(postId)
    }
    
    
   
    func postComment(comment:String, username: String, profile:String,
                     ownerId:String, postId:String) {
        
        let comment = CommentModel( profile: profile, postId: postId, username: username, date: Date().timeIntervalSince1970, comment: comment, ownerId: ownerId)
        
        
        
        guard let dict = try? comment.asDictionary() else {
            return
        }
        CommentService.commentsId(postId: postId).collection("comments").addDocument(data: dict) {
            (err) in
            
            if let err = err {
                print("DEBUG: Error uploading comment \(err.localizedDescription)")
                return
            }
       
        
        
        }
    }
        
    static  func loadUserposts(postId: String, onSuccess: @escaping(_ comment: [CommentModel]) -> Void) {
         
         CommentService.commentsId(postId: postId).collection("comments").getDocuments{
             
         (snapshot,error) in
         
         guard let snap = snapshot else {
             print("Error")
             return
         }
         
         var comments = [CommentModel]()
             
             for doc in snap.documents {
                 let dict = doc.data()
                 guard let decoder = try? CommentModel.init(fromDictionary: dict)
                 
                 else {
                     return
                 }
                 comments.append(decoder)
             }
         
         onSuccess(comments)
         
         
         
         
     }
     
     
     
     
 }
 
 
 
        
        
    
    
    
    
    
    
    
    
        
        func getComments(postId: String, onSuccess: @escaping ([CommentModel])  -> Void, onError: @escaping(_ error: String) -> Void, newComment: @escaping(CommentModel) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
            
            
            let listenerPosts = CommentService.commentsId(postId: postId).collection("comments").order(by: "date", descending: false).addSnapshotListener {
                
                
                
                (snapshot, err) in
                
                guard let snapshot = snapshot else {return}
                
                
                var comments = [CommentModel]()
                
                
                snapshot.documentChanges.forEach{
                    (diff) in
                    
                    if (diff.type == .added) {
                        let dict = diff.document.description
                        guard let decoded = try?
                                CommentModel.init(fromDictionary: dict) else {
                            return
                        }
                        newComment(decoded)
                        comments.append(decoded)
                    }
                    
                    if (diff.type == .modified) {
                        
                    }
                
                    if (diff.type == .removed) {
                }
            }
            
            onSuccess(comments)
            
            
            }
        listener(listenerPosts)
        
        }
    
    func uploadComment(comment:String, username: String, profile:String,
                       ownerId:String, postId:String) {
        
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            return
        }

        guard let username = Auth.auth().currentUser?.displayName else {
            return
        }

        guard let profile = Auth.auth().currentUser?.photoURL?.absoluteString else {
            return
        }
        
        let comment = CommentModel( profile: profile, postId: post.postId , username: username, date: Date().timeIntervalSince1970, comment: comment, ownerId: currentUserId)
        
        guard let dict = try? comment.asDictionary() else {
            return
        }
        CommentService.commentsId(postId: postId).collection("comments").addDocument(data: dict) {
            (err) in
            
            if let err = err {
                print("DEBUG: Error uploading comment \(err.localizedDescription)")
                return
            }
       
        
        
        }
    }
        
    
    
    
        
//    func loadComment() {
//        self.comments = []
//        self.isLoading = true
//
//        fetchComments(postId: postId)
//        (comment) in
//        if !self.comments.isEmpty {
//            self.comments.append(comments)
//        }
//        }
//
    
    
    
    

//            func loadComments() {
//                self.comments = []
//                self.isLoading = true
//
//                loadUsercomments(postId: postId, onSuccess: {
//                    (comments) in
//
//                    if self.comments.isEmpty {
//                        self.comments = comments
//                    }
//
//                    if !self.comments.isEmpty {
//                        self.comments = comments
//                    }
//                }
//                })
                    
                func addComment(comment:String) {
                    guard let currentUserId = Auth.auth().currentUser?.uid else {
                        return
                    }

                    guard let username = Auth.auth().currentUser?.displayName else {
                        return
                    }

                    guard let profile = Auth.auth().currentUser?.photoURL?.absoluteString else {
                        return
                    }
                    
                    
                    postComment(comment: comment, username: username, profile: profile, ownerId: currentUserId, postId: self.post.postId)
                        
                     
                }
    
               func loadComments() {
                    self.comments = []
                    self.isLoading = true
    
                    loadUsercomments(postId: postId, onSuccess: {
                        (comments) in
    
                        if self.comments.isEmpty {
                            self.comments = comments
                        }
    
                        if !self.comments.isEmpty {
                            self.comments = comments
                        }
                    })
                    
    
    
    func fetchComment() {
        
        
        let query = CommentService.commentsId(postId: postId ).collection("comments").order(by: "date", descending: true)
        
        query.addSnapshotListener { snapshot, _ in
            guard let addedDocs = snapshot?.documentChanges.filter({ $0.type == .added}) else {return}
            self.comments = addedDocs.compactMap({ try? $0.document.data(as: CommentModel.self)})
            
            
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    guard let comment = try? change.document.data(as: CommentModel.self) else {return}
                    self.comments.append(comment)
                }
    })
    
    
            }
    
    }
    
    
    
    
    
    
    

    func loadUsercomments(postId: String, onSuccess: @escaping(_ comment: [CommentModel]) -> Void) {
     
     CommentService.commentsId(postId: postId).collection("comments").getDocuments{
         
     (snapshot,error) in
     
     guard let snap = snapshot else {
         print("Error")
         return
     }
     
     var comments = [CommentModel]()
         
         for doc in snap.documents {
             let dict = doc.data()
             guard let decoder = try? CommentModel.init(fromDictionary: dict)
             
             else {
                 return
             }
             comments.append(decoder)
         }
     
     onSuccess(comments)
     
     
     
     
 }
        
        
    
    
    func fetchComments(postId: String) {
      
        
        
        
        let listenerPosts = CommentService.commentsId(postId: postId).collection("comments").order(by: "date", descending: true)
        
        
        listenerPosts.addSnapshotListener {
            
            (snapshot,error) in
            snapshot?.documentChanges.forEach{
                (change) in
                if change.type == .added {
                    let dict = change.document.description
                    guard let comment = try?
                            CommentModel.init(fromDictionary: dict) else { return}
                        self.comments.append(comment)
                        
                }
            }
            
    }

}




    
}
}
}
