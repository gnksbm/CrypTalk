//
//  PostTarget.swift
//  Coin
//
//  Created by gnksbm on 8/18/24.
//

import Foundation

import Moya

enum PostTarget {
    case uploadImage(UploadImageRequest)
    case create(CreatePostRequest)
    case viewPost(ViewPostRequest)
    case viewPostWithID(ViewPostWithIDRequest)
    case updatePost(UpdatePostRequest)
    case deletePost(DeletePostRequest)
    case viewPostByUser(ViewPostByUserRequest)
}

extension PostTarget: BackEndTargetType {
    var targetPath: String {
        switch self {
        case .uploadImage:
            "/posts/files"
        case .create, .viewPost:
            "/posts"
        case .viewPostWithID(let request):
            "/posts\(request.additionalPath)"
        case .updatePost(let request):
            "/posts\(request.additionalPath)"
        case .deletePost(let request):
            "/posts\(request.additionalPath)"
        case .viewPostByUser(let request):
            "/posts/users\(request.additionalPath)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .uploadImage, .create:
            .post
        case .viewPost, .viewPostWithID, .viewPostByUser:
            .get
        case .updatePost:
            .put
        case .deletePost:
            .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .uploadImage(let request):
            .uploadMultipart(request.toMultipartFormData())
        case .create(let request):
            .requestJSONEncodable(request.body)
        case .viewPost(let request):
            .requestParameters(
                parameters: request.toQuery(),
                encoding: URLEncoding.queryString
            )
        case .viewPostWithID, .deletePost:
            .requestPlain
        case .updatePost(let request):
            .requestJSONEncodable(request.body)
        case .viewPostByUser(let request):
            .requestParameters(
                parameters: request.toQuery(),
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var httpHeaders: [String : String] {
        switch self {
        case .uploadImage(let request):
            request.toHeader()
        case .create(let request):
            request.toHeader()
        case .viewPost(let request):
            request.toHeader()
        case .viewPostWithID(let request):
            request.toHeader()
        case .updatePost(let request):
            request.toHeader()
        case .deletePost(let request):
            request.toHeader()
        case .viewPostByUser(let request):
            request.toHeader()
        }
    }
    
    var content: Content? {
        switch self {
        case .uploadImage:
            .multipartFormData
        case .create, .updatePost:
            .json
        case .viewPost, .viewPostWithID, .deletePost, .viewPostByUser:
            nil
        }
    }
}
