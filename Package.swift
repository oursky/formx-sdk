// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FormX",
    platforms: [.iOS(.v14)],
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
            url: "https://github.com/oursky/formx-sdk/releases/download/0.4.4/FormX.xcframework.zip",
            checksum: "78400621babea37c9c356833dcdf6355e7e5aab739240c7cef7cb5b8b0b1061d"
        )
    ]
)
