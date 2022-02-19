//
//  Message.swift
//  insta25
//
//  Created by william plaetzer on 2/10/22.
//

import Foundation

struct Message: Encodable, Decodable, Identifiable {
    
    
    var id = UUID()
    var lastMessage: String
    var username: String
    var isPhoto: Bool
    var timestamp: Double
    var userId: String
    var profile: String
}
