//
//  TabBarController.swift
//  Coin
//
//  Created by gnksbm on 9/1/24.
//

import UIKit

import CoinFoundation
import Domain

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = TabKind.makeViewControllers()
    }
    
    enum TabKind: CaseIterable {
        case post, portfolio
        
        static func makeViewControllers() -> [UIViewController] {
            allCases.map { tabKind in
                UINavigationController(
                    rootViewController: tabKind.viewController.nt.configure {
                        $0.tabBarItem(tabKind.tabBarItem)
                    }
                )
            }
        }
        
        private var viewController: UIViewController {
            switch self {
            case .post:
                PostListViewController(
                    viewModel: PostListViewModel(
                        useCase: DefaultCryptoPostUseCase()
                    )
                )
            case .portfolio:
                PortfolioViewController(
                    viewModel: PortfolioViewModel(
                        useCase: DefaultPortfolioUseCase(),
                        userID: nil
                    )
                )
            }
        }
        
        private var tabBarItem: UITabBarItem {
            UITabBarItem(
                title: title,
                image: image,
                selectedImage: selectedImage
            )
        }
        
        private var title: String? {
            switch self {
            case .post:
                Design.StringLiteral.postTab
            case .portfolio:
                Design.StringLiteral.portfolioTab
            }
        }
        
        private var image: UIImage? {
            switch self {
            case .post:
                Design.ImageLiteral.postTab
            case .portfolio:
                Design.ImageLiteral.portfolioTab
            }
        }
        
        private var selectedImage: UIImage? {
            switch self {
            case .post:
                Design.ImageLiteral.postTabSelected
            case .portfolio:
                Design.ImageLiteral.portfolioTabSelected
            }
        }
    }
}
