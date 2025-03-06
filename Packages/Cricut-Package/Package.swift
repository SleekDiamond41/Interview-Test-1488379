// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Cricut-Package",
  platforms: [
    .macOS(.v14),
    .iOS(.v17),
  ],
  products: [
    .library(name: "Bonus", targets: ["Bonus"]),
    .library(name: "Core", targets: ["Core"]),
    .library(name: "Interface", targets: ["Interface"]),
    .library(name: "Live", targets: ["Live"]),
  ],
  targets: [
    .target(
      name: "Bonus",
      dependencies: [
        "Interface",
      ]
    ),
    .target(
      name: "Core",
      dependencies: [
        "Interface",
      ]
    ),
    .target(
      name: "Interface"
    ),
    .target(
      name: "Live",
      dependencies: [
        "Interface",
      ]
    ),

    // MARK: - Test Targets
    .testTarget(
      name: "CoreTests",
      dependencies: [
        "Core",
        "Interface",
      ]
    ),
    .testTarget(
      name: "LiveTests",
      dependencies: [
        "Live",
        "Interface",
      ]
    )
  ]
)
