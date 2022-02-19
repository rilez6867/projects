//
//  ChatService.swift
//  insta25
//
//  Created by william plaetzer on 2/10/22.
//

import Foundation
import FirebaseAuth
import Firebase


class ChatService: ObservableObject {
    
    @Published var isLoading = false
    @Published var chats: [Chat] = []
    
    
    var listener: ListenerRegistration!
    var recipientId = ""
    
    
    
    
    
    static var chats = AuthService.storeRoot.collection("chats")
    
    static var messages = AuthService.storeRoot.collection("messages")
    
    static func conversation(sender: String, recipient: String) -> CollectionReference {
        return chats.document(sender).collection("chats").document(recipient).collection("conversation")
        
    }
    static func userMessages(userid: String) -> CollectionReference {
        return messages.document(userid).collection("messages")
        
        
    }
    
    static func messagesId(senderId: String, recipientId: String) -> DocumentReference {
        return messages.document(senderId).collection("messages").document(recipientId)
    }
    
    
    func loadChats() {
        
        self.chats = []
        self.isLoading = true
        
        self.getChats(userId: recipientId, onSuccess: {
          (chats) in
            if self.chats.isEmpty {
                self.chats = chats
            }

            if !self.chats.isEmpty {
                self.chats = chats
            }
        })
    }
    
    func sendMessage(message:String, recipientId: String, recipientProfile:String, recipientName: String) {
        
        guard let senderId = Auth.auth().currentUser?.uid else {return}
        
        guard let senderUsername = Auth.auth().currentUser?.displayName else {return}
        
        
        guard let senderProfile = Auth.auth().currentUser?.photoURL!.absoluteString else {return}
        
        let messageId = ChatService.conversation(sender: senderId, recipient: recipientId).document().documentID
        
        
        let chat = Chat(messageId: messageId, textMessage: message, profile: senderProfile, photoUrl:"" , sender: senderId, username: senderUsername, timestamp: Date().timeIntervalSince1970, isPhoto: false)
        
        guard let dict = try? chat.asDictionary() else {return}
        
        
        ChatService.conversation(sender: senderId, recipient: recipientId).document(messageId).setData(dict) {
            (error) in
            
            
            if error == nil {
                ChatService.conversation(sender: recipientId, recipient: senderId).document(messageId).setData(dict)
                
                let senderMessage = Message(lastMessage: message, username: senderUsername, isPhoto: false, timestamp: Date().timeIntervalSince1970, userId: senderId, profile: senderProfile)
                
                let recipientMessage = Message(lastMessage: message, username: recipientName, isPhoto: false, timestamp: Date().timeIntervalSince1970, userId: recipientId, profile: recipientProfile)
                
                guard let senderDict = try? senderMessage.asDictionary() else {return}
                
                guard let recipientDict = try? recipientMessage.asDictionary() else {return}
                
                ChatService.messagesId(senderId: senderId, recipientId: recipientId).setData(senderDict)
                ChatService.messagesId(senderId: recipientId, recipientId: senderId).setData(recipientDict)
                
                
                
                
                
                
                
            }
        }
        
        
        
        
        
    }
    
    
    
    
    func sendPhotoMessage(imageData: Data, recipientId: String, recipientProfile: String, recipientName: String) {
        
        guard let senderId = Auth.auth().currentUser?.uid else {return}
        
        guard let senderUsername = Auth.auth().currentUser?.displayName else {return}
        
        
        guard let senderProfile = Auth.auth().currentUser?.photoURL!.absoluteString else {return}
        
        
        let messageId = ChatService.conversation(sender: senderId, recipient: recipientId).document().documentID
        
        let storageChatRef = StorageService.storagechatId(chatId: messageId)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        StorageService.saveChatPhoto(messageId: messageId, recipientId: recipientId, recipientProfile: recipientProfile, recipientName: recipientName, senderId: senderId, senderUsername: senderUsername, imageData: imageData, metadata: metadata, storageChatRef: storageChatRef, senderProfile: senderProfile)
        
    
        
    }
    
    func getChats(userId: String, onSuccess: @escaping([Chat]) -> Void) {
        
        let listenerChat = ChatService.conversation(sender: Auth.auth().currentUser!.uid, recipient: userId).order(by: "timestamp", descending: false)
            
            listenerChat.addSnapshotListener{
            (snapshot, error) in
            
            
            guard let snap = snapshot else {
                return
            }
            
            var Chats = [Chat]()
            
            snap.documentChanges.forEach{
                (diff) in
                
                if(diff.type == .added) {
                    let dict = diff.document.data()
                    
                    guard let decoded = try? Chat.init(fromDictionary: dict) else {
                        return
                    }
                    
                    Chats.append(decoded)
                }
                
                
                func getMessages() {
                    
                    
                    let listenerMessenger = ChatService.userMessages(userid: Auth.auth().currentUser!.uid).order(by: "timestamp", descending: true)
                        listenerMessenger.addSnapshotListener {
                        (snapshot, error) in
                        
                        
                        guard let snap = snapshot else {
                            return
                        }
                        
                        var messages = [Message]()
                        
                        snap.documentChanges.forEach{
                            (diff) in
                            
                            if(diff.type == .added) {
                                let dict = diff.document.data()
                                
                                
                                guard let decoded = try? Message.init(fromDictionary: dict) else {
                                    return
                                }
                                
                                messages.append(decoded)
                        
                    }
                    
                    
                }
            
            
            
            
            
            
            
            
            
            }
            
        }
        
        
        
    }
    
    
}
    }
}
