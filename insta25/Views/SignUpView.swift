//
//  SignUpView.swift
//  insta25
//
//  Created by william plaetzer on 12/8/21.
//

import SwiftUI

struct SignUpView: View {
    
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
    
    
  
    
    func loadImage() {
        guard let inputImage = pickedImage else {return}
        
        profileImage = inputImage
    
}
    
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty ||
            username.trimmingCharacters(in: .whitespaces).isEmpty ||
            imageData.isEmpty{
            return "Please fill in all fields and select an Image"
        }
    
    return nil
    
    }
    
    func clear() {
        self.username = ""
        self.password = ""
        self.imageData = Data()
        self.profileImage = Image(systemName: "person.circle.fill")
    }
    
    
    
    
    
    
    func signUp() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            self.clear()
            return
        }
        AuthService.signUp(username: username, email: email, password: password, imageData: imageData, onSuccess: {
            (user) in
            self.clear()
        }) {
            (errorMessage) in
            print("Error\(errorMessage)")
            self.error = errorMessage
            self.showingAlert = true
            return
        }
    
    
    
    
    
    
    }
    
    
    
    
    
    

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(systemName: "camera").font(.system(size:60, weight: .black, design: .monospaced))
                
                VStack(alignment: .leading) {
                    Text("Welcome").font(.system(size: 32, weight: .heavy))
                    Text("Sign Up").font(.system(size: 16, weight: .medium))
                    
                    
                }
                
                VStack{
                    Group{
                        if profileImage != nil {
                            profileImage!.resizable().clipShape(Circle()).frame(width:100, height: 100).padding(.top, 20).onTapGesture {
                                self.showingActionSheet = true
                        }
                        } else {
                            Image(systemName: "person.circle.fill").resizable().clipShape(Circle()).frame(width: 100, height: 100).padding(.top, 20).onTapGesture {
                                self.showingActionSheet = true
                            }                    }
                }
            
                
                
                
                
                
                Group {
                FormField(value: $username, icon: "person.fill",placeholder: "Username")
                
                FormField(value: $email, icon: "envelope.fill",placeholder: "E-Mail")
                
                FormField(value: $password, icon: "lock.fill",placeholder: "Password", isSecure: true)
                }
                
                Button(action: signUp) {
                    Text("Sign Up").font(.title).modifier(ButtonModifer())
                }.alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle),message: Text(error),dismissButton: .default(Text("Ok")))
                }
                
                
                
            }.padding()
            }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
            }.actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text(""), buttons: [.default(Text("Chose A Photo")) {
                    
                    self.SourceType = .photoLibrary
                    self.showingImagePicker = true
                },.default(Text("Take a Picture")) {
                    self.SourceType = .camera
                    self.showingImagePicker = true
                }, .cancel()
                ])
            }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
}
