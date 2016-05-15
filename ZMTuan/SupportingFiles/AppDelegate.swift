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
    var advImage: UIImageView!

    func initRootVC() {
        self.window?.hidden = false
        let vc1 = HomeViewController()
        let nav1 = UINavigationController(rootViewController: vc1)
        let vc2 = OnsiteViewController()
        let nav2 = UINavigationController(rootViewController: vc2)
        let vc3 = MerchantController()
        let nav3 = UINavigationController(rootViewController: vc3)
        let vc4 = MineViewController()
        let nav4 = UINavigationController(rootViewController: vc4)
        let vc5 = MoreViewController()
        let nav5 = UINavigationController(rootViewController: vc5)
        
        vc1.title = "团购"
        vc2.title = "值得去"
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
        self.initAdvView()
        return true
    }
    
//    初始化广告View
    func initAdvView() {
        let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let filePath: String = paths.objectAtIndex(0).stringByAppendingPathComponent("loading.png")
        let fileManager: NSFileManager = NSFileManager.defaultManager()
        var isDir: ObjCBool = false
        let isExit = fileManager.fileExistsAtPath(filePath, isDirectory: &isDir)
        if isExit {
            print("存在广告图片")
            self.advImage = UIImageView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
            self.advImage.image = UIImage(contentsOfFile: filePath)
            self.window?.addSubview(self.advImage)
//            把本地已存在广告图片删除，重新获取新的图片
            self.performSelector(#selector(AppDelegate.removeAdvImage), withObject: nil, afterDelay: 3)
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { 
                self.getLoadingImage()
            })
        } else {
            print("不存在广告图片")
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                self.getLoadingImage()
            })
        }
    }
    
//    获取启动广告图片
    func getLoadingImage() {
        let scale_screen: CGFloat = UIScreen.mainScreen().scale
        let scaleW = Int16(SCREEN_WIDTH * scale_screen)
        let scaleH = Int16(SCREEN_HEIGHT * scale_screen)
        let urlStr = "http://api.meituan.com/config/v1/loading/check.json?app_name=group&app_version=5.7&ci=1&city_id=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-15-15-51824&platform=iphone&resolution=\(scaleW)%2A\(scaleH)&userid=10086&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i550poi_xxyl__b__leftflow___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_pindaoshenyang__a__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGhomepage&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7"
        
        NetworkSingleton.sharedManager.sharedSingleton.getAdvLoadingImage([:], url: urlStr, successBlock: { (responseBody) in
            let dataArray = responseBody.objectForKey("data")
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { 
                if dataArray!.count > 0 {
                    let data: NSData = NSData(contentsOfURL: NSURL(string: (dataArray![0].objectForKey("imageUrl") as! String))!)!
                    let image: UIImage = UIImage(data: data)!
                    let path: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
                    let filePath: String = path[0].stringByAppendingPathComponent("loading.png")
                    UIImagePNGRepresentation(image)?.writeToFile(filePath, atomically: true)
                }
            })
            }) { (error) in
                print("获取获取启动广告图片失败：\(error)")
        }
    }
    
    func removeAdvImage() {
        UIView.animateWithDuration(0.3, animations: { 
            self.advImage.transform = CGAffineTransformMakeScale(0.5, 0.5)
            self.advImage.alpha = 0
            }) { (finished) in
                self.advImage.removeFromSuperview()
        }
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

