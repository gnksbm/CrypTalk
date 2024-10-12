//
//  PurchaseCoinViewModel.swift
//  Coin
//
//  Created by gnksbm on 9/1/24.
//

import Foundation

import CoinFoundation
import Domain

import iamport_ios
import RxSwift

final class PurchaseCoinViewModel: ViewModelType {
    private let portfolioUseCase: PortfolioUseCase
    private let cryptoPostUseCase: CryptoPostUseCase
    private var coinID: String?
    
    init(
        portfolioUseCase: PortfolioUseCase,
        cryptoPostUseCase: CryptoPostUseCase,
        coinID: String? = nil
    ) {
        self.portfolioUseCase = portfolioUseCase
        self.cryptoPostUseCase = cryptoPostUseCase
        self.coinID = coinID
    }
    
    func transform(input: Input, disposeBag: inout DisposeBag) -> Output {
        let output = Output(
            selectedCoin: PublishSubject(),
            startSearchFlow: input.changeButtonTapEvent,
            startPurchaseFlow: PublishSubject(),
            finishFlow: PublishSubject()
        )
        
        disposeBag.insert {
            input.viewWillAppearEvent
                .withUnretained(self)
                .flatMap { vm, _ in
                    vm.cryptoPostUseCase.fetchCryptoCurrency(coinID: vm.coinID)
                }
                .catch { error in
                    Logger.error(error)
                    return .empty()
                }
                .bind(to: output.selectedCoin)
            
            input.purchaseButtonTapped
                .withLatestFrom(
                    Observable.combineLatest(
                        input.amountChangeEvent.compactMap { Double($0) },
                        output.selectedCoin.map { $0.0 }
                    )
                )
                .map { amount, coin in
                    let date = Int(Date().timeIntervalSince1970)
                    return IamportPayment(
                        pg: PG.html5_inicis.makePgRawName(pgId: "INIpayTest"),
                        merchant_uid: "ios_\(Secret.apiKey)_\(date)",
                        amount: "100"
                    )
                    .then {
                        $0.pay_method = PayMethod.card.rawValue
                        $0.name = "\(coin.name), \(amount)개"
                        $0.buyer_name = "김새싹"
                        $0.app_scheme = "Coin"
                    }
                }
                .bind(to: output.startPurchaseFlow)
            
            input.paymentResult
                .withLatestFrom(
                    Observable.combineLatest(
                        input.amountChangeEvent.compactMap { Double($0) },
                        output.selectedCoin.map { $0.0 }
                    )
                ) { iam, tuple in
                    let (amount, coin) = tuple
                    return CryptoAsset(
                        commentID: "",
                        name: coin.name,
                        symbol: coin.symbol,
                        price: coin.price,
                        amount: amount
                    )
                }
                .withUnretained(self)
                .flatMap { vm, request in
                    vm.portfolioUseCase.purchaseAsset(request: request)
                }
                .catch { error in
                    Logger.error(error)
                    return .empty()
                }
                .map { _ in }
                .bind(to: output.finishFlow)
        }
        
        return output
    }
}

extension PurchaseCoinViewModel {
    struct Input { 
        let viewWillAppearEvent: Observable<Void>
        let changeButtonTapEvent: Observable<Void>
        let amountChangeEvent: Observable<String>
        let purchaseButtonTapped: Observable<Void>
        let paymentResult: PublishSubject<IamportResponse?>
    }
    
    struct Output {
        let selectedCoin:
        PublishSubject<(CryptoCurrencyResponse, [ChartDataResponse])>
        let startSearchFlow: Observable<Void>
        let startPurchaseFlow: PublishSubject<IamportPayment>
        let finishFlow: PublishSubject<Void>
    }
}

extension PurchaseCoinViewModel: SearchCoinViewModelDelegate {
    func itemSelected(_ item: SearchCoinResponse) {
        coinID = item.id
    }
}
