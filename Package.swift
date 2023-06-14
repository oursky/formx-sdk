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
        .binaryTarget(name: "opencv2",
            url: "https://github.com/oursky/formx-sdk/releases/download/0.1.3/FormX.xcframework.zip",
            checksum: "22db3c25590a11d6b614fc5d96aed53c15e892cc7fd8c325b2449a6bf2cf071f"
        )
    ]
)
