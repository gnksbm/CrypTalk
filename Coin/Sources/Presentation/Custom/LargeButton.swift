//
//  LargeButton.swift
//  Coin
//
//  Created by gnksbm on 8/29/24.
//

import UIKit

import CoinFoundation

extension UIButton {
    static func largeBorderedButton(title: String) -> UIButton {
        let inset = 15.f
        return UIButton().nt.configure {
            $0.configuration(.bordered())
//                .configuration.cornerStyle(.capsule)
                .configuration.contentInsets(
                    NSDirectionalEdgeInsets(
                        top: inset,
                        leading: 0,
                        bottom: inset,
                        trailing: 0
                    )
                )
                .configuration.attributedTitle(
                    AttributedString(
                        title,
                        attributes: AttributeContainer([
                            .foregroundColor: Design.Color.blackBackground
                        ])
                    )
                )
                .configurationUpdateHandler({ button in
                    switch button.state {
                    case .disabled:
                        button.configuration?.baseBackgroundColor =
                        Design.Color.deepPurple
                    default:
                        button.configuration?.baseBackgroundColor =
                        Design.Color.orangeAccent
                    }
                })
        }
    }
}
