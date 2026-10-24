// swift-tools-version: 6.0
// SPDX-License-Identifier: Apache-2.0
//
// The Apache-2.0 license covers the source code only. The bundled Core ML model
// (BlurSegmentation.mlpackage) is research / non-commercial only; see MODEL_LICENSE.md.

import PackageDescription

let package = Package(
    name: "PixelBlurDetector-iOS",
    platforms: [
        .iOS("16.2"),
    ],
    products: [
        .library(name: "PixelBlurDetectorKit", targets: ["PixelBlurDetectorKit"]),
    ],
    targets: [
        .target(
            name: "PixelBlurDetectorKit",
            resources: [.process("BlurSegmentation.mlpackage")]
        ),
        .testTarget(
            name: "PixelBlurDetectorKitTests",
            dependencies: ["PixelBlurDetectorKit"],
            resources: [.process("resources")]
        ),
    ],
    swiftLanguageModes: [.v5]
)
