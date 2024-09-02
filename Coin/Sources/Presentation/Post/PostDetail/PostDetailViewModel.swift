//
//  PostDetailViewModel.swift
//  Coin
//
//  Created by gnksbm on 8/29/24.
//

import Foundation

import CoinFoundation
import Domain

import RxSwift

final class PostDetailViewModel: ViewModelType {
    private let cryptoPostUseCase: CryptoPostUseCase
    private let response: PostResponse
    
    init(
        cryptoPostUseCase: CryptoPostUseCase,
        response: PostResponse
    ) {
        self.cryptoPostUseCase = cryptoPostUseCase
        self.response = response
    }
    
    func transform(input: Input, disposeBag: inout DisposeBag) -> Output {
        let output = Output(
            post: PublishSubject(),
            startPortfolioFlow: input.nicknameButtonTapEvent
        )
        
        disposeBag.insert {
            input.viewWillAppear
                .withUnretained(self)
                .map { vm, _ in vm.response }
                .bind(to: output.post)
            
            input.likeButtonTapEvent
                .withUnretained(self)
                .flatMap { vm, post in
                    vm.cryptoPostUseCase.likePost(post: post)
                }
                .bind(to: output.post)
            
            input.commentDoneButtonTapEvent
                .withLatestFrom(input.commentChangeEvent)
                .withUnretained(self)
                .flatMap { vm, comment in
                    vm.cryptoPostUseCase.addComment(
                        postID: vm.response.postID,
                        content: comment
                    )
                }
                .withUnretained(self)
                .flatMap { vm, _ in
                    vm.cryptoPostUseCase.fetchPost(postID: vm.response.postID)
                }
                .bind(to: output.post)
        }
        
        return output
    }
}
extension PostDetailViewModel {
    struct Input { 
        let viewWillAppear: Observable<Void>
        let likeButtonTapEvent: Observable<PostResponse>
        let commentChangeEvent: Observable<String>
        let commentDoneButtonTapEvent: Observable<Void>
        let nicknameButtonTapEvent: Observable<User>
    }
    
    struct Output {
        let post: PublishSubject<PostResponse>
        let startPortfolioFlow: Observable<User>
    }
}
