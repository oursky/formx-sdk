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
                .linkedFramework("Accelerate"),
                .unsafeFlags(["-Xlinker", "-ObjC"])
            ]
        ),
        .binaryTarget(name: "FormX",
            url: "https://github.com/oursky/formx-sdk/releases/download/0.1.10/FormX.xcframework.zip",
            checksum: "bb119f35bac7585a2e9209b256c307df04b1e31069a986d837e4269dfa7e1cbe"
        )
    ]
)
