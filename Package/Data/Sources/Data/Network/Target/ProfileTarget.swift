//
//  ProfileTarget.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

import Domain

import Moya

enum ProfileTarget {
    case readMyProfile(ReadMyProfileRequest)
    case updateProfile(UpdateProfileRequest)
    case readImage(ReadImageReuqest)
}

extension ProfileTarget: BackEndTargetType {
    var targetPath: String {
        switch self {
        case .readMyProfile, .updateProfile:
            "/users/me/profile"
        case .readImage(let request):
            "/\(request.additionalPath)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .readMyProfile, .readImage:
            .get
        case .updateProfile:
            .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .readMyProfile, .readImage:
            .requestPlain
        case .updateProfile(let request):
            .uploadMultipart(request.toMultipartFormData())
        }
    }
    
    var httpHeaders: [String : String] {
        switch self {
        case .readImage(let request):
            request.toHeader()
        case .readMyProfile(let request):
            request.toHeader()
        case .updateProfile(let request):
            request.toHeader()
        }
    }
    
    var content: Content? {
        switch self {
        case .readMyProfile, .readImage:
            nil
        case .updateProfile:
            .multipartFormData
        }
    }
}
