// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "privacy_lens",
    platforms: [
        .iOS("12.0"),
        .macOS("10.14")
    ],
    products: [
        .library(
            name: "privacy_lens",
            targets: ["privacy_lens"]
        )
    ],
    targets: [
        .target(
            name: "privacy_lens",
            dependencies: [],
            path: ".",
            exclude: []
        )
    ]
)