// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ShinyModel",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ShinyModel",
            targets: ["ShinyModel"]),
    ],
    dependencies: [
        .package(path: "../ShinyFormatter"),
        .package(path: "../ShinyTestResource")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ShinyModel",
            dependencies: [
                .product(name: "ShinyFormatter", package: "ShinyFormatter")
            ]),
        .testTarget(
            name: "ShinyModelTests",
            dependencies: ["ShinyModel", "ShinyTestResource"]
        ),
    ]
)
