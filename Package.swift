// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-qwz-ui",
    platforms: [
        .macOS("13.0"),
        .iOS("18.0"),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "QwzUI",
            targets: ["QwzUI"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "QwzUI"
        ),
        .testTarget(
            name: "QwzUITests",
            dependencies: ["QwzUI"]
        ),
    ]
)
