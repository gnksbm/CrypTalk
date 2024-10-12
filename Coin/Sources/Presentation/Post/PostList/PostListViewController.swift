//
//  PostListViewController.swift
//  Coin
//
//  Created by gnksbm on 8/15/24.
//

import UIKit

import CoinFoundation
import Domain

import RxSwift
import SnapKit

final class PostListViewController: BaseViewController, ViewType {
    private let pageChangeEvent = BehaviorSubject(value: 0)
    
    private let gradientLayer = CAGradientLayer()
    
    private let profileButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: Design.ImageLiteral.person,
            style: .plain,
            target: nil,
            action: nil
        )
        button.tintColor = Design.Color.foreground // 버튼 색상 정의
        button.accessibilityLabel = "프로필 버튼"
        return button
    }()

    private let plusButton: UIBarButtonItem = {
        let button = UIBarButtonItem(systemItem: .add)
        button.tintColor = Design.Color.foreground // 색상 변경
        button.accessibilityLabel = "추가 버튼"
        return button
    }()
    
    private lazy var tableView: PostListTableView = {
        let tableView = PostListTableView()
        tableView.backgroundColor = Design.Color.clear
        tableView.register(
            PostListCoinCell.self,
            forCellReuseIdentifier: String(describing: PostListCoinCell.self)
        )
        tableView.register(
            PostRatioCell.self,
            forCellReuseIdentifier: String(describing: PostRatioCell.self)
        )
        tableView.register(
            PostListTVCell.self,
            forCellReuseIdentifier: String(describing: PostListTVCell.self)
        )
        tableView.separatorStyle = .none
        let emptyLabel = UILabel()
        emptyLabel.text = Design.StringLiteral.emptyPostMessage
        emptyLabel.textAlignment = .center
        emptyLabel.font = Design.Font.body1
        emptyLabel.textColor = Design.Color.background
        emptyLabel.accessibilityLabel = "등록된 게시글이 없습니다"
        tableView.emptyView = emptyLabel
        
        return tableView
    }()
    
    init(viewModel: PostListViewModel) {
        super.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    func bind(viewModel: PostListViewModel) {
        let output = viewModel.transform(
            input: PostListViewModel.Input(
                viewWillAppearEvent: viewWillAppearEvent,
                pageChangeEvent: pageChangeEvent,
                plusButtonTapEvent: plusButton.rx.tap.asObservable(),
                titleTapEvent: tableView.titleTapEvent,
                cellTapEvent: tableView.tapEvent.compactMap(
                    { item in
                        switch item {
                        case .post(let item):
                            return item
                        default:
                            return nil
                        }
                    }
                ),
                likeButtonTapEvent: tableView.likeButtonTapEvent,
                commentButtonTapEvent: tableView.commentButtonTapEvent,
                profileButtonTapEvent: profileButton.rx.tap.asObservable()
            ),
            disposeBag: &disposeBag
        )
        
        disposeBag.insert {
            output.cryptoCurrency
                .withUnretained(self)
                .bind { vc, response in
                    vc.tableView.replaceItem(
                        for: .header,
                        items: [
                            .coin(
                                PostListHeaderCellItem(
                                    info: response.0,
                                    charts: response.1
                                )
                            )
                        ]
                    )
                }
            
            output.cryptoPostResponse
                .withUnretained(self)
                .bind { vc, items in
                    vc.tableView.replaceItem(
                        for: .ratio,
                        items: [.ratio(items)]
                    )
                    vc.tableView.replaceItem(
                        for: .post,
                        items: items.map({ .post($0) })
                    )
                }
            
            output.likeChanged
                .withUnretained(self)
                .bind { vc, changedResponse in
//                    vc.tableView.updateItems(
//                        [changedResponse],
//                        withAnimating: false
//                    )
                }
            
            output.startAddFlow
                .withUnretained(self)
                .bind { vc, cryptoName in
                    let addPostVC = AddPostViewController(
                        viewModel: AddPostViewModel(
                            cryptoName: cryptoName,
                            cryptoPostUseCase: DefaultCryptoPostUseCase()
                        )
                    )
                    vc.navigationController?.pushViewController(addPostVC, animated: true)
                }
            
            output.startDetailFlow
                .withUnretained(self)
                .bind { vc, response in
                    let detailVC = PostDetailViewController(
                        viewModel: PostDetailViewModel(
                            cryptoPostUseCase: DefaultCryptoPostUseCase(),
                            response: response
                        )
                    )
                    vc.navigationController?.pushViewController(detailVC, animated: true)
                }
            
            output.startLoginFlow
                .withUnretained(self)
                .bind { vc, _ in
                    let loginVC = LoginViewController(
                        viewModel: LoginViewModel(
                            authUseCase: DefaultAuthUseCase()
                        )
                    )
                    vc.view.window?.rootViewController = loginVC
                }
            
            output.startSearchFlow
                .bind(with: self) { vc, _ in
                    let searchViewModel = SearchCoinViewModel(
                        searchCoinUseCase: DefaultSearchCoinUseCase(),
                        viewType: .dismiss
                    )
                    searchViewModel.delegate = viewModel
                    let searchVC = SearchCoinViewController(viewModel: searchViewModel)
                    vc.navigationController?.pushViewController(searchVC, animated: true)
                }
            
            output.startProfileFlow
                .bind(with: self) { vc, _ in
                    let profileVC = ProfileViewController(
                        viewModel: ProfileViewModel(
                            authUseCase: DefaultAuthUseCase(),
                            profileUseCase: DefaultProfileUseCase()
                        )
                    )
                    vc.navigationController?.pushViewController(profileVC, animated: true)
                }
        }
    }
    
    override func configureUI() {
        gradientLayer.colors = [
            Design.Color.teal.withAlphaComponent(0.05).cgColor,
            Design.Color.background.cgColor,
        ]
        gradientLayer.locations = [0, 1]
//        gradientLayer.type = .radial
//        gradientLayer.startPoint = CGPoint(x: 0.1, y: 0.1)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.addSublayer(gradientLayer)
    }
    
    override func configureLayout() {
        [tableView].forEach { view.addSubview($0) }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
    
    override func configureNavigation() {
        navigationItem.rightBarButtonItems = [profileButton, plusButton]
        navigationItem.title = Design.StringLiteral.postTab
        navigationController?.navigationBar.titleTextAttributes = [
            .font: Design.Font.title,
            .foregroundColor: Design.Color.foreground
        ]
        navigationController?.navigationBar.barTintColor = Design.Color.foreground
        navigationController?.navigationBar.isTranslucent = false
        
        // 네비게이션 바의 그림자 제거
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}
