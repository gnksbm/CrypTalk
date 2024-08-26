//
//  UploadImageDTO.swift
//  Coin
//
//  Created by gnksbm on 8/20/24.
//

import Foundation

import Domain

struct UploadImageDTO: Decodable {
    let files: [String]
}

extension UploadImageDTO {
    func toResponse() -> UploadImageResponse {
        UploadImageResponse(imagePaths: files)
    }
}
