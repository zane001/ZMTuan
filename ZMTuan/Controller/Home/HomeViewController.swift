//
//  HomeViewController.swift
//  ZMTuan
//
//  Created by zm on 4/11/16.
//  Copyright © 2016 zm. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RushDelegate, DiscountDelegate {

    var menuArray: NSMutableArray!
    var tableView: UITableView!
//    名店抢购
    var rushArray: NSMutableArray!
//    折扣
    var discountArray: NSMutableArray!
//    猜你喜欢
    var recommendArray: NSMutableArray!
    
//   下拉刷新、上拉刷新
    let header = MJRefreshGifHeader()
    let footer = MJRefreshAutoGifFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.initData()
        self.setNav()
        self.initTableView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func initData() {
        rushArray = []
        discountArray = []
        recommendArray = []
        let plistPath: String = NSBundle.mainBundle().pathForResource("menuData", ofType: "plist")!
        menuArray = NSMutableArray.init(contentsOfFile: plistPath)

    }
    
//    设置上方导航条
    func setNav() {
        let backView: UIView = UIView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 64))
        backView.backgroundColor = navigationBarColor
        self.view.addSubview(backView)
        
        let cityBtn: UIButton = UIButton(type: .Custom)
        cityBtn.frame = CGRectMake(10, 30, 40, 25)
        cityBtn.setTitle("北京", forState: .Normal)
        backView.addSubview(cityBtn)
        
        let arrowImage = UIImage(named: "icon_homepage_downArrow")
        let arrowImageView: UIImageView = UIImageView(image: arrowImage)
        arrowImageView.frame = CGRectMake(CGRectGetMaxX(cityBtn.frame), 38, 13, 10)
        backView.addSubview(arrowImageView)
        
        /*
        let searchView = UIView(frame: CGRectMake(CGRectGetMaxX(arrowImageView.frame)+10, 30, 200, 25))
        searchView.backgroundColor = RGB(7, g: 170, b: 153)
        searchView.layer.masksToBounds = true
        searchView.layer.cornerRadius = 12
        backView.addSubview(searchView)
        

        let searchImage = UIImage(named: "icon_homepage_search")
        let searchImageView = UIImageView(image: searchImage)
        searchImageView.frame = CGRectMake(5, 3, 15, 15)
        searchView.addSubview(searchImageView)

        
        let placeHolderLabel = UILabel(frame: CGRectMake(25, 0, 150, 25))
        placeHolderLabel.font = UIFont.boldSystemFontOfSize(13)
        placeHolderLabel.text = "请输入商家、类别、商圈"
        placeHolderLabel.textColor = UIColor.whiteColor()
        searchView.addSubview(placeHolderLabel)
        */
        
