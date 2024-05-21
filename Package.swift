// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "thumbmark-swift",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Thumbmark",
            targets: ["Thumbmark"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/auth0/SimpleKeychain", from: "1.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Thumbmark",
            dependencies: [
                "SimpleKeychain"
            ]
        ),
        .testTarget(
            name: "Thumbark_Tests",
            dependencies: ["Thumbmark"]),
    ]
)
