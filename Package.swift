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
            url: "https://github.com/oursky/formx-sdk/releases/download/0.1.13/FormX.xcframework.zip",
            checksum: "93506388fa70c56c820a5c2276eef20b74b5b93f945fafc238d49162cae12dd6"
        )
    ]
)
