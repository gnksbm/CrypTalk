//
//  CreatePostRequest.swift
//  Coin
//
//  Created by gnksbm on 8/18/24.
//

import Foundation

public struct CreatePostRequest {
    public var accessToken: String
    let title: String?
    let content: String?
    let content1: String?
    let content2: String?
    let content3: String?
    let content4: String?
    let content5: String?
    let productID: String?
    let files: [String]?
    
    public init(
        accessToken: String,
        title: String?,
        content: String?,
        content1: String?,
        content2: String?,
        content3: String?,
        content4: String?,
        content5: String?,
        productID: String?,
        files: [String]?
    ) {
        self.accessToken = accessToken
        self.title = title
        self.content = content
        self.content1 = content1
        self.content2 = content2
        self.content3 = content3
        self.content4 = content4
        self.content5 = content5
        self.productID = productID
        self.files = files
    }
}

extension CreatePostRequest: AccessTokenProvider { }

extension CreatePostRequest: BodyProvider {
    public var body: Body {
        Body(
            title: title,
            content: content,
            content1: content1,
            content2: content2,
            content3: content3,
            content4: content4,
            content5: content5,
            productID: productID,
            files: files
        )
    }
    
    public struct Body: Encodable {
        let title: String?
        let content: String?
        let content1: String?
        let content2: String?
        let content3: String?
        let content4: String?
        let content5: String?
        let productID: String?
        let files: [String]?
        
        enum CodingKeys: String, CodingKey {
            case title
            case content
            case content1
            case content2
            case content3
            case content4
            case content5
            case productID = "product_id"
            case files
        }
    }
}
