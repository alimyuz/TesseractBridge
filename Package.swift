// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "TesseractBridge",
    products: [
        .library(
            name: "TesseractBridge",
            targets: ["TesseractBridge"]),
    ],
    targets: [
        .systemLibrary(name: "CTesseract", pkgConfig: "tesseract"),
        .systemLibrary(name: "CLeptonica", pkgConfig: "lept"),
        
        .target(
            name: "TesseractBridge",
            dependencies: [
                "CTesseract",
                "CLeptonica",
            ],
            swiftSettings: [
                .interoperabilityMode(.Cxx),
            ]
        ),
        .testTarget(
            name: "TesseractBridgeTests",
            dependencies: ["TesseractBridge"],
            path: "Tests/TesseractBridgeTests",
            resources: [
                .process("resources/.")
            ],
            swiftSettings: [
                .interoperabilityMode(.Cxx),
            ]
        )
    ]
)
