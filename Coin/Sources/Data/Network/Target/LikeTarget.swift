//
//  LikeTarget.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

import Moya

enum LikeTarget { 
    case updateLike(UpdateLikeRequest)
}

extension LikeTarget: BackEndTargetType {
    var targetPath: String {
        switch self {
        case .updateLike(let request):
            "/posts/\(request.postID)/comments"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .updateLike:
            .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .updateLike(let request):
            .requestJSONEncodable(request.body)
        }
    }
    
    var httpHeaders: [String : String] {
        switch self {
        case .updateLike(let request):
            request.toHeader()
        }
    }
    
    var content: Content? {
        switch self {
        case .updateLike:
            .json
        }
    }
}
