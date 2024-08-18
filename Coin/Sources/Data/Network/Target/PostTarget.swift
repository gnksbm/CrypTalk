//
//  PostTarget.swift
//  Coin
//
//  Created by gnksbm on 8/18/24.
//

import Foundation

import Moya

enum PostTarget {
    case create(CreatePostRequest)
}

extension PostTarget: BackEndTargetType {
    var targetPath: String {
        switch self {
        case .create:
            "posts"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .create:
            .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .create(let request):
                .requestJSONEncodable(request.parameter)
        }
    }
    
    var httpHeaders: [String : String] {
        switch self {
        case .create(let request):
            request.toHeader()
        }
    }
    
    var content: Content? {
        switch self {
        case .create:
            .json
        }
    }
}
