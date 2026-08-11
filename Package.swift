// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "diff-block",
  dependencies: [
    .package(url: "https://github.com/apple/example-package-figlet", branch: "main"),
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
    .package(url: "https://github.com/pakLebah/ANSITerminal.git", exact: "0.0.3"),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .executableTarget(
      name: "diff-block",
      dependencies: [
        .product(name: "Figlet", package: "example-package-figlet"),
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        "ANSITerminal",
      ],
      path: "Sources"
    ),
    .testTarget(
      name: "diff-blockTests",
      dependencies: ["diff-block"]
    ),
  ],
  swiftLanguageModes: [.v6]
)
