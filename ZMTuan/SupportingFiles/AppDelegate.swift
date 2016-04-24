//
//  AppDelegate.swift
//  ZMTuan
//
//  Created by zm on 4/10/16.
//  Copyright © 2016 zm. All rights reserved.
//

import UIKit
import MapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var rootTabBarController: UITabBarController!
    var latitude: Double!
    var longitude: Double!
    var locationManager: CLLocationManager!

    func initRootVC() {
        self.window?.hidden = false
        let vc1 = HomeViewController()
        let nav1 = UINavigationController(rootViewController: vc1)
        let vc2 = OnsiteViewController()
        let nav2 = UINavigationController(rootViewController: vc2)
        let vc3 = MerchantViewController()
        let nav3 = UINavigationController(rootViewController: vc3)
        let vc4 = MineViewController()
        let nav4 = UINavigationController(rootViewController: vc4)
        let vc5 = MoreViewController()
        let nav5 = UINavigationController(rootViewController: vc5)
        
        vc1.title = "团购"
        vc2.title = "上门"
        vc3.title = "商家"
        vc4.title = "我的"
        vc5.title = "更多"
        
        let viewControllers: NSArray = [nav1, nav2, nav3, nav4, nav5]
        
        self.rootTabBarController = UITabBarController()
        self.rootTabBarController.setViewControllers(viewControllers as? [UIViewController], animated: true)
        self.window?.rootViewController = self.rootTabBarController
        
        let tabBar = self.rootTabBarController.tabBar
        let item1: UITabBarItem = tabBar.items![0]
        let item2: UITabBarItem = tabBar.items![1]
        let item3: UITabBarItem = tabBar.items![2]
        let item4: UITabBarItem = tabBar.items![3]
        let item5: UITabBarItem = tabBar.items![4]
        
        item1.selectedImage = UIImage(named: "icon_tabbar_homepage_selected")
        item1.image = UIImage(named: "icon_tabbar_homepage")
        item2.selectedImage = UIImage(named: "icon_tabbar_onsite_selected")
        item2.image = UIImage(named: "icon_tabbar_onsite")
        item3.selectedImage = UIImage(named: "icon_tabbar_merchant_selected")
        item3.image = UIImage(named: "icon_tabbar_merchant_normal")
        item4.selectedImage = UIImage(named: "icon_tabbar_mine_selected")
        item4.image = UIImage(named: "icon_tabbar_mine")
        item5.selectedImage = UIImage(named: "icon_tabbar_misc_selected")
        item5.image = UIImage(named: "icon_tabbar_misc")
        
//        改变UITabBarItem字体颜色
        self.rootTabBarController.tabBar.tintColor = RGB(54, g: 185, b: 175)
        
//        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)

        self.window?.makeKeyAndVisible()
    }
    
//    设置定位
    func setupLocationManager() {
        self.latitude = LATITUDE_DEFAULT
        self.longitude = LONGITUDE_DEFAULT
        self.locationManager = CLLocationManager()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.distanceFilter = 200.0
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
//            需要在Info.plist添加配置，才会弹窗提醒是否allow定位
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.startUpdatingLocation()
        } else {
            print("定位失败，请确认是否开启定位功能")
        }
        
    }
    
//    MARK: CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let cl = locations.last
        self.latitude = cl?.coordinate.latitude
        self.longitude = cl?.coordinate.longitude
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("定位失败")
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.setupLocationManager()
        self.initRootVC()
        return true
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
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

