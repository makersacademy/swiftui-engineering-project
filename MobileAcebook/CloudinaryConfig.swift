//
//  CloudinaryConfig.swift
//  MobileAcebook
//
//  Created by Dan Gullis on 20/02/2024.
//

import Cloudinary

struct CloudinaryConfig {
    static let cloudName = "dbhtb2iqe"
    static let secure = true
    
    static var configuration: CLDConfiguration {
        return CLDConfiguration(cloudName: cloudName, secure: secure)
    }
}
