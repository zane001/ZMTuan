//
//  ShopViewController.swift
//  ZMTuan
//
//  Created by zm on 4/25/16.
//  Copyright © 2016 zm. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var shopID: String!
    var titleLabel: UILabel!
    var shopInfoModel: ShopInfoModel!
    var recommendTitle: String!
    var shopRecommendArray: NSMutableArray!
    var tableView: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.initData()
        self.setNav()
        self.initViews()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { 
            self.getShopData()
            self.getShopRecommendData()
        }
    }
    
    func initData() {
        self.shopInfoModel = ShopInfoModel()
        self.shopRecommendArray = NSMutableArray()
    }
    
    func setNav() {
        
        let backView = UIView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 64))
        backView.backgroundColor = RGB(250, g: 250, b: 250)
        self.view.addSubview(backView)
        
//        下划线
        let lineView = UIView(frame: CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5))
        lineView.backgroundColor = RGB(192, g: 192, b: 192)
        backView.addSubview(lineView)
        
//        返回
        let backBtn = UIButton(type: .Custom)
        backBtn.frame = CGRectMake(10, 30, 23, 23)
        backBtn.setImage(UIImage(named: "btn_backItem"), forState: .Normal)
        backBtn.addTarget(self, action: #selector(ShopViewController.onBackBtn(_:)), forControlEvents: .TouchUpInside)
        backView.addSubview(backBtn)
        
//        标题
        self.titleLabel = UILabel(frame: CGRectMake(SCREEN_WIDTH/2-80, 30, 160, 30))
        self.titleLabel.textAlignment = .Center
        self.titleLabel.text = "团购详情"
        backView.addSubview(self.titleLabel)
        
//        收藏
        let collectBtn = UIButton(type: .Custom)
        collectBtn.frame = CGRectMake(SCREEN_WIDTH-10-23, 30, 22, 22)
        collectBtn.setImage(UIImage(named: "icon_collect"), forState: .Normal)
        collectBtn.setImage(UIImage(named: "icon_collect_highlighted"), forState: .Highlighted)
        backView.addSubview(collectBtn)
        
//        分享
        let shareBtn = UIButton(type: .Custom)
        shareBtn.frame = CGRectMake(SCREEN_WIDTH-10-23-10-23, 30, 22, 22)
        shareBtn.setImage(UIImage(named: "icon_merchant_share_normal"), forState: .Normal)
        shareBtn.setImage(UIImage(named: "icon_merchant_share_highlighted"), forState: .Highlighted)
        shareBtn.addTarget(self, action: #selector(ShopViewController.onShareBtn(_:)), forControlEvents: .TouchUpInside)
        backView.addSubview(shareBtn)
    
    }

    func initViews() {
        self.tableView = UITableView(frame: CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64), style: .Grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.hidden = true
        
//        SVProgressHUD.showInfoWithStatus("耐心等待~")
    }
    
//    请求店铺详情数据
    func getShopData() {
        let str1 = "http://api.meituan.com/group/v1/deal/list/id/"
        let str2 = "?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=4NDQ%2BojQ%2BZGArOWQCEgWI19Pzus%3D&__skno=803C28CE-8BA8-4831-B2DE-7BCD484348D9&__skts=1435888257.411030&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-03-09-14430&userid=10086&utm_campaign=AgroupBgroupC1080988208017226240_c0_e68cafa9e104898bb8bfcd78b64aef671D100Fab_i_group_5_3_poidetaildeallist__a__b___ab_chunceshishuju__a__a___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_gxtest__gd__leftflow___ab_waimaiwending__a__a___ab_gxh_82__nostrategy__leftflow___i_group_5_2_deallist_poitype__d__d___ab_b_food_57_purepoilist_extinfo__a__a___ab_pindaoshenyang__a__leftflow___ab_pindaoquxincelue0630__b__b1___ab_waimaizhanshi__b__b1___a20141120nanning__m1__leftflow___b1junglehomepagecatesort__b__leftflow___ab_i_group_5_5_onsite__b__b___ab_i_group_5_6_searchkuang__a__leftflowGhomepage_guess_27774127&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7"
        let urlStr = "\(str1)\(self.shopID)\(str2)"
        NetworkSingleton.sharedManager.sharedSingleton.getShopResult([:], url: urlStr, successBlock: { (responseBody) in
            let dataDic = responseBody.objectForKey("data")
            self.shopInfoModel = ShopInfoModel.mj_objectWithKeyValues(dataDic![0])
            self.tableView.hidden = false
            self.tableView.reloadData()
            }) { (error) in
                print("店铺详情请求失败，\(error)")
        }
    }
    
//    请求看了还看数据
    func getShopRecommendData() {
        let str1 = "http://api.meituan.com/group/v1/deal/recommend/collaborative?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=hWCwhGYpNTG7TjXWHOwPykgoKX0%3D&__skno=433ACF85-E134-4FEC-94B5-DA35D33AC753&__skts=1436343274.685593&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&cate=0&ci=1&cityId=1&client=iphone&did="
        let str2 = "&district=-1&fields=id%2Cslug%2Cimgurl%2Cprice%2Ctitle%2Cbrandname%2Crange%2Cvalue%2Cmlls%2Csolds&hasbuy=0&latlng=0.000000%2C0.000000&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-08-15-36746&offset=0&scene=view-v4&userId=10086&userid=10086&utm_campaign=AgroupBgroupD100Fab_i550poi_ktv__d__j___ab_i_group_5_3_poidetaildeallist__a__b___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_i550poi_xxyl__b__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGhomepage_guess_27774127&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7"
        let urlStr = "\(str1)\(self.shopID)\(str2)"
        NetworkSingleton.sharedManager.sharedSingleton.getShopRecommendResult([:], url: urlStr, successBlock: { (responseBody) in
            let dataDic = responseBody["data"]
            self.recommendTitle = dataDic!!["title"] as? String
            let dealsArray = dataDic!!.objectForKey("deals")
            self.shopRecommendArray.removeAllObjects()
            
            for i in 0 ..< dealsArray!.count {
                let shopRecMod = ShopRecommendModel.mj_objectWithKeyValues(dealsArray![i])
                self.shopRecommendArray.addObject(shopRecMod)
                self.tableView.hidden = false
                self.tableView.reloadData()
            }
            }) { (error) in
                print("店铺看了还看请求失败，\(error)")
        }
        
    }
    
    func onBackBtn(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func onShareBtn(sender: UIButton) {
        print("点击了分享按钮")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if (section == 0) {
            return 3
        } else if (section == 1){
            if (self.shopRecommendArray.count == 0) {
                return 0
            } else {
                return self.shopRecommendArray.count + 1
            }
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 190
            } else if indexPath.row == 1 {
                return 65
            } else {
                return 45
            }
        } else {
            if indexPath.row == 0 {
                return 30
            } else {
                return 100
            }
        }
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cellIdentifier = "shopImageCell"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? ShopImageCell
                if cell == nil {
                    cell = ShopImageCell.init(style: .Default, reuseIdentifier: cellIdentifier)
                }
                if self.shopInfoModel.mname != nil {
                    let imgUrl = shopInfoModel.imgurl.stringByReplacingOccurrencesOfString("w.h", withString: "300.0")
                    cell!.shopImageView.sd_setImageWithURL(NSURL(string: imgUrl), placeholderImage: UIImage(named: "bg_customReview_image_default"))
                    cell!.shopNameLabel.text = self.shopInfoModel.mname
                    cell!.shopTitleLabel.text = self.shopInfoModel.title
                }
                cell!.selectionStyle = .None
                return cell!
            } else if indexPath.row == 1 {
                let cellIdentifier = "shopPriceCell"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? ShopPriceCell
                if cell == nil {
                    cell = ShopPriceCell.init(style: .Default, reuseIdentifier: cellIdentifier)
                }
                if self.shopInfoModel.mname != nil {
                    cell?.priceLabel.text = String(self.shopInfoModel.price.doubleValue)
                    cell?.oldPriceLabel.text = String(self.shopInfoModel.value.doubleValue)
                    cell?.oldPriceLabel.attributedText = NSMutableAttributedString(string: (cell?.oldPriceLabel.text)!, attributes: [NSStrikethroughStyleAttributeName: 1])
                }
                cell?.selectionStyle = .None
                return cell!
            } else {
                let cellIdentifier = "shopSoldedCell"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
                if cell == nil {
                    cell = UITableViewCell.init(style: .Default, reuseIdentifier: cellIdentifier)
                
                    let refundBtn = UIButton(type: .Custom)
                    refundBtn.frame = CGRectMake(0, 5, 100, 30)
                    refundBtn.tag = 10
                    refundBtn.setImage(UIImage(named: "icon_deal_anytime_refund"), forState: .Normal)
                    refundBtn.setTitle("随时退", forState: .Normal)
                    refundBtn.setTitleColor(RGB(126, g: 171, b: 63), forState: .Normal)
                    refundBtn.addTarget(self, action: #selector(ShopViewController.onRefundBtn(_:)), forControlEvents: .TouchUpInside)
                    cell?.contentView.addSubview(refundBtn)
                    
                    let soldedLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(refundBtn.frame)+10, 5, 100, 30))
                    soldedLabel.textColor = UIColor.lightGrayColor()
                    soldedLabel.font = UIFont.systemFontOfSize(13)
                    if self.shopInfoModel.mname != nil {
                        soldedLabel.text = String(shopInfoModel.solds)
                    }
                    soldedLabel.tag = 11
                    cell?.contentView.addSubview(soldedLabel)
                }
                cell?.selectionStyle = .None
                return cell!
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let cellIdentifier = "shopRecCell"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
                if cell == nil {
                    cell = UITableViewCell.init(style: .Default, reuseIdentifier: cellIdentifier)
                    cell?.textLabel?.text = self.recommendTitle
                }
                cell?.selectionStyle = .None
                return cell!
            } else {
                let cellIdentifer = "shopRecInfoCell"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifer) as? ShopRecommendCell
                if cell == nil {
                    cell = ShopRecommendCell.init(style: .Default, reuseIdentifier: cellIdentifer)
                }
                if shopRecommendArray.count != 0 {
                    let shopRM = self.shopRecommendArray[indexPath.row - 1] as? ShopRecommendModel
                    cell?.setShopRecommendModel(shopRM!)
                }
                return cell!
            }
        }
        let cellIdentifier = "shopCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .Default, reuseIdentifier: cellIdentifier)
        }
        return cell!
    }
        
    
    func onRefundBtn(sender: UITapGestureRecognizer) {
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 1 {
            if indexPath.row > 0 {
                let shopRM = self.shopRecommendArray[indexPath.row - 1] as! ShopRecommendModel
                let shopVC = ShopViewController()
                shopVC.shopID = String(shopRM.id)
                self.navigationController?.pushViewController(shopVC, animated: true)
            }
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
