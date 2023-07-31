// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FormX",
    platforms: [.iOS(.v11), .macOS(.v10_14)],
    products: [
        .library(
            name: "FormX",
            targets: ["FormXTarget"])
    ],
    targets: [
        .target(name: "FormXTarget",
            dependencies: ["FormX"],
            path: ".",
            linkerSettings: [
                .linkedLibrary("c++"),
                .linkedFramework("OpenCL", .when(platforms: [.macOS])),
                .linkedFramework("Accelerate")
            ]
        ),
        .binaryTarget(name: "FormX",
            url: "https://github.com/oursky/formx-sdk/releases/download/0.1.23/FormX.xcframework.zip",
            checksum: "45cf0f567af3a4fad9d84efb33afcb157b39824c4cb2b4c9e8b06e150e30565f"
        )
    ]
)
