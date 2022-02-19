//
//  SearchService.swift
//  insta25
//
//  Created by william plaetzer on 1/5/22.
//

import Foundation
import FirebaseAuth


class SearchService {
    
    static func searchUser(input:String, onSuccess: @escaping (_ user: [User]) -> Void) {
    
    
        AuthService.storeRoot.collection("users").whereField("searchName",
                                                             arrayContains:input.lowercased().removeWhiteSpace()                                               ).getDocuments {
               (querySnapShot, err) in
                                                                
                                                                guard let snap = querySnapShot else {
                                                                    print("error")
                                                                    return
                                                                }
                                                            var users = [User]()
                                                                for document in snap.documents {
                                                                    let dict = document.data()
                                                                
                                                                
                                                                    guard let decoded = try? User.init(fromDictionary: dict)
                                                                    else {return}
                                                                    
                                                                    if decoded.uid != Auth.auth().currentUser!.uid {
                                                                        users.append(decoded)
                                                                    }
                                                                onSuccess(users)
                                                                
                                                                }
                                                             
                                                             
                                                             
                                                             
                                                             }
    
    
    
    
    
    
    
    
    
    
    }
    
    
    
    
    
    
    
    
    
    
    
}
