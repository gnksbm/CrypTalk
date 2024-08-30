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
            post: PublishSubject()
        )
        
        disposeBag.insert {
            input.viewWillAppear
                .withUnretained(self)
                .map { vm, _ in vm.response }
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
        let commentChangeEvent: Observable<String>
        let commentDoneButtonTapEvent: Observable<Void>
    }
    
    struct Output {
        let post: PublishSubject<PostResponse>
    }
}
