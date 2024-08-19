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
    case readLikedPosts(ReadLikedPosts)
}

extension LikeTarget: BackEndTargetType {
    var targetPath: String {
        switch self {
        case .updateLike(let request):
            "/posts/\(request.postID)/comments"
        case .readLikedPosts:
            "/posts/likes/me"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .updateLike:
            .post
        case .readLikedPosts:
            .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .updateLike(let request):
            .requestJSONEncodable(request.body)
        case .readLikedPosts:
            .requestPlain
        }
    }
    
    var httpHeaders: [String : String] {
        switch self {
        case .updateLike(let request):
            request.toHeader()
        case .readLikedPosts(let request):
            request.toHeader()
        }
    }
    
    var content: Content? {
        switch self {
        case .updateLike:
            .json
        case .readLikedPosts:
            nil
        }
    }
}
