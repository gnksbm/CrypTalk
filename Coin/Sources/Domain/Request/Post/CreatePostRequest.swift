//
//  CreatePostRequest.swift
//  Coin
//
//  Created by gnksbm on 8/18/24.
//

import Foundation

struct CreatePostRequest {
    var accessToken: String
    let title: String?
    let content: String?
    let content1: String?
    let content2: String?
    let content3: String?
    let content4: String?
    let content5: String?
    let productID: String?
    let files: [String]?
}

extension CreatePostRequest: AccessTokenProvider { }

extension CreatePostRequest: BodyProvider {
    var body: Body {
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
    
    struct Body: Encodable {
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
