//
//  Post.swift
//  insta25
//
//  Created by william plaetzer on 12/23/21.
//

import SwiftUI

struct Post: View {
  
    @State private var postImage:Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    
    @State private var imageData: Data = Data()
    @State private var SourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Something went wrong"
    @State private var text = ""
    
    
    func loadImage() {
        guard let inputImage = pickedImage else {return}
        
        
        postImage = inputImage
    }
    
    
    func uploadPost() {
        
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
          
            return
        }
        PostService.uploadPost(caption: text, imageData: imageData, onSucess:{
            self.clear()
        }) {
            (errorMessage) in
            
            print("Error \(errorMessage)")
            self.error = errorMessage
            self.showingAlert = true
            return
        }
        
        
        
        
    }
    
    
    func clear() {
        self.text = ""
        self.imageData = Data()
        self.postImage = nil
    }
    
    func errorCheck() -> String? {
        if text.trimmingCharacters(in: .whitespaces).isEmpty || imageData.isEmpty {
            return "Please add caption and image"
        }
    
    return nil
    
    }
    
    
    
    
    
    
    var body: some View {
        VStack {
            Text("Upload A Post").font(.largeTitle)
            
            VStack {
                if postImage != nil {
                    postImage!.resizable().frame(width: 300, height: 200).onTapGesture {
                        self.showingActionSheet = true
                        
                    }
                    
                    
                } else {
                    Image(systemName: "photo.fill").resizable().frame(width: 300, height: 200)
                        .onTapGesture {
                            self.showingActionSheet = true
                        }
                }
            
            
            
            }
            
            TextEditor(text: $text).frame(height: 200).padding(4).background(RoundedRectangle(cornerRadius: 8).stroke(Color.black)).padding(.horizontal)
            
            
            Button(action: uploadPost) {
                Text("Upload Post").font(.title).modifier(ButtonModifer())
            }
            
        
            
        }.padding()
        
    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
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

struct Post_Previews: PreviewProvider {
    static var previews: some View {
        Post()
    }
}
