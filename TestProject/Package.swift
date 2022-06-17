// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "TestProject",
    products: [
        .executable(
            name: "TestProject",
            targets: ["TestProject"]),
    ],
    dependencies: [
        .package(name: "PluginProject", path: "../PluginProject")
    ],
    targets: [
        .executableTarget(
            name: "TestProject",
            dependencies: ["PluginProject"])
    ]
)
