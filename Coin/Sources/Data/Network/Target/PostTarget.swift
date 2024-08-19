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
    case readPosts(ReadPostsRequest)
    case readPostWithID(ReadPostWithIDRequest)
    case updatePost(UpdatePostRequest)
    case deletePost(DeletePostRequest)
    case readPostsByUser(ReadPostsByUserRequest)
    case readPostsByHashtag(ReadPostsByHashtagRequest)
}

extension PostTarget: BackEndTargetType {
    var targetPath: String {
        switch self {
        case .uploadImage:
            "/posts/files"
        case .createPost, .readPosts:
            "/posts"
        case .readPostWithID(let request):
            "/posts/\(request.postID)"
        case .updatePost(let request):
            "/posts/\(request.postID)"
        case .deletePost(let request):
            "/posts/\(request.postID)"
        case .readPostsByUser(let request):
            "/posts/users/\(request.userID)"
        case .readPostsByHashtag(let request):
            "/posts/hashtags"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .uploadImage, .createPost:
            .post
        case .readPosts, .readPostWithID, .readPostsByUser, .readPostsByHashtag:
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
        case .readPosts(let request):
            .requestParameters(
                parameters: request.toQuery(),
                encoding: URLEncoding.queryString
            )
        case .readPostWithID, .deletePost, .readPostsByHashtag:
            .requestPlain
        case .updatePost(let request):
            .requestJSONEncodable(request.body)
        case .readPostsByUser(let request):
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
        case .readPosts(let request):
            request.toHeader()
        case .readPostWithID(let request):
            request.toHeader()
        case .updatePost(let request):
            request.toHeader()
        case .deletePost(let request):
            request.toHeader()
        case .readPostsByUser(let request):
            request.toHeader()
        case .readPostsByHashtag(let request):
            request.toHeader()
        }
    }
    
    var content: Content? {
        switch self {
        case .uploadImage:
            .multipartFormData
        case .createPost, .updatePost:
            .json
        case .readPosts, .readPostWithID, .deletePost, .readPostsByUser,
                .readPostsByHashtag:
            nil
        }
    }
}
