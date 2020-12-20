//
//  AppDelegate.swift
//  BookReview
//
//  Created by Angel Casado on 2/1/16.
//  Copyright © 2016 Televisa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var appFlowController: AppFlowController = ServiceLocator.getService()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appFlowController
        window?.makeKeyAndVisible()
        appFlowController.start()
        return true
    }
}
