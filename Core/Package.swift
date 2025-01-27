// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "Service",
            targets: ["Service", "SuggestionInjector", "FileChangeChecker", "LaunchAgentManager"]
        ),
        .library(
            name: "Client",
            targets: ["CopilotModel", "Client", "XPCShared", "LaunchAgentManager"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ChimeHQ/LanguageClient", from: "0.3.1"),
    ],
    targets: [
        .target(name: "CGEventObserver"),
        .target(
            name: "CopilotService",
            dependencies: ["LanguageClient", "CopilotModel", "XPCShared"]
        ),
        .testTarget(
            name: "CopilotServiceTests",
            dependencies: ["CopilotService"]
        ),
        .target(
            name: "CopilotModel",
            dependencies: ["LanguageClient"]
        ),
        .testTarget(
            name: "CopilotModelTests",
            dependencies: ["CopilotModel"]
        ),
        .target(
            name: "SuggestionInjector",
            dependencies: ["CopilotModel"]
        ),
        .testTarget(
            name: "SuggestionInjectorTests",
            dependencies: ["SuggestionInjector"]
        ),
        .target(
            name: "Client",
            dependencies: ["CopilotModel", "XPCShared"]
        ),
        .target(
            name: "Service",
            dependencies: ["CopilotModel", "CopilotService", "XPCShared", "CGEventObserver"]
        ),
        .target(
            name: "XPCShared",
            dependencies: ["CopilotModel"]
        ),
        .testTarget(
            name: "ServiceTests",
            dependencies: ["Service", "Client", "CopilotService", "SuggestionInjector", "XPCShared"]
        ),
        .target(name: "FileChangeChecker"),
        .target(name: "LaunchAgentManager"),
    ]
)
