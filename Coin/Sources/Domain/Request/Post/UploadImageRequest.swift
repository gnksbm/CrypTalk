//
//  UploadImageRequest.swift
//  Coin
//
//  Created by gnksbm on 8/18/24.
//

import Foundation

struct UploadImageRequest {
    let accessToken: String
    let data: [Data]
    let fileType: FileType
}

extension UploadImageRequest: HeaderProvider {
    var header: AccessTokenHeader {
        AccessTokenHeader(accessToken: accessToken)
    }
}

extension UploadImageRequest: MultipartFormDataProvider {
    var key: String { "files" }
}
