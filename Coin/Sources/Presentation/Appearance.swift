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
            $0.shadowColor(Design.Color.softGreen)
                .configureWithOpaqueBackground()
        }
        appearance.backgroundColor = Design.Color.background
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

        UINavigationBar.appearance().tintColor = Design.Color.foreground
        UINavigationBar.appearance().titleTextAttributes = [
            .font: Design.Font.heading,
            .foregroundColor: Design.Color.foreground
        ]
    }
    
    private static func configureTabBarUI() {
        let appearance = UITabBarAppearance().nt.configure { 
            $0.shadowColor(Design.Color.softGreen)
                .configureWithOpaqueBackground()
        }
        appearance.backgroundColor = Design.Color.background
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().tintColor = Design.Color.foreground
    }
}

#if DEBUG || FAKE
import SwiftUI

@available(iOS 15.0, *)
struct ColorTestView: View {
    let columns = Array(repeating: GridItem(), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(Design.Color.colorKeys, id: \.self) { name in
                    if let chartColor = Design.Color.allColor[name] {
                        VStack {
                            Color(uiColor: chartColor)
                                .clipShape(.rect(cornerRadius: 12))
                                .frame(height: 100)
                            Text(name)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

@available(iOS 15.0, *)
#Preview {
    ColorTestView()
}
#endif
