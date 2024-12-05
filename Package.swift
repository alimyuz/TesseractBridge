// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "TesseractKit",
    products: [
        .library(
            name: "TesseractKit",
            targets: ["TesseractKit"]),
    ],
    targets: [
        .systemLibrary(name: "CTesseract", pkgConfig: "tesseract"),
        .systemLibrary(name: "CLeptonica", pkgConfig: "lept"),
        
        .target(
            name: "TesseractKit",
            dependencies: [
                "CTesseract",
                "CLeptonica",
            ],
            path: "Sources/TesseractKit",
            swiftSettings: [
                .interoperabilityMode(.Cxx),
            ]
        ),
        .testTarget(
            name: "TesseractKitTests",
            dependencies: ["TesseractKit"],
            path: "Tests/TesseractKitTests",
            resources: [
                .process("resources/.")
            ],
            swiftSettings: [
                .interoperabilityMode(.Cxx),
            ]
        )
    ]
)
