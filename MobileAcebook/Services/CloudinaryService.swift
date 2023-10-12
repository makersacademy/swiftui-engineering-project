//
//  CloudinaryService.swift
//  MobileAcebook
//
//  Created by Alice Birkett on 12/10/2023.
//

import Foundation
import Cloudinary

class CloudinaryService {
    let config: CLDConfiguration
    let cloudinary: Any
    
    init() {
        self.config = CLDConfiguration(cloudName: "CLOUD_NAME", apiKey: "API_KEY")
        self.cloudinary = CLDCloudinary(configuration: config)
    }
}
