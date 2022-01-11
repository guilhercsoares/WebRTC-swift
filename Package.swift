// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "WebRTC",
    products: [
        .library(
            name: "WebRTC",
            type: .dynamic,
            targets: ["WebRTC"]),
    ],
    dependencies: [],
    targets: [
        .binaryTarget(name: "WebRTC",
                      path: "WebRTC.xcframework")

    ]
)
