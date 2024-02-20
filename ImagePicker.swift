//
//  ImagePicker.swift
//
//  Created by Dan Gullis on 19/02/2024.
//

//ObservableObject: A protocol that allows SwiftUI to observe changes to a class's properties. When a property marked with @Published changes, any views observing the object will be notified and re-rendered with the new data.

//@Published: A property wrapper that marks a property as observable. When the value of a @Published property changes, it notifies any views that are observing the object to update their state.

//@StateObject: A property wrapper used in SwiftUI to create and manage a reference to an observable object. It ensures that the object it wraps remains alive for use in the view where it is declared and in any views that share it. This is particularly important for objects that conform to the ObservableObject protocol.

//The use of ObservableObject, @StateObject, and @Published in SwiftUI allows for a reactive programming model where the UI automatically updates in response to changes in the underlying data model.

// this class uses SwiftUI and PhotosUI framework to select images form the user photo library
// uses cloudinary framework to upload selected image to cloudinary account

import SwiftUI
import PhotosUI
import Cloudinary

class ImagePicker: ObservableObject {
    // variable to store image data once its loaded
    @Published var imageData: Data?
    // varible to represent the selected item - when this changes the didset block is executed
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            if let imageSelection {
                Task {
                    try await loadTransferable(from: imageSelection)
                }
            }
        }
    }
    // asynchronous function loads image data from selected photoPickerItem
    // if sucessful assigns image data to imageData variable
    func loadTransferable(from imageSelection: PhotosPickerItem?) async throws {
        do {
            if let imageData = try await imageSelection?.loadTransferable(type: Data.self) {
                self.imageData = imageData
            }
        } catch {
            print(error.localizedDescription)
            imageData=nil
        }
    }
    
    // uploads image data to cloudinary returns public ID of image on completion
    func uploadToCloudinary(data: Data, completion: @escaping (String?) -> Void){
        let config = CLDConfiguration(cloudName: "dbhtb2iqe", secure: true)
        let cloudinary = CLDCloudinary(configuration: config)
        let uploader = cloudinary.createUploader()
        
        let uploadParams = CLDUploadRequestParams().setFolder("acebook-mobile")
        
        uploader.upload(data: data, uploadPreset: "acebook-user-image", params: uploadParams, completionHandler:  {result, error in
            if let error = error {
                print("upload error \(error)")
                completion(nil)
            } else if let result = result, let imagePublicId = result.publicId {
                completion(imagePublicId)
            } else {
                completion(nil)
            }
            
        })
        
    }
    
}
