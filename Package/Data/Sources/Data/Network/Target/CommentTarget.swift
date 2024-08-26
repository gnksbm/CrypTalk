//
//  CommentTarget.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

import Domain

import Moya

enum CommentTarget {
    case createComment(CreateCommentRequest)
    case updateComment(UpdateCommentRequest)
    case deleteComment(DeleteCommentRequest)
}

extension CommentTarget: BackEndTargetType {
    var targetPath: String {
        switch self {
        case .createComment(let request):
            "/posts/\(request.postID)/comments"
        case .updateComment(let request):
            "/posts/\(request.postID)/comments/\(request.commentID)"
        case .deleteComment(let request):
            "/posts/\(request.postID)/comments/\(request.commentID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createComment:
            .post
        case .updateComment:
            .put
        case .deleteComment:
            .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .createComment(let request):
            .requestJSONEncodable(request.body)
        case .updateComment(let request):
            .requestJSONEncodable(request.body)
        case .deleteComment:
            .requestPlain
        }
    }
    
    var httpHeaders: [String : String] {
        switch self {
        case .createComment(let request):
            request.toHeader()
        case .updateComment(let request):
            request.toHeader()
        case .deleteComment(let request):
            request.toHeader()
        }
    }
    
    var content: Content? {
        switch self {
        case .createComment, .updateComment:
            .json
        case .deleteComment:
            nil
        }
    }
}
