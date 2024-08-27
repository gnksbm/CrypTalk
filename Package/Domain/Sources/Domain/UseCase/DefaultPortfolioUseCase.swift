//
//  DefaultPortfolioUseCase.swift
//  
//
//  Created by gnksbm on 8/27/24.
//

import Foundation

import CoinFoundation

import RxSwift

enum PortfolioError: Error {
    case missingAccessToken, failureParseCryptoAsset
}

public final class DefaultPortfolioUseCase: PortfolioUseCase {
    @Injected private var postRepository: PostRepository
    @Injected private var portfolioRepository: PortfolioRepository
    
    @UserDefaultsWrapper(key: .accessToken, defaultValue: nil)
    private var accessToken: String?
    
    public func fetchPortfolio(userID: String) -> Single<PortfolioResponse> {
        guard let accessToken else {
            return .error(PortfolioError.missingAccessToken)
        }
        return AuthRequestRetrier(
            request: ReadPostWithIDRequest(
                accessToken: accessToken,
                postID: userIDToPortfolio(userID: userID)
            )
        ) { request in
            self.portfolioRepository.fetchPortfolio(request: request)
        }.execute()
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
        }.execute()
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
