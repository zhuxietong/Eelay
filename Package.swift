// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Eelay",
    platforms: [
    .iOS(.v8)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(name: "Eelay",targets: ["Eelay"]),
        
        
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Eelay",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "EelayTests",
            dependencies: ["Eelay"]),
    ],
    swiftLanguageVersions: [.v5, .version("5")]

)
