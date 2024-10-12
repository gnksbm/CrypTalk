//
//  FakeProfileRepository.swift
//  
//
//  Created by gnksbm on 10/7/24.
//

import Foundation

import CoinFoundation
import Domain

import RxSwift

public final class FakeProfileRepository: ProfileRepository {
    @Injected private var networkService: NetworkService
    
    var profile = ProfileResponse(
        id: "",
        email: "",
        nickname: "",
        phoneNumber: "",
        birthDay: "",
        profileImagePath: "https://i.namu.wiki/i/1L_8d7FSBchLDnx7zLaxWs-HvUa6wQzLy2trSu0fGIqjWYQDWjEIEyxxoNJyDaIq_FF1QKFsu8nMNpDbJn_QSQ.webp",
        followers: [],
        followings: [],
        postIDs: []
    )
    
    public init() { }
    
    public func readMyProfile(
        request: ReadMyProfileRequest
    ) -> Single<ProfileResponse> {
        .just(profile)
    }
    
    public func updateProfile(
        request: UpdateProfileRequest
    ) -> Single<ProfileResponse> {
        .just(profile)
    }
    
    public func readImage(
        request: ReadImageReuqest
    ) -> Single<Data> {
        networkService.request(
            target: URLProvider(url: URL(string: request.additionalPath)!)
        )
    }
    
    struct URLProvider: TargetProvider {
        let url: URL
        var components: URLComponents {
            URLComponents(string: url.absoluteString)!
        }
        public var scheme: Scheme { Scheme(rawValue: components.scheme!)! }
        public var host: String { components.host! }
        public var port: Int? { components.port }
        public var httpHeaders: [String : String] { [:] }
        public var commonHeaders: [String : String] { [:] }
        public var content: Content? { nil }
        public var path: String { components.path }
        public var method: Moya.Method { .get }
        public var task: Moya.Task { .requestPlain }
    }
}

import Moya
