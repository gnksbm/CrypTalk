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
}

extension ProfileTarget: BackEndTargetType {
    var targetPath: String {
        switch self {
        case .readMyProfile, .updateProfile:
            "/users/me/profile"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .readMyProfile:
            .get
        case .updateProfile:
            .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .readMyProfile:
            .requestPlain
        case .updateProfile(let request):
            .requestJSONEncodable(request.body)
        }
    }
    
    var httpHeaders: [String : String] {
        switch self {
        case .readMyProfile(let request):
            request.toHeader()
        case .updateProfile(let request):
            request.toHeader()
        }
    }
    
    var content: Content? {
        switch self {
        case .readMyProfile:
            nil
        case .updateProfile:
            .multipartFormData
        }
    }
}
