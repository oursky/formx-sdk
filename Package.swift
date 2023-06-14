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
            url: "https://github.com/oursky/formx-sdk/releases/download/0.1.8/FormX.xcframework.zip",
            checksum: "617dcd4cc9f15cf50942032c8b27a520ccd2833c000e37a438ecd49b07498101"
        )
    ]
)
