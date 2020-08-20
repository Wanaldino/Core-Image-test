// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Image modification test",
    platforms: [.macOS(.v10_15)],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "console-kit", url: "https://github.com/vapor/console.git", from: "4.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "ACSII Art",
            dependencies: [
                .product(name: "ConsoleKit", package: "console-kit")
            ]),
        .testTarget(
            name: "ACSII ArtTests",
            dependencies: ["ACSII Art"]),
    ]
)
