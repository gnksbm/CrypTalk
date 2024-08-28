//
//  SceneDelegate.swift
//  Coin
//
//  Created by gnksbm on 8/15/24.
//

import UIKit

import Domain

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let cryptoPostViewController = CryptoPostViewController(
            viewModel: CryptoPostViewModel(
                useCase: DefaultCryptoPostUseCase()
            )
        )
        window?.rootViewController =
        UINavigationController(rootViewController: cryptoPostViewController)
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}
