//
//  SceneDelegate.swift
//  Coin
//
//  Created by gnksbm on 8/15/24.
//

import UIKit

import Domain
import CoinFoundation

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = createRootViewController()
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
    
    private func createRootViewController() -> UIViewController {
        @UserDefaultsWrapper(key: .refreshToken, defaultValue: nil)
        var refreshToken: String?
        if refreshToken == nil {
            return LoginViewController(
                viewModel: LoginViewModel(
                    authUseCase: DefaultAuthUseCase()
                )
            )
        } else {
            return TabBarController()
        }
    }
}
