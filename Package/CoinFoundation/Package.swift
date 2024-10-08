// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "CoinFoundation",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "CoinFoundation",
            targets: ["CoinFoundation"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/SnapKit/SnapKit",
            exact: "5.7.1"
        ),
        .package(
            url: "https://github.com/Moya/Moya",
            .upToNextMajor(
                from: "15.0.3"
            )
        ),
        .package(
            url: "https://github.com/ReactiveX/RxSwift",
            .upToNextMajor(
                from: "6.0.0"
            )
        ),
        .package(
            url: "https://github.com/onevcat/Kingfisher",
            exact: "7.12.0"
        ),
        .package(
            url: "https://github.com/iamport/iamport-ios",
            exact: "1.4.2"
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
                .product(name: "RxCocoa", package: "RxSwift"),
                "SnapKit",
                "Kingfisher",
                .product(name: "iamport-ios", package: "iamport-ios"),
                "Neat"
            ]
        ),
        .testTarget(
            name: "CoinFoundationTests",
            dependencies: ["CoinFoundation"]
        ),
    ]
)
