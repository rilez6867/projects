//
//  PostModel.swift
//  insta25
//
//  Created by william plaetzer on 12/24/21.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseFirestoreSwift

struct PostModel: Encodable, Decodable {
    
    var caption: String
    var ownerId: String
    var postId: String
    var username: String
    var profile:String
    var mediaURL: String
    var date: Double
    var likes: [String: Bool]
    var likeCount: Int
    
    
    
    
    
    
    
}
