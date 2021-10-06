// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Essentials",
    platforms: [.iOS(.v11), .macOS(.v10_12), .tvOS(.v10), .watchOS(.v3)],
    products: [
        .library(name: "Essentials", targets: ["Essentials"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(name: "Essentials", dependencies: []),
        .testTarget(name: "EssentialsTests", dependencies: ["Essentials"]),
    ]
)
