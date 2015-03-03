//
//  AppDelegate.swift
//  Bluemix Viewer
//
//  Created by Garrett Rowe on 12/14/14.
//  Copyright (c) 2014 Garrett Rowe. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        var hasValidConfiguration = true
        var errorMessage = ""
        
        
        let IBMConfig:IBM_Config = IBM_Config()
        IBMConfig.initIBM()
        
        if(IBMConfig.hasValidConfiguration){
            
            var systemVersion:Float = NSString(string: UIDevice.currentDevice().systemVersion).floatValue
            var iOSVersion:Float = 8.1
            
            if  systemVersion >= iOSVersion {
                
                let settings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert|UIUserNotificationType.Badge|UIUserNotificationType.Sound, categories: nil)
                application.registerUserNotificationSettings(settings)
                application.registerForRemoteNotifications()
                
            } else {
                
                application.registerForRemoteNotificationTypes(UIRemoteNotificationType.Alert|UIRemoteNotificationType.Badge|UIRemoteNotificationType.Sound)
            }
            
        }else{
            NSException().raise()
        }

        return true
    }
    


    
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        println("didFailToRegisterForRemoteNotificationsWithError \(error.description)")
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        println("didRegisterForRemoteNotificationsWithDeviceToken \(deviceToken.description)")
        
        var pushService:IBMPush = IBMPush(version: "8.1")
        var bfTask:BFTask = pushService.registerDevice("testClient", withConsumerId: UIDevice.currentDevice().name, withDeviceToken: deviceToken.description)
        
        if (bfTask.error() != nil) {
            
            NSLog("Registration Error:%@", bfTask.error().description)
        }
        
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        println("didReceiveRemoteNotification fetchCompletionHandler userInfo: \(userInfo.description)")
        let contentAPS = userInfo["aps"] as [NSObject : AnyObject]
        if let contentAvailable = contentAPS["content-available"] as? Int {
            println(" silent or mixed push...")
            println(" contentAvailable:  \(contentAvailable)")
            //Perform background task
            if contentAvailable == 1 {
                completionHandler(UIBackgroundFetchResult.NewData)
            } else {
                completionHandler(UIBackgroundFetchResult.NoData)
            }
        } else {
            println("default push...")
            completionHandler(UIBackgroundFetchResult.NoData)
        }
        
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        println("actionable notificaiton received")
        completionHandler()
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        application.applicationIconBadgeNumber = 0;
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

