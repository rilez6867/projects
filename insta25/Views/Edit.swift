//
//  Edit.swift
//  insta25
//
//  Created by william plaetzer on 2/6/22.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import SDWebImageSwiftUI


struct EditProfile: View {
    
    
    @EnvironmentObject var session: SessionStore
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    @State private var profileImage:Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    
    @State private var imageData: Data = Data()
    @State private var SourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Something went wrong"
    

    
    init(session: User?) {
        _username = State (initialValue: session?.username ?? "")
    }
    
    func loadImage() {
        guard let inputImage = pickedImage else {return}
        
        profileImage = inputImage
    
}
    
    
    func errorCheck() -> String? {
        if username.trimmingCharacters(in: .whitespaces).isEmpty || imageData.isEmpty {
        return "Please fill in all fields and select an Image"
    }
        return nil
    }
    
    
        func clear() {
            self.username = ""
            self.imageData = Data()
            self.profileImage = Image(systemName: "person.circle.fill")
        }
        
        func edit() {
            if let error = errorCheck() {
                self.error = error
                self.showingAlert = true
                clear()
                return
            }
            
            guard let userId = Auth.auth().currentUser?.uid else {return}
            
            let storageProfileUserId = StorageService.storageProfileId(userId: userId)
            
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            
            StorageService.editProfile(userId: userId, username: username, imageData: imageData, metaData: metadata, storageProfileImageRef:storageProfileUserId, onError: {
                
                (errorMessage) in
                
                self.error = errorMessage
                self.showingAlert = true
                return
                
            
            
            
            
            
            })
            clear()
        }
    
        
    
    
    
    var body: some View {
        ScrollView {
            VStack (spacing: 20){
                
                Text("Edit Profile").font(.largeTitle)
                
                VStack{
                    Group{
                        if profileImage != nil {
                            profileImage!.resizable()
                                .clipShape(Circle())
                                .frame(width: 200, height: 200)
                                .padding(.top, 20)
                                .onTapGesture {
                                    self.showingActionSheet = true
                                }
                            
                        } else {
                            WebImage(url: URL(string: session.session!.profileImageUrl))
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 100, height: 100)
                                .padding(.top, 20)
                                .onTapGesture {
                                    self.showingActionSheet = true
                                }
                        }
                    }
                }
       
            FormField(value: $username, icon: "person.fill", placeholder: "Username")
            
                Button(action: edit) {
                    Text("Edit").font(.title).modifier(ButtonModifer())
                }.padding()
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle),message: Text(error),dismissButton: .default(Text("Ok")))
            
            }
            
            }
        
        
            
        
        
       
    }

}
//struct Edit_Previews: PreviewProvider {
//    static var previews: some View {
//        Edit()
//    }
//}


}


