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
            url: "https://github.com/oursky/formx-sdk/releases/download/0.1.24/FormX.xcframework.zip",
            checksum: "70fe02a1d2aebbe0b7af3b57b0f08233c5e98d11477c1b3a6f977b4e3363374f"
        )
    ]
)
