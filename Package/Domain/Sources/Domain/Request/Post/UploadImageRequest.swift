//
//  UploadImageRequest.swift
//  Coin
//
//  Created by gnksbm on 8/18/24.
//

import Foundation

import Moya

public struct UploadImageRequest {
    public var accessToken: String
    public let data: [Data]
    
    public init(
        accessToken: String,
        data: [Data]
    ) {
        self.accessToken = accessToken
        self.data = data
    }
}

extension UploadImageRequest: AccessTokenProvider { }

extension UploadImageRequest: BodyProvider {
    public var body: Body { Body(data: data) }
    
    public struct Body: Encodable {
        let data: [Data]
    }
}

extension UploadImageRequest: MultipartFormDataProvider {
    public var key: String { "files" }
    
    public func toMultipartFormData() -> [MultipartFormData] {
        imageToMultipartFormData()
    }
}
