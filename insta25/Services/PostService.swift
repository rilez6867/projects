//
//  PostService.swift
//  insta25
//
//  Created by william plaetzer on 12/24/21.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage


struct PostService {
    
    static var Posts = AuthService.storeRoot.collection("posts")
    static var AllPosts = AuthService.storeRoot.collection("allPosts")
    static var Timeline = AuthService.storeRoot.collection("timeline")
    
    

    
    static func PostsUserId(userId: String) -> DocumentReference {
        return Posts.document(userId)
    }
    
    static func timelineUserId(userId:String) -> DocumentReference {
        return Timeline.document(userId)
    }
    

    
    static func uploadPost(caption:String, imageData: Data, onSucess: @escaping()-> Void, onError: @escaping (_ errorMessage: String)-> Void) {
        
        
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
            
            
            
        }
        
        let postId = PostService.PostsUserId(userId: userId).collection("posts").document().documentID
        
        
        
        let storagePostRef = StorageService.storagePostId(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        
        StorageService.savePostPhoto(userId: userId, caption: caption, postId: postId, imageData: imageData, metadata: metadata, storagePostRef: storagePostRef, onSucess: onSucess, onError: onError)
        
    }
    
    
    static func loadPost(postId: String, onSuccess: @escaping(_ post:
                                                                PostModel)-> Void) {
        PostService.AllPosts.document(postId).getDocument {
            (snapshot, err) in
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            let dict = snap.data()
            
            
            guard let decoded = try? PostModel.init(fromDictionary: dict!) else {
                return
            }
        
        onSuccess(decoded)
        
        
        }
        
        
        
        
        
        
    }
    
    
    
    
    
       static  func loadUserposts(userId: String, onSuccess: @escaping(_ posts: [PostModel]) -> Void) {
            
            PostService.PostsUserId(userId: userId).collection("posts").getDocuments{
                
            (snapshot,error) in
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
            var posts = [PostModel]()
                
                for doc in snap.documents {
                    let dict = doc.data()
                    guard let decoder = try? PostModel.init(fromDictionary: dict)
                    
                    else {
                        return
                    }
                    posts.append(decoder)
                }
            
            onSuccess(posts)
            
            
            
            
        }
        
        
        
        
    }
    
    
    }

