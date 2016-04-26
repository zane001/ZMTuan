//
//  ShopViewController.swift
//  ZMTuan
//
//  Created by zm on 4/25/16.
//  Copyright © 2016 zm. All rights reserved.
//

import UIKit

class ShopViewController: UITableViewController {

    var shopID: String!
    var titleLabel: UILabel!
    var shopInfoModel: ShopInfoModel!
    var recommendTitle: String!
    var shopRecommendArray: NSMutableArray!
    
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
        collectBtn.setImage(UIImage(named: "icon_collect_highlighted"), forState: .Highlighted)
        backView.addSubview(collectBtn)
        
//        分享
        let shareBtn = UIButton(type: .Custom)
        shareBtn.frame = CGRectMake(SCREEN_WIDTH-10-23-10-23, 30, 22, 22)
        shareBtn.setImage(UIImage(named: "icon_merchant_share_highlighted"), forState: .Highlighted)
        shareBtn.addTarget(self, action: #selector(ShopViewController.onShareBtn(_:)), forControlEvents: .TouchUpInside)
        backView.addSubview(shareBtn)
    
    }

    func initViews() {
        
    }
    
    func getShopData() {
        
    }
    
    func getShopRecommendData() {
        
    }
    
    func onBackBtn(sender: UIButton) {
        
    }
    
    func onShareBtn(sender: UIButton) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
