//
//  AppDelegate.swift
//  GYJingDong
//
//  Created by zhuguangyang on 16/6/14.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit
import Reachability
//状态栏显示网络状态
import JDStatusBarNotification

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var reach: Reachability?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        reach = Reachability(hostName: "www.baidu.com")
        reach!.startNotifier()
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.reachabilityChanged(_:)), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        
        //设置文本字体大小颜色
        //        let attr = [NSFontAttributeName: UIFont.systemFontOfSize(20),NSForegroundColorAttributeName: UIColor.whiteColor()]
        let attr = [NSForegroundColorAttributeName: UIColor.white]
        
        UINavigationBar.appearance().titleTextAttributes = attr
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        window?.makeKeyAndVisible()
        // Allocate a reachability object
        
        window?.rootViewController = GYTabBarViewController()
        
        return true
    }
    
    func reachabilityChanged(_ notification:Notification) {
        
        let reach1 = notification.object
        print(reach?.currentReachabilityString())
        if ((reach1 as AnyObject).isKind(of: Reachability.classForCoder())) != false {
            let status: NetworkStatus = ((reach1 as AnyObject).currentReachabilityStatus())
            
            switch status {
            case .NotReachable:
                JDStatusBarNotification.show(withStatus: "网络不可用")
                JDStatusBarNotification.dismiss(after: 2.0)
                break
            case .ReachableViaWiFi:
                JDStatusBarNotification.show(withStatus: "WIFI")
                JDStatusBarNotification.dismiss(after: 2.0)
                break
            case .ReachableViaWWAN:
                JDStatusBarNotification.show(withStatus: "普通网络")
                JDStatusBarNotification.dismiss(after: 2.0)
                break
            }
            
        }
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

