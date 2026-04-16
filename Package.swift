// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "bureau-id-fraud-sdk",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "bureau-id-fraud-sdk",
            targets: ["bureau_id_fraud_sdk"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "bureau_id_fraud_sdk",
            path: "Framework/bureau_id_fraud_sdk.xcframework"
        )
    ]
)