//      UISearchBar包括一个UIView，该UIView包括UISearchBarBackground和UITextField
        let searchBar = UISearchBar(frame: CGRectMake(CGRectGetMaxX(arrowImageView.frame)+10, 30, 200, 28))
        searchBar.placeholder = "请输入商家、类别、商圈"
        searchBar.subviews[0].subviews[0].removeFromSuperview()
        backView.addSubview(searchBar)

        let mapBtn = UIButton(type: .Custom)
        mapBtn.frame = CGRectMake(SCREEN_WIDTH-42, 30, 42, 30)
        mapBtn.setImage(UIImage(named: "icon_homepage_map_old"), forState: .Normal)
        mapBtn.addTarget(self, action: #selector(HomeViewController.onMapBtnTap(_:)), forControlEvents: .TouchUpInside)
        backView.addSubview(mapBtn)
    }
    
    func onMapBtnTap(sender: UIButton) {
        let mapVC = MapViewController()
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    func initTableView() {
        self.tableView = UITableView(frame: CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-49-64), style: .Grouped)
        self.tableView.registerClass(HomeMenuCell.classForCoder(), forCellReuseIdentifier: "menuCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        self.refreshTableView()
    }
    
//    下拉刷新
    func refreshTableView() {
//        添加下拉刷新的动态图片，并设置下拉刷新的回调
        self.header.setRefreshingTarget(self, refreshingAction: #selector(HomeViewController.refreshData))
        
//        设置普通状态的动画图片
        let idleImages = NSMutableArray()
//        闭区间，如果开区间可以用 ..<
        for i in 1 ... 60 {
            let image = UIImage(named: "dropdown_anim__000\(i)")
            idleImages.addObject(image!)
        }
        self.header.setImages(idleImages as [AnyObject], forState: .Idle)

//        设置即将刷新的动画图片
        let refreshingImages = NSMutableArray()
        for i in 1 ... 3 {
            let image = UIImage(named: "dropdown_loading_0\(i)")
            refreshingImages.addObject(image!)
        }
        self.header.setImages(refreshingImages as [AnyObject], forState: .Pulling)
        
//        设置正在刷新的动画图片
        self.header.setImages(refreshingImages as [AnyObject], forState: .Refreshing)

        self.tableView.mj_header = header
//        马上进入刷新状态
        self.tableView.mj_header.beginRefreshing()
    }
    
    
    func refreshData() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { 
            self.getRushBuyData()
            self.getDiscountData()
            self.getRecommendData()
            dispatch_async(dispatch_get_main_queue(), { 
                
            })
        }
    }
    
//    请求名店抢购数据
    func getRushBuyData() {
        let url = "http://api.meituan.com/group/v1/deal/activity/1?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=NF9S7jqv3TVBAoEURoapWJ5VBdQ%3D&__skno=FB6346F3-98FF-4B26-9C36-DC9022236CC3&__skts=1434530933.316028&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-06-17-14-50363&ptId=iphone_5.7&userid=10086&utm_campaign=AgroupBgroupD100Fab_chunceshishuju__a__a___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_gxtest__gd__leftflow___ab_gxh_82__nostrategy__leftflow___ab_pindaoshenyang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_b_food_57_purepoilist_extinfo__a__a___ab_trip_yidizhoubianyou__b__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___ab_waimaizhanshi__b__b1___a20141120nanning__m1__leftflow___ab_pindaoquxincelue__a__leftflow___ab_i_group_5_5_onsite__b__b___ab_i_group_5_6_searchkuang__a__leftflow&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7"
        
//        第一个参数不能用nil，需要用[:]
        NetworkSingleton.sharedManager.sharedSingleton.getRushBuyResult([:], url: url, successBlock: { (responseBody) in
//            print("请求抢购成功")
            let dataDict = responseBody.objectForKey("data")
            let rushDataModel: RushDataModel = RushDataModel.mj_objectWithKeyValues(dataDict)
//            先将rushArray原有数据清空
            if self.rushArray != nil {
                self.rushArray.removeAllObjects()
            }
            
//            将数据放入rushArray，展示数据
            for i in 0 ..< rushDataModel.deals.count {
                let deals = RushDealsModel.mj_objectWithKeyValues(rushDataModel.deals[i])
                self.rushArray.addObject(deals!)
            }
            self.tableView.reloadData()
//            self.tableView.mj_header.endRefreshing()
            }) { (error) in
//                print(error)
                self.tableView.mj_header.endRefreshing()
        }
        
    }
    
//    请求折扣数据
    func getDiscountData() {
        let url = "http://api.meituan.com/group/v1/deal/topic/discount/city/1?ci=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-06-17-14-50363&userid=10086&utm_campaign=AgroupBgroupD100Fab_chunceshishuju__a__a___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_gxtest__gd__leftflow___ab_gxh_82__nostrategy__leftflow___ab_pindaoshenyang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_b_food_57_purepoilist_extinfo__a__a___ab_trip_yidizhoubianyou__b__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___ab_waimaizhanshi__b__b1___a20141120nanning__m1__leftflow___ab_pindaoquxincelue__a__leftflow___ab_i_group_5_5_onsite__b__b___ab_i_group_5_6_searchkuang__a__leftflow&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7"
        NetworkSingleton.sharedManager.sharedSingleton.getDiscountResult([:], url: url, successBlock: { (responseBody) in
            let dataDict = responseBody.objectForKey("data")!

            if self.discountArray != nil {
                self.discountArray.removeAllObjects()
            }
            for i in 0 ..< dataDict.count {
                let discount = DiscountModel.mj_objectWithKeyValues(dataDict[i])
                self.discountArray.addObject(discount)
            }

            self.tableView.reloadData()
//            self.tableView.mj_header.endRefreshing()
            }) { (error) in
                print(error)
                self.tableView.mj_header.endRefreshing()
        }
    }
    
//    请求“推荐”数据
    func getRecommendData() {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let url = "http://api.meituan.com/group/v1/recommend/homepage/city/1?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=mrUZYo7999nH8WgTicdfzaGjaSQ=&__skno=51156DC4-B59A-4108-8812-AD05BF227A47&__skts=1434530933.303717&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&client=iphone&limit=40&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-06-17-14-50363&offset=0&position=\(delegate.latitude),\(delegate.longitude)&userId=10086&userid=10086&utm_campaign=AgroupBgroupD100Fab_chunceshishuju__a__a___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_gxtest__gd__leftflow___ab_gxh_82__nostrategy__leftflow___ab_pindaoshenyang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_b_food_57_purepoilist_extinfo__a__a___ab_trip_yidizhoubianyou__b__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___ab_waimaizhanshi__b__b1___a20141120nanning__m1__leftflow___ab_pind"
//        print("latitude \(delegate.latitude) -- longitude \(delegate.longitude)")
        NetworkSingleton.sharedManager.sharedSingleton.getRecommendResult([:], url: url, successBlock: { (responseBody) in
            let dataDict = responseBody.objectForKey("data")!
            if self.recommendArray != nil {
                self.recommendArray.removeAllObjects()
            }
            for i in 0 ..< dataDict.count {
                let recommend = RecommendModel.mj_objectWithKeyValues(dataDict[i])
                self.recommendArray.addObject(recommend)
            }
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
            }) { (error) in
                print(error)
                self.tableView.mj_header.endRefreshing()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        推荐的row是根据结果的数量来展示，+1是加上title的
        if section == 3 {
            return recommendArray.count + 1
        } else {
            return 1
        }
        
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 180
        } else if indexPath.section == 1 {
            if rushArray.count != 0 {
                return 120
            } else {
                return 0
            }
        } else if indexPath.section == 2 {
            if discountArray.count != 0 {
                return 160
            } else {
                return 0
            }
        } else if indexPath.section == 3 {
            if indexPath.row != 0 {
                return 100
            } else {
                return 35
            }
        } else {
            return 70
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {

            let cellIdentifier = "menuCell"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)

            let menuCell = HomeMenuCell()
            cell = menuCell.initWithStyle(.Default, reuseIdentifier: cellIdentifier, menuArray: menuArray)

            cell!.selectionStyle = UITableViewCellSelectionStyle.None
            return cell!
        } else if indexPath.section == 1 {
//            名店抢购
            if rushArray.count == 0 {
                let cellIdentifier = "noMoreCell"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
                if cell == nil {
                    cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
                }
                cell?.selectionStyle = UITableViewCellSelectionStyle.None
                return cell!
            } else {
                let cellIdentifier = "rushCell"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? RushCell
                if cell == nil {
                    cell = RushCell(style: .Default, reuseIdentifier: cellIdentifier)
                }
                if rushArray.count != 0 {
                    cell?.setRushData(rushArray)
                }
                cell?.delegate = self
                cell?.selectionStyle = UITableViewCellSelectionStyle.None
                return cell!
            }
        } else if indexPath.section == 2 {
//            折扣
            if discountArray.count == 0 {
                let cellIdentifier = "noMoreCell"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
                if cell == nil {
                    cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
                }
                cell?.selectionStyle = .None
                return cell!
            } else {
                let cellIdentifier = "discountCell"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? DiscountCell
                if cell == nil {
                    cell = DiscountCell(style: .Default, reuseIdentifier: cellIdentifier)
                }
                if discountArray.count != 0 {
                    cell?.setDiscountArray(discountArray)
                }
                cell?.delegate = self
                cell?.selectionStyle = .None
                return cell!
            }
        } else {
//            猜你喜欢
            if indexPath.row == 0 {
                let cellIdentifier = "noMoreCell"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
                if cell == nil {
                    cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
                }
                cell?.textLabel?.text = "猜你喜欢"
                cell?.selectionStyle = .None
                return cell!
            } else {
                let cellIdentifier = "recommendCell"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? RecommendCell
                if cell == nil {
                    cell = RecommendCell(style: .Default, reuseIdentifier: cellIdentifier)
                }
                if recommendArray.count != 0 {
                    let recommend = recommendArray[indexPath.row - 1] as! RecommendModel
                    cell?.setRecommendData(recommend)
                }
                cell?.selectionStyle = .None
                return cell!
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 1
        } else {
            return 5
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 3 {
            if indexPath.row != 0 {
                let recommend = recommendArray[indexPath.row-1] as! RecommendModel
                let shopID = recommend.id.stringValue
                let shopVC = ShopViewController(nibName: nil, bundle: nil)
                shopVC.shopID = shopID
                self.navigationController?.pushViewController(shopVC, animated: true)
            }
        }
    }
    
//    MARK: RushDelegate
    func didSelectRushIndex(index: NSInteger) {
        let rushVC = RushViewController()
        self.navigationController?.pushViewController(rushVC, animated: true)
    }
    
//  MARK: DiscountDelegate
    func didSelectUrl(urlStr: String, withType type: NSNumber, withId ID: NSNumber, withTitle title: String) {
        let num = NSNumber(long: 1)
        if type.isEqualToValue(num) {
            let discountVC = DiscountViewController()
            discountVC.urlStr = urlStr
            self.navigationController?.pushViewController(discountVC, animated: true)
        } else {
            let IDStr = ID.stringValue
            let disOCVC = DiscountOCViewController()
            disOCVC.ID = IDStr
            disOCVC.title = title
            self.navigationController?.pushViewController(disOCVC, animated: true)
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
