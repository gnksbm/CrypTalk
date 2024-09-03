//
//  UpdateProfileRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

import Moya

public struct UpdateProfileRequest {
    public var accessToken: String
    let nick: String?
    let phoneNum: String?
    let birthDay: String?
    let profile: Data?
}

extension UpdateProfileRequest: AccessTokenProvider { }

extension UpdateProfileRequest: MultipartFormDataProvider {
    public var key: String { "" }
    public var data: [Data] { [] }
    
    public func toMultipartFormData() -> [MultipartFormData] {
        Mirror(reflecting: self).children.compactMap { (key, value) in
            guard let key else { return nil }
            if key == "profile",
               let data = value as? Data {
                   return MultipartFormData(
                       provider: .data(data),
                       name: "profile",
                       fileName: "profile.jpg",
                       mimeType: "image/jpeg"
                   )
            } else if let str = value as? String,
                      let data = str.data(using: .utf8) {
                return MultipartFormData(provider: .data(data), name: key)
            } else {
                return nil
            }
        }
    }
}
