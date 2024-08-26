//
//  UploadImageResponse.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

public struct UploadImageResponse {
    let imagePaths: [String]
    
    public init(imagePaths: [String]) {
        self.imagePaths = imagePaths
    }
}
