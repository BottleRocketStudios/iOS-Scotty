// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Scotty",
    platforms: [.iOS(.v12), .tvOS(.v12)],
    products: [
        .library(
            name: "Scotty",
            targets: ["Scotty"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Scotty",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "ScottyTests",
            dependencies: ["Scotty"]),
    ]
)
