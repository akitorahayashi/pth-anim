// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "HelloFramePath",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .executable(
            name: "HelloFramePath",
            targets: ["HelloFramePath"]
        ),
    ],
    targets: [
        .executableTarget(
            name: "HelloFramePath",
            path: "."
        ),
    ]
)
