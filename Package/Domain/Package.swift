// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Domain",
    products: [
        .library(
            name: "Domain",
            targets: ["Domain"]
        ),
    ],
    dependencies: [
        .package(name: "CoinFoundation", path: "../CoinFoundation/")
    ],
    targets: [
        .target(
            name: "Domain",
            dependencies: [
                "CoinFoundation"
            ]
        ),
        .testTarget(
            name: "DomainTests",
            dependencies: ["Domain"]
        ),
    ]
)
