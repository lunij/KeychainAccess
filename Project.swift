
import ProjectDescription

let name = "KeychainAccess"
let bundleIdentifierPrefix = "com.oss.swift"

let project = Project(
    name: name,
    packages: [
        .local(path: ".")
    ],
    settings: .settings(defaultSettings: .recommended),
    targets: [
        Target(
            name: "\(name)Tests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "\(bundleIdentifierPrefix).\(name)Tests",
            deploymentTarget: .iOS11,
            infoPlist: .default,
            sources: [
                "Tests/\(name)Tests/**"
            ],
            dependencies: [
                .package(product: name),
                .target(name: "TestHost")
            ],
            settings: .settings(defaultSettings: .recommended)
        ),
        Target(
            name: "TestHost",
            platform: .iOS,
            product: .app,
            bundleId: "\(bundleIdentifierPrefix).\(name).TestHost",
            deploymentTarget: .iOS11,
            infoPlist: .default,
            sources: ["TestHost/**"],
            resources: ["TestHost/Assets.xcassets"],
            entitlements: "TestHost/TestHost.entitlements"
        ),
        Target(
            name: "Demo",
            platform: .iOS,
            product: .app,
            bundleId: "\(bundleIdentifierPrefix).\(name).Demo",
            infoPlist: .extendingDefault(with: ["UILaunchStoryboardName": "LaunchScreen"]),
            sources: ["Demo/*.swift"],
            resources: ["Demo/LaunchScreen.storyboard"],
            entitlements: "Demo/Demo.entitlements",
            dependencies: [
                .package(product: name)
            ]
        )
    ]
)

extension DeploymentTarget {
    static var iOS11: Self {
        .iOS(targetVersion: "11.0", devices: [.iphone, .ipad, .mac])
    }
}
