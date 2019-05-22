//
//  AppDelegate.swift
//  EatEat
//
//  Created by Hellen on 2019-03-07.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initialize()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

//MARK: private extension

private extension AppDelegate {
    func initialize() {
        setupDefaultColors()
        checkNotifications()
    }
    
    func setupDefaultColors() {
        guard let red = UIColor(named: "Eat Red") else { return }
        UITabBar.appearance().tintColor = red
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().isTranslucent = false
        
        UITabBarItem.appearance()
        .setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.normal)
        UITabBarItem.appearance()
        .setTitleTextAttributes([NSAttributedString.Key.foregroundColor: red], for: UIControl.State.selected)
        
        UINavigationBar.appearance().tintColor = red
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().isTranslucent = false
    }
    
    func checkNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge, .providesAppNotificationSettings]) {(isGranted, error) in
            if isGranted {
                print("Notifications permissions granted.")
                self.permissionGranted()
            } else {
                print("Notifications permissions denied.")
            }
        }
    }
    
    func permissionGranted() {
        let optionOne = UNNotificationAction(identifier: Option.one.rawValue, title: "Yes", options: [.foreground])
        let optionTwo = UNNotificationAction(identifier: Option.two.rawValue
            , title: "No", options: [.foreground])
        let hiddenRestaurantPlaceholder = "%u new restaurant invites."
        let summaryFormat = "%u more restaurant invites for %@"
        let category = UNNotificationCategory(identifier: Identifier.reservationCategory.rawValue, actions: [optionOne, optionTwo], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: hiddenRestaurantPlaceholder, categorySummaryFormat: summaryFormat, options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
}
