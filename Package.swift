// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FormX",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "FormX",
            targets: ["FormX"])
    ],
    dependencies: [
        .package(name: "opencv2",
                 url: "https://github.com/oursky/opencv.git",
                 .branch("4.6.0"))
    ],
    targets: [
        .binaryTarget(name: "FormX",
            url: "https://github.com/oursky/formx-sdk/releases/download/0.1.6/FormX.xcframework.zip",
            checksum: "9be347d8b531ad94a1863d076e5ae95067ab4e16087ad51568c4e55d5516d9bb"
        )
    ]
)
