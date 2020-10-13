// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "AutocompleteField",
    platforms: [.iOS(.v10)],
    products: [
        .library(
            name: "AutocompleteField",
            targets: ["AutocompleteField"]),
    ],
    targets: [
        .target(
            name: "AutocompleteField",
            path: "Sources"
        ),
    ]
)
