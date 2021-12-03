// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Scotty",
    platforms: [ .iOS("12.0")],
    products: [
        .library(
            name: "Scotty",
            targets: ["Scotty"])
    ],
    targets: [
        .target(
            name: "Scotty",
            path: "Sources"),
        .testTarget(
            name: "ScottyTests",
            path: "Tests")
    ]
)
