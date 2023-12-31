// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "MapLibreSwiftUI",
    platforms: [
        .iOS(.v15),
        .macOS(.v11),
    ],
    products: [
        .library(
            name: "MapLibreSwiftUI",
            targets: ["MapLibreSwiftUI"]),
        .library(
            name: "MapLibreSwiftDSL",
            targets: ["MapLibreSwiftDSL"]),
    ],
    dependencies: [
//        .package(url: "https://github.com/maplibre/maplibre-gl-native-distribution", .upToNextMajor(from: "5.13.0")),
        .package(url: "https://github.com/maplibre/maplibre-gl-native-distribution.git", from: "6.0.0-pre9599200f2529de44ba62d4662cddb445dc19397d"),
        .package(url: "https://github.com/stadiamaps/maplibre-swift-macros.git", branch: "main")
    ],
    targets: [
        .target(
            name: "MapLibreSwiftUI",
            dependencies: [
                .target(name: "InternalUtils"),
                .target(name: "MapLibreSwiftDSL"),
                .product(name: "MapLibre", package: "maplibre-gl-native-distribution"),
            ]),
        .target(
            name: "MapLibreSwiftDSL",
            dependencies: [
                .target(name: "InternalUtils"),
                .product(name: "MapLibre", package: "maplibre-gl-native-distribution"),
                .product(name: "MapLibreSwiftMacros", package: "maplibre-swift-macros")
            ]
        ),
        .target(
            name: "InternalUtils"
        ),
        
        // MARK: Tests
        
        .testTarget(
            name: "MapLibreSwiftDSLTests",
            dependencies: [
                "MapLibreSwiftDSL"
            ]
        ),
    ]
)
