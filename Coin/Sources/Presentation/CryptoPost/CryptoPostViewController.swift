//
//  CryptoPostViewController.swift
//  Coin
//
//  Created by gnksbm on 8/15/24.
//

import UIKit

import CoinFoundation
import Domain

import Kingfisher
import RxSwift
import SnapKit
import Neat

final class CryptoPostViewController: BaseViewController, ViewType {
    private let iconImageView = UIImageView().nt.configure {
        $0.contentMode(.scaleAspectFill)
    }
    private let titleButton = UIButton(configuration: .plain()).nt.configure {
        $0.configuration.titleAlignment(.leading)
            .configuration.baseForegroundColor(Design.Color.foregroundColor)
    }
    private let priceLabel = UILabel()
    private let rateLabel = UILabel()
    private let tableView = UITableView()
    private let pageChangeEvent = BehaviorSubject(value: 1)
    
    init(viewModel: CryptoPostViewModel) {
        super.init()
        self.viewModel = viewModel
    }
    
    func bind(viewModel: CryptoPostViewModel) {
        let output = viewModel.transform(
            input: CryptoPostViewModel.Input(
                viewWillAppearEvent: viewWillAppearEvent, 
                pageChangeEvent: pageChangeEvent
            ),
            disposeBag: &disposeBag
        )
        
        disposeBag.insert {
            output.cryptoCurrency
                .withUnretained(self)
                .subscribe { vc, response in
                    vc.updateView(response: response)
                }
            
            output.cryptoPostResponse
                .withUnretained(self)
                .subscribe { vc, responses in
                    vc.updateView(responses: responses)
                }
        }
    }
    
    private func updateView(response: CryptoCurrencyResponse) {
        iconImageView.kf.setImage(with: response.imageURL)
        titleButton.configuration?.title = response.name
        priceLabel.text = response.price.formatted(.currency(code: "KRW"))
        rateLabel.text = response.rate.formatted(.percent)
    }
    
    private func updateView(responses: [PostResponse]) {
        print(responses.count)
    }
    
    override func configureLayout() {
        [
            iconImageView,
            titleButton,
            priceLabel,
            rateLabel,
            tableView
        ].forEach { view.addSubview($0) }
        
        iconImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(safeArea)
                .inset(Design.Padding.regular)
            make.size.equalTo(Design.Dimension.symbolSize)
        }
        
        titleButton.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing)
                .offset(Design.Padding.regular)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleButton)
            make.leading.equalTo(titleButton.snp.trailing)
                .offset(Design.Padding.regular)
            make.trailing.equalTo(safeArea)
                .inset(Design.Padding.regular)
        }
        
        rateLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom)
                .offset(Design.Padding.regular)
            make.trailing.equalTo(priceLabel)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(rateLabel.snp.bottom)
                .offset(Design.Padding.regular)
            make.horizontalEdges.bottom.equalTo(safeArea)
        }
    }
}
