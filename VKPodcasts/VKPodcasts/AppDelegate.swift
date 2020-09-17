//
//  AppDelegate.swift
//  VKPodcasts
//
//  Created by Анна Якусевич on 16.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let podcastsInitialViewController = PodcastInitialViewController()
        let rootNavigationController = UINavigationController(rootViewController: podcastsInitialViewController)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
        return true
    }


}

