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
    case createPost(CreatePostRequest)
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
        case .createPost, .viewPost:
            "/posts"
        case .viewPostWithID(let request):
            "/posts/\(request.postID)"
        case .updatePost(let request):
            "/posts/\(request.postID)"
        case .deletePost(let request):
            "/posts/\(request.postID)"
        case .viewPostByUser(let request):
            "/posts/users/\(request.userID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .uploadImage, .createPost:
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
        case .createPost(let request):
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
        case .createPost(let request):
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
        case .createPost, .updatePost:
            .json
        case .viewPost, .viewPostWithID, .deletePost, .viewPostByUser:
            nil
        }
    }
}
