//
//  MerchantController.swift
//  ZMTuan
//
//  Created by zm on 4/11/16.
//  Copyright © 2016 zm. All rights reserved.
//

import UIKit

class MerchantController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, MerchantFilterDelegate {

    var merchantArray: NSMutableArray!
    var locationInfoStr: String!
    var kindID: NSInteger!
    var offset: NSInteger!
    var maskView: UIView!
    var groupView: MerchantFilterCell!
    var tableView: UITableView!
    let header = MJRefreshGifHeader()
    let footer = MJRefreshAutoGifFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBarHidden = true

        self.initData()
        self.setNav()
        self.initViews()
        self.initMaskView()
    }
    
    func initData() {
        self.merchantArray = NSMutableArray()
        let userD = NSUserDefaults.standardUserDefaults()
        locationInfoStr = userD.objectForKey("location") as? String
        offset = 0
        kindID = -1
    }

    func setNav() {
        let backView = UIView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 64))
        backView.backgroundColor = RGB(250, g: 250, b: 250)
        self.view.addSubview(backView)
        
//        下划线
        let lineView = UIView(frame: CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5))
        lineView.backgroundColor = RGB(192, g: 192, b: 192)
        backView.addSubview(lineView)
        
//        地图
        let mapBtn = UIButton(type: .Custom)
        mapBtn.frame = CGRectMake(10, 30, 23, 23)
        mapBtn.setImage(UIImage(named: "icon_map"), forState: .Normal)
        mapBtn.addTarget(self, action: #selector(MerchantController.onBackBtn(_:)), forControlEvents: .TouchUpInside)
        backView.addSubview(mapBtn)
        
//        搜索
        let searchBtn = UIButton(type: .Custom)
        searchBtn.frame = CGRectMake(SCREEN_WIDTH-42, 30, 23, 23)
        searchBtn.setImage(UIImage(named: "icon_search"), forState: .Normal)
        searchBtn.addTarget(self, action: #selector(MerchantController.onSearchBtn(_:)), forControlEvents: .TouchUpInside)
        backView.addSubview(searchBtn)
        
//        segment
        let segBtn1 = UIButton(type: .Custom)
        segBtn1.frame = CGRectMake(SCREEN_WIDTH/2-80, 30, 80, 30)
        segBtn1.tag = 20
        segBtn1.setTitle("全部商家", forState: .Normal)
        segBtn1.setTitleColor(UIColor.whiteColor(), forState: .Selected)
        segBtn1.setTitleColor(navigationBarColor, forState: .Normal)
        segBtn1.backgroundColor = navigationBarColor
        segBtn1.selected = true
        segBtn1.layer.borderWidth = 1
        segBtn1.layer.borderColor = navigationBarColor.CGColor
        segBtn1.addTarget(self, action: #selector(MerchantController.onSegBtn(_:)), forControlEvents: .TouchUpInside)
        backView.addSubview(segBtn1)
        
        let segBtn2 = UIButton(type: .Custom)
        segBtn2.frame = CGRectMake(SCREEN_WIDTH/2, 30, 80, 30)
        segBtn2.tag = 21
        segBtn2.setTitle("优惠商家", forState: .Normal)
        segBtn2.setTitleColor(UIColor.whiteColor(), forState: .Selected)
        segBtn2.setTitleColor(navigationBarColor, forState: .Normal)
        segBtn2.backgroundColor = UIColor.whiteColor()
        segBtn2.layer.borderWidth = 1
        segBtn2.layer.borderColor = navigationBarColor.CGColor
        segBtn2.addTarget(self, action: #selector(MerchantController.onSegBtn(_:)), forControlEvents: .TouchUpInside)
        backView.addSubview(segBtn2)
    }
    
    func initViews() {
        let filterView = UIView(frame: CGRectMake(0, 64, SCREEN_WIDTH, 40))
        filterView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(filterView)
        
        let filterName: NSArray = ["全部", "全城", "智能排序"]
        
        for i in 0 ..< 3 {
//            文字
            let filterBtn = UIButton(type: .Custom)
            filterBtn.frame = CGRectMake(CGFloat(i)*SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3-15, 40)
            filterBtn.tag = 100 + i
            filterBtn.setTitle(filterName[i] as? String, forState: .Normal)
            filterBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            filterBtn.setTitleColor(navigationBarColor, forState: .Selected)
            filterBtn.addTarget(self, action: #selector(MerchantController.onFilterBtn(_:)), forControlEvents: .TouchUpInside)
            filterView.addSubview(filterBtn)
//            三角箭头
            let triangleBtn = UIButton(type: .Custom)
            triangleBtn.frame = CGRectMake(CGFloat(i+1)*SCREEN_WIDTH/3-15, 16, 8, 7)
            triangleBtn.tag = 120 + i
            triangleBtn.setImage(UIImage(named: "icon_arrow_dropdown_normal"), forState: .Normal)
            triangleBtn.setImage(UIImage(named: "icon_arrow_dropdown_selected"), forState: .Selected)
            filterView.addSubview(triangleBtn)
        }
//            下划线
        let lineView = UIView(frame: CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5))
        lineView.backgroundColor = RGB(192, g: 192, b: 192)
        filterView.addSubview(lineView)

//           tableView
        self.tableView = UITableView(frame: CGRectMake(0, 64+40, SCREEN_WIDTH, SCREEN_HEIGHT-64-40-49), style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        self.view.addSubview(self.tableView)
        self.setUpTableView()
        
    }

    
    func setUpTableView() {
//        下拉刷新回调
        self.header.setRefreshingTarget(self, refreshingAction: #selector(MerchantController.getFirstPageData))
        
//        普通状态的动画图片
        let idleImages = NSMutableArray()
        for i in 1 ... 60 {
            let image = UIImage(named: "dropdown_anim__000\(i)")
            idleImages.addObject(image!)
        }
        self.header.setImages(idleImages as [AnyObject], forState: .Idle)
        
//        即将刷新的动画图片
        let refreshingImages = NSMutableArray()
        for i in 1 ... 3 {
            let image = UIImage(named: "dropdown_loading_0\(i)")
            refreshingImages.addObject(image!)
        }
        self.header.setImages(refreshingImages as [AnyObject], forState: .Pulling)
        
//        正在刷新的动画图片
        self.header.setImages(refreshingImages as [AnyObject], forState: .Refreshing)
        
//        马上进入刷新状态
        self.tableView.mj_header = header
        self.tableView.mj_header.beginRefreshing()
        
//        上拉刷新
        self.footer.setRefreshingTarget(self, refreshingAction: #selector(MerchantController.loadMoreData))
        
//        设置正在刷新的动画
        self.footer.setImages(refreshingImages as [AnyObject], forState: .Refreshing)
        self.tableView.mj_footer = footer
    }
    
    
//    遮罩
    func initMaskView() {
        self.maskView = UIView(frame: CGRectMake(0, 64+40, SCREEN_WIDTH, SCREEN_HEIGHT-64-40-49))
        maskView.backgroundColor = RGBA(0, g: 0, b: 0, a: 0.5)
        self.view.addSubview(maskView)
        maskView.hidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MerchantController.onTapMaskView(_:)))
        tap.delegate = self
        maskView.addGestureRecognizer(tap)
        
        self.groupView = MerchantFilterCell(frame: CGRectMake(0, 0, SCREEN_WIDTH, maskView.frame.size.height-90))
        groupView.delegate = self
        maskView.addSubview(groupView)
    }

    
//    MARK: 响应事件
    func onTapMaskView(sender: UITapGestureRecognizer) {
        maskView.hidden = true
    }
    
    func onBackBtn(sender: UIButton) {
        print("地图")
    }
    
    func onFilterBtn(sender: UIButton) {
        for i in 0 ..< 3 {
            let btn = self.view.viewWithTag(100+i) as! UIButton
            let triangelBtn = self.view.viewWithTag(120+i) as! UIButton
            btn.selected = false
            triangelBtn.selected = false
        }
        sender.selected = true
        let triBtn = self.view.viewWithTag(20+sender.tag) as! UIButton
        triBtn.selected = true
        maskView.hidden = false
    }
    
    func onSearchBtn(sender: UITapGestureRecognizer) {
//        搜索
    }
    
//    切换Segment
    func onSegBtn(sender: UIButton) {

        let segBtn1 = self.view.viewWithTag(20) as! UIButton
        let segBtn2 = self.view.viewWithTag(21) as! UIButton
        segBtn1.backgroundColor = UIColor.whiteColor()
        segBtn2.backgroundColor = UIColor.whiteColor()
        segBtn1.selected = false
        segBtn2.selected = false
        sender.selected = true
        sender.backgroundColor = navigationBarColor

    }
    
//    MARK: 请求数据
    func onRefreshLocationBtn(sender: UIButton) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { 
            self.getPresentLocation()
        }
    }
    
    func getFirstPageData() {
        offset = 0
        self.refreshData()
    }
    
    func refreshData() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { 
            self.getMerchantList()
        }
    }
    
    func loadMoreData() {
        offset = offset + 20
        self.refreshData()
    }
    
//      获取商家列表
    func getMerchantList() {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let hostStr = "http://api.meituan.com/group/v1/poi/select/cate/"
        let paramsStr = "?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=WOdaAXJTFxIjDdjmt1z%2FJRzB6Y0%3D&__skno=91D0095F-156B-4392-902A-A20975EB9696&__skts=1436408836.151516&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&areaId=-1&ci=1&cityId=1&client=iphone&coupon=all&limit=20&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-09-09-42570&mypos="
        let str = "&sort=smart&userid=10086&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoshenyang__a__leftflow___ab_pindaoquxincelue0630__b__b1___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_i550poi_xxyl__b__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGmerchant&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7"
        let urlStr = "\(hostStr)\(kindID)\(paramsStr)\(delegate.latitude)%2C\(delegate.longitude)&offset=\(offset)\(str)"
        
        NetworkSingleton.sharedManager.sharedSingleton.getMerchantListResult([:], url: urlStr, successBlock: { (responseBody) in
            print("获取商家列表成功")
            let dataArray = responseBody.objectForKey("data") as? NSMutableArray
            if self.offset == 0 {
                self.merchantArray.removeAllObjects()
            }
            
            if dataArray != nil {
                for i in 0 ..< dataArray!.count {
                    let merM = MerchantModel.mj_objectWithKeyValues(dataArray![i])
                    self.merchantArray.addObject(merM)
                }
            }
            self.tableView.reloadData()
            
            if self.offset == 0 && dataArray != nil {
                self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: .Top, animated: true)
            }
            
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            
            }) { (error) in
                print("获取商家列表失败")
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
        }
    }
    
//    获取当前位置信息
    func getPresentLocation() {

        let urlStr = "http://api.meituan.com/group/v1/city/latlng/39.982207,116.311906?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=dhdVkMoRTQge4RJQFlm2iIF2e5s%3D&__skno=9B646232-F7BF-4642-B9B0-9A6ED68003D2&__skts=1436408843.060582&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-09-09-42570&tag=1&userid=10086&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoshenyang__a__leftflow___ab_pindaoquxincelue0630__b__b1___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_i550poi_xxyl__b__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGmerchant&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7"
        locationInfoStr = "正在定位..."
        self.tableView.reloadData()
        
        NetworkSingleton.sharedManager.sharedSingleton.getPresentLocationResult([:], url: urlStr, successBlock: { (responseBody) in
            let dataDic = responseBody.objectForKey("data")
            self.locationInfoStr = dataDic?.objectForKey("detail") as! String
            
            let userD = NSUserDefaults.standardUserDefaults()
            userD.setObject(self.locationInfoStr, forKey: "location")
            self.tableView.reloadData()
            
            }) { (error) in
                print("获取当前位置失败")
        }
    }
    
//    获取cata分组信息
    func getCateList() {
        let urlStr = "http://api.meituan.com/group/v1/poi/cates/showlist?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=hSjSxtGbfd1QtKRMWnoFV4GB8jU%3D&__skno=0DEF926E-FB94-43B8-819E-DD510241BCC3&__skts=1436504818.875030&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&cityId=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-10-12-44726&userid=10086&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i550poi_xxyl__b__leftflow___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_pindaoshenyang__a__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGmerchant&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7"
        NetworkSingleton.sharedManager.sharedSingleton.getCateListResult([:], url: urlStr, successBlock: { (responseBody) in
            
            }) { (error) in
                
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

//     MARK:  UITableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return merchantArray.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 30))
        headView.backgroundColor = RGB(240, g: 239, b: 237)
        
        let locationLabel = UILabel(frame: CGRectMake(10, 0, SCREEN_WIDTH-10-40, 30))
        locationLabel.font = UIFont.systemFontOfSize(13)
        locationLabel.text = "当前位置： \(locationInfoStr)"
        locationLabel.textColor = UIColor.lightGrayColor()
        headView.addSubview(locationLabel)
        
        let refreshBtn = UIButton(type: .Custom)
        refreshBtn.frame = CGRectMake(SCREEN_WIDTH-30, 5, 20, 20)
        refreshBtn.setImage(UIImage(named: "icon_dellist_locate_refresh"), forState: .Normal)
        refreshBtn.addTarget(self, action: #selector(MerchantController.onRefreshLocationBtn(_:)), forControlEvents: .TouchUpInside)
        headView.addSubview(refreshBtn)
        
        return headView
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "merchantCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? MerchantCell
        if cell == nil {
            cell = MerchantCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        
        let merM = merchantArray[indexPath.row] as! MerchantModel
        cell?.setMerModel(merM)

        return cell!
    }
    
//    MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let merM = merchantArray[indexPath.row] as? MerchantModel
        let merDVC = MerchantDetailController()
        merDVC.poiid = merM?.poiid
        self.navigationController?.pushViewController(merDVC, animated: true)
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if ((touch.view?.isKindOfClass(UITableView.classForCoder())) != nil) {
            return false
        }
        if ((touch.view?.superview?.isKindOfClass(UITableView.classForCoder())) != nil) {
            return false
        }
        return true
    }
    
//    MARK: MerchantFilterDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath, withID ID: NSNumber, withName name: String) {
        kindID = ID.integerValue
        maskView.hidden = true
        self.getFirstPageData()
    }

}
