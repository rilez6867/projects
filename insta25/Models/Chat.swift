//
//  Chat.swift
//  insta25
//
//  Created by william plaetzer on 2/10/22.
//

import Foundation
import Firebase
import FirebaseAuth

struct Chat: Encodable, Decodable, Hashable {
    
    var messageId: String
    var textMessage: String
    var profile: String
    var photoUrl: String
    var sender: String
    var username: String
    var timestamp: Double
    var isCurrentUser: Bool {
        return Auth.auth().currentUser!.uid == sender
    }
    var isPhoto: Bool
}
