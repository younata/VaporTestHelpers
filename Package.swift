// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VaporTestHelpers",
    products: [
        .library(
            name: "VaporTestHelpers",
            targets: ["VaporTestHelpers"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0-rc"),

        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "1.2.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "7.0.0")),
    ],
    targets: [
        .target(
            name: "VaporTestHelpers",
            dependencies: ["Vapor"]
        ),
        .testTarget(name: "VaporTestHelpersTests", dependencies: ["VaporTestHelpers", "Quick", "Nimble"])
    ]
)
