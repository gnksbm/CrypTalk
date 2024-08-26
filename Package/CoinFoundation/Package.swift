// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "CoinFoundation",
    products: [
        .library(
            name: "CoinFoundation",
            targets: ["CoinFoundation"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/Moya/Moya",
            exact: "15.0.3"
        ),
        .package(
            url: "https://github.com/ReactiveX/RxSwift",
            exact: "6.0.0"
        ),
        .package(
            url: "https://github.com/gnksbm/Neat.git",
            branch: "main"
        )
    ],
    targets: [
        .target(
            name: "CoinFoundation",
            dependencies: [
                "Moya",
                "RxSwift",
                "Neat"
            ]
        ),
        .testTarget(
            name: "CoinFoundationTests",
            dependencies: ["CoinFoundation"]
        ),
    ]
)
