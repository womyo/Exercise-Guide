import ProjectDescription

let project = Project(
    name: "ExerciseGuide",
    targets: [
        .target(
            name: "ExerciseGuide",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.ExerciseGuide",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                    "UIApplicationSceneManifest": [
                        "UIApplicationSupportsMultipleScenes": false,
                        "UISceneConfigurations": [
                            "UIWindowSceneSessionRoleApplication": [
                                [
                                    "UISceneConfigurationName": "Default Configuration",
                                    "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                                ],
                            ]
                        ]
                    ],
                ]
            ),
            sources: ["ExerciseGuide/Sources/**"],
            resources: ["ExerciseGuide/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "ExerciseGuideTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.ExerciseGuideTests",
            infoPlist: .default,
            sources: ["ExerciseGuide/Tests/**"],
            resources: [],
            dependencies: [.target(name: "ExerciseGuide")]
        ),
    ]
)
