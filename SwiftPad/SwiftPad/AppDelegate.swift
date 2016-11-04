//
//  AppDelegate.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/15.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let UMENG_APPKEY = "5423cd47fd98c58f04000c52"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UMSocialData.setAppKey("5423cd47fd98c58f04000c52")
        UMSocialWechatHandler.setWXAppId("wx850b854f6aad6764", appSecret: "39859316eb9e664168d2af929e46f971", url: "http://www.umeng.com/social")
        UMSocialQQHandler.setQQWithAppId("1101982202", appKey: "c7394704798a158208a74ab60104f0ba", url: "http://www.umeng.com/social")
        UMSocialSinaSSOHandler.openNewSinaSSO(withRedirectURL: "http://sns.whalecloud.com/sina2/callback")
        
        window = UIWindow();
        let tabBarController:APPTabbarController? = APPTabbarController();
        let navigationController:UINavigationController? = UINavigationController.init(rootViewController: tabBarController!);
        window?.rootViewController = navigationController;
        window?.makeKeyAndVisible();
        
        // 设置导航条背景色
        UINavigationBar.appearance().barTintColor = UITool.UIColorFromRGB(rgbValue: 0x0a5090)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white];
        
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
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
       return  UMSocialSnsService.handleOpen(url)
    }
    


}

