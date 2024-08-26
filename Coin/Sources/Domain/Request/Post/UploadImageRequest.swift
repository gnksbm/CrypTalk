//
//  UploadImageRequest.swift
//  Coin
//
//  Created by gnksbm on 8/18/24.
//

import Foundation

import Moya

struct UploadImageRequest {
    var accessToken: String
    let data: [Data]
}

extension UploadImageRequest: AccessTokenProvider { }

extension UploadImageRequest: MultipartFormDataProvider {
    var key: String { "files" }
    
    func toMultipartFormData() -> [MultipartFormData] {
        imageToMultipartFormData()
    }
}
