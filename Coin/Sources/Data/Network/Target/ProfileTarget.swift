//
//  ProfileTarget.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

import Moya

enum ProfileTarget {
    case readProfile(ReadProfileRequest)
    case updateProfile(UpdateProfileRequest)
}

extension ProfileTarget: BackEndTargetType {
    var targetPath: String {
        switch self {
        case .readProfile, .updateProfile:
            "/users/me/profile"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .readProfile:
            .get
        case .updateProfile:
            .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .readProfile:
            .requestPlain
        case .updateProfile(let request):
            .requestJSONEncodable(request.body)
        }
    }
    
    var httpHeaders: [String : String] {
        switch self {
        case .readProfile(let request):
            request.toHeader()
        case .updateProfile(let request):
            request.toHeader()
        }
    }
    
    var content: Content? {
        switch self {
        case .readProfile:
            nil
        case .updateProfile:
            .multipartFormData
        }
    }
}
