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
            url: "https://github.com/oursky/formx-sdk/releases/download/0.1.9/FormX.xcframework.zip",
            checksum: "577e3384b4eff118f2026eb44bd2fa00260e17687c68bbc1e53f407eb47d2f91"
        )
    ]
)
