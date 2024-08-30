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
    private let response: PostResponse
    
    init(response: PostResponse) {
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
        }
        
        return output
    }
}
extension PostDetailViewModel {
    struct Input { 
        let viewWillAppear: Observable<Void>
    }
    
    struct Output {
        let post: PublishSubject<PostResponse>
    }
}
