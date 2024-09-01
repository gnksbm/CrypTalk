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
                Single.error(error)
            }
        }
    }
    
    public func purchaseAsset(request: CryptoAsset) -> Single<CryptoAsset> {
        guard let accessToken else {
            return .error(PortfolioError.missingAccessToken)
        }
        guard let userID else {
            return .error(PortfolioError.canNotFindUserID)
        }
        return fetchPortfolio()
            .asObservable()
            .withUnretained(self)
            .flatMap { useCase, response in
                if let asset = response.assets.first(
                    where: { asset in
                        asset.value.name == request.value.name
                    }
                ) {
                    var copy = request.value
                    copy.amount += asset.value.amount
                    guard let data = try? JSONEncoder().encode(copy),
                          let content = String(data: data, encoding: .utf8) 
                    else {
                        return Single<CryptoAsset>.error(
                            PortfolioError.failureParseCryptoAsset
                        )
                    }
                    return AuthRequestRetrier(
                        request: UpdateCommentRequest(
                            accessToken: accessToken,
                            postID: response.portfolioID,
                            commentID: asset.commentID,
                            content: content
                        )
                    ) { request in
                        useCase.portfolioRepository.updateAsset(
                            request: request
                        )
                    }
                    .execute()
                } else {
                    guard let data = try? JSONEncoder().encode(request.value),
                          let content = String(data: data, encoding: .utf8) 
                    else {
                        return .error(PortfolioError.failureParseCryptoAsset)
                    }
                    return AuthRequestRetrier(
                        request: CreateCommentRequest(
                            accessToken: accessToken,
                            postID: response.portfolioID,
                            content: content
                        )
                    ) { request in
                        useCase.portfolioRepository.createAsset(
                            request: request
                        )
                    }
                    .execute()
                }
            }
            .asSingle()
    }
    
    public func updateAsset(
        commentID: String,
        request: CryptoAsset
    ) -> Single<CryptoAsset> {
        guard let accessToken else {
            return .error(PortfolioError.missingAccessToken)
        }
        guard let userID else {
            return .error(PortfolioError.canNotFindUserID)
        }
        guard let data = try? JSONEncoder().encode(request.value),
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
        commentID: String
    ) -> Single<Bool> {
        guard let accessToken else {
            return .error(PortfolioError.missingAccessToken)
        }
        guard let userID else {
            return .error(PortfolioError.canNotFindUserID)
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
