//
//  SwiftUIView.swift
//  insta25
//
//  Created by william plaetzer on 12/16/21.
//

import Foundation


struct User: Encodable, Decodable {
    var uid:String
    var email: String
    var profileImageUrl:String
    var username:String
    var searchName:[String]
}

