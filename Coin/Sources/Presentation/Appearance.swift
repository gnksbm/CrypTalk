//
//  Appearance.swift
//  Coin
//
//  Created by gnksbm on 9/2/24.
//

import UIKit

import CoinFoundation

import Neat

enum Appearance {
    static func configureCommonUI() {
        configureNavigationBarUI()
        configureTabBarUI()
    }
    
    private static func configureNavigationBarUI() {
        let appearance = UINavigationBarAppearance().nt.configure {
            $0.shadowColor(Design.Color.secondary)
                .configureWithOpaqueBackground()
        }
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

        UINavigationBar.appearance().tintColor = Design.Color.foreground
        UINavigationBar.appearance().titleTextAttributes = [
            .font: Design.Font.heading
        ]
    }
    
    private static func configureTabBarUI() {
        let appearance = UITabBarAppearance().nt.configure { $0.shadowColor(Design.Color.secondary)
                .configureWithOpaqueBackground()
        }
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().tintColor = Design.Color.foreground
    }
}
