import ProjectDescription

let project = Project(name: "DesignSystemExample",
                      organizationName: "Chili Labs",
                      targets: [
                        Target(name: "DesignSystemExample",
                               platform: .iOS,
                               product: .app,
                               bundleId: "lv.chi.DesignSystemExample",
                               infoPlist: "Info.plist",
                               sources: ["Classes/**"],
                               resources: ["Resources/**"],
                               actions: [.pre(path: "swiftlint.sh", name: "SwiftLint")],
                               dependencies: [
                                    .cocoapods(path: ".")
                               ]),
                        Target(name: "DesignSystemExampleTests",
                               platform: .iOS,
                               product: .unitTests,
                               bundleId: "lv.chi.DesignSystemExampleTests",
                               infoPlist: "Info.plist",
                               sources: ["Tests/**"],
                               dependencies: [
                                    .target(name: "DesignSystemExample")
                               ])
                      ])
