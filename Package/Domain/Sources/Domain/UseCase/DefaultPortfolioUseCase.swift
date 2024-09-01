//
//  DefaultPortfolioUseCase.swift
//  
//
//  Created by gnksbm on 8/27/24.
//

import Foundation

import CoinFoundation

import RxSwift

public final class DefaultPortfolioUseCase: PortfolioUseCase {
    @Injected private var postRepository: PostRepository
    @Injected private var portfolioRepository: PortfolioRepository
    
    @UserDefaultsWrapper(key: .accessToken, defaultValue: nil)
    private var accessToken: String?
    @UserDefaultsWrapper(key: .userID, defaultValue: nil)
    private var userID: String?
    
    public init() { }
    
    public func fetchPortfolio() -> Single<PortfolioResponse> {
        guard let userID else {
            return .error(PortfolioError.canNotFindUserID)
        }
        return fetchPortfolio(userID: userID)
    }
    
    public func fetchPortfolio(userID: String) -> Single<PortfolioResponse> {
        guard let accessToken else {
            return .error(PortfolioError.missingAccessToken)
        }
        return AuthRequestRetrier(
            request: ReadPostsRequest(
                accessToken: accessToken,
                next: nil,
                limit: nil,
                productID: userIDToPortfolio(userID: userID)
            )
        ) { request in
            self.portfolioRepository.fetchPortfolio(request: request)
        }
        .execute()
        .catch { [weak self] error in
            if let self,
               let error = error as? PortfolioError {
                portfolioRepository.createPortfolio(
                    request: CreatePostRequest(
                        accessToken: accessToken,
                        title: nil,
                        content: nil,
                        content1: nil,
                        content2: nil,
                        content3: nil,
                        content4: nil,
                        content5: nil,
                        productID: userIDToPortfolio(userID: userID),
                        files: nil
                    )
                )
            } else {
                Single.never()
            }
        }
    }
    
    public func addAsset(
        userID: String,
        request: CryptoAsset
    ) -> Single<CryptoAsset> {
        guard let accessToken else {
            return .error(PortfolioError.missingAccessToken)
        }
        guard let data = try? JSONEncoder().encode(request),
              let content = String(data: data, encoding: .utf8) else {
            return .error(PortfolioError.failureParseCryptoAsset)
        }
        return AuthRequestRetrier(
            request: CreateCommentRequest(
                accessToken: accessToken,
                postID: userIDToPortfolio(userID: userID),
                content: content
            )
        ) { request in
            self.portfolioRepository.createAsset(request: request)
        }
        .execute()
    }
    
    public func updateAsset(
        userID: String,
        commentID: String,
        request: CryptoAsset
    ) -> Single<CryptoAsset> {
        guard let accessToken else {
            return .error(PortfolioError.missingAccessToken)
        }
        guard let data = try? JSONEncoder().encode(request),
              let content = String(data: data, encoding: .utf8) else {
            return .error(PortfolioError.failureParseCryptoAsset)
        }
        return AuthRequestRetrier(
            request: UpdateCommentRequest(
                accessToken: accessToken,
                postID: userIDToPortfolio(userID: userID),
                commentID: commentID,
                content: content
            )
        ) { request in
            self.portfolioRepository.updateAsset(request: request)
        }
        .execute()
    }
    
    public func removeAsset(
        userID: String,
        commentID: String
    ) -> Single<Bool> {
        guard let accessToken else {
            return .error(PortfolioError.missingAccessToken)
        }
        return AuthRequestRetrier(
            request: DeleteCommentRequest(
                accessToken: accessToken,
                postID: userIDToPortfolio(userID: userID),
                commentID: commentID
            )
        ) { request in
            self.portfolioRepository.deleteAsset(request: request)
        }
        .execute()
        .toResult()
    }
    
    private func userIDToPortfolio(userID: String) -> String {
        userID + "Portfolio"
    }
}
