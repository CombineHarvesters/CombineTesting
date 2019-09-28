// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "CombineTesting",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "CombineTesting",
            targets: ["CombineTesting"]),
    ],
    targets: [
        .target(
            name: "CombineTesting"),
        .testTarget(
            name: "CombineTestingTests",
            dependencies: ["CombineTesting"]),
    ]
)
