//
//  AppDelegate.swift
//  Spendo
//
//  Created by Igors Nemenonoks on 10/05/2019.
//  Copyright © 2019 Chili Labs. All rights reserved.
//

import UIKit
import RxFlow
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let coordinator = FlowCoordinator()
    let bag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let window = self.window else { return false }

        Typography.registerAllStyles()
        let appFlow = AppFlow(withWindow: window)

        self.coordinator.coordinate(flow: appFlow, with: AppStepper())

        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        //
    }

    func applicationWillResignActive(_ application: UIApplication) {
        //
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        //
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        //
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        //
    }

    func applicationWillTerminate(_ application: UIApplication) {
        //
    }
}
