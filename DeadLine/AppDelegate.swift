//
//  AppDelegate.swift
//  DeadLines
//
//  Created by David Lin on 2022-08-31.
//

import UIKit
import UserNotifications
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        //MARK: Authorization
        let center = UNUserNotificationCenter.current()
        
        
        //Delegate for UNUserNotificationCenterDelegate
        center.delegate = self
        
        //Permission for request alert, soud and badge
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            // Enable or disable features based on authorization.
            if(!granted){
                print("not accept authorization")
            }else{
                print("accept authorization")
                
                center.delegate = self
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    willPresent notification: UNNotification,
                                    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .sound])
    }
    
    func registerBackgroundTasks() {
       // Declared at the "Permitted background task scheduler identifiers" in info.plist
       let backgroundAppRefreshTaskSchedulerIdentifier = "ca.softtrak.DeadlineBackgroundAppRefreshIdentifier"
       let backgroundProcessingTaskSchedulerIdentifier = "ca.softtrak.DeadlineBackgroundProcessingIdentifier"

       // Use the identifier which represents your needs
       BGTaskScheduler.shared.register(forTaskWithIdentifier: backgroundAppRefreshTaskSchedulerIdentifier, using: nil) { (task) in
          print("BackgroundAppRefreshTaskScheduler is executed NOW!")
          print("Background time remaining: \(UIApplication.shared.backgroundTimeRemaining)s")
          task.expirationHandler = {
            task.setTaskCompleted(success: false)
          }

          // Do some data fetching and call setTaskCompleted(success:) asap!
          let isFetchingSuccess = true
          task.setTaskCompleted(success: isFetchingSuccess)
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        submitBackgroundTasks()
    }
      
    func submitBackgroundTasks() {
        // Declared at the "Permitted background task scheduler identifiers" in info.plist
        let backgroundAppRefreshTaskSchedulerIdentifier = "ca.softtrak.DeadlineBackgroundAppRefreshIdentifier"
        let timeDelay = 1.0

        do {
            let backgroundAppRefreshTaskRequest = BGAppRefreshTaskRequest(identifier: backgroundAppRefreshTaskSchedulerIdentifier)
            backgroundAppRefreshTaskRequest.earliestBeginDate = Date(timeIntervalSinceNow: timeDelay)
            try BGTaskScheduler.shared.submit(backgroundAppRefreshTaskRequest)
            print("Submitted task request")
        } catch {
            print("Failed to submit BGTask")
        }
    }

    func registerForPushNotifications() {
      UNUserNotificationCenter.current()
        .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
          print("Permission granted: \(granted)")
        }
    }
    
    func getNotificationSettings() {
      UNUserNotificationCenter.current().getNotificationSettings { settings in
        print("Notification settings: \(settings)")
      }
    }
}

