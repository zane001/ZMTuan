//
//  MineViewController.swift
//  ZMTuan
//
//  Created by zm on 4/11/16.
//  Copyright © 2016 zm. All rights reserved.
//

import UIKit

class MineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dataSourceArray: NSMutableArray!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initData()
        self.initViews()
       
    }
    
    func initData() {
        dataSourceArray = NSMutableArray()
        let dic1 = NSMutableDictionary()
        dic1.setValue("团购订单", forKey: "title")
        dic1.setValue("icon_mine_onsite", forKey: "image")
        dataSourceArray.addObject(dic1)
        
        let dic2 = NSMutableDictionary()
        dic2.setValue("预定订单", forKey: "title")
        dic2.setValue("icon_mine_onsite", forKey: "image")
        dataSourceArray.addObject(dic2)
        
        let dic3 = NSMutableDictionary()
        dic3.setValue("上门订单", forKey: "title")
        dic3.setValue("icon_mine_onsite", forKey: "image")
        dataSourceArray.addObject(dic3)
        
        let dic4 = NSMutableDictionary()
        dic4.setValue("我的评价", forKey: "title")
        dic4.setValue("icon_mine_onsite", forKey: "image")
        dataSourceArray.addObject(dic4)
        
        let dic5 = NSMutableDictionary()
        dic5.setValue("每日推荐", forKey: "title")
        dic5.setValue("icon_mine_onsite", forKey: "image")
        dataSourceArray.addObject(dic5)
        
        let dic6 = NSMutableDictionary()
        dic6.setValue("会员俱乐部", forKey: "title")
        dic6.setValue("icon_mine_onsite", forKey: "image")
        dataSourceArray.addObject(dic6)
        
        let dic7 = NSMutableDictionary()
        dic7.setValue("我的抽奖", forKey: "title")
        dic7.setValue("icon_mine_onsite", forKey: "image")
        dataSourceArray.addObject(dic7)
        
        let dic8 = NSMutableDictionary()
        dic8.setValue("我的抵用券", forKey: "title")
        dic8.setValue("icon_mine_onsite", forKey: "image")
        dataSourceArray.addObject(dic8)
    }
    
    func initViews() {
        self.tableView = UITableView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), style: .Grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 8
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        } else {
            return 40
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 75
        } else {
            return 5
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 75))
        footerView.backgroundColor = RGB(239, g: 239, b: 244)
        return footerView
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = UIView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 5))
            headerView.backgroundColor = UIColor.init(patternImage: UIImage(named: "bg_login")!)
            
//            头像
            let userImage = UIImageView(frame: CGRectMake(10, 10, 55, 55))
            userImage.layer.masksToBounds = true
            userImage.layer.cornerRadius = 27
            userImage.image = UIImage(named: "icon_mine_default_portrait")
            headerView.addSubview(userImage)
            
//            用户名
            let userNameLabel = UILabel(frame: CGRectMake(10+55+5, 10+5, 200, 30))
            userNameLabel.font = UIFont.systemFontOfSize(13)
            userNameLabel.text = "zane001"
            headerView.addSubview(userNameLabel)
            
//            账户余额
            let moneyLabel = UILabel(frame: CGRectMake(10+55+5, 30+10, 200, 30))
            moneyLabel.font = UIFont.systemFontOfSize(13)
            moneyLabel.text = "账户余额：88888,888元"
            headerView.addSubview(moneyLabel)
            
//            右箭头
            let arrowImage = UIImageView(frame: CGRectMake(SCREEN_WIDTH-10-24, 30, 12, 24))
            arrowImage.image = UIImage(named: "icon_mine_accountViewRightArrow")
            headerView.addSubview(arrowImage)
            
            return headerView
        } else {
            let headerView = UIView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 5))
            headerView.backgroundColor = RGB(239, g: 239, b: 244)
            return headerView
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "mineCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        
        if indexPath.section == 1 {
            cell!.textLabel?.text = dataSourceArray[indexPath.row]["title"] as? String
            let imgStr = dataSourceArray[indexPath.row]["image"] as! String
            cell!.imageView?.image = UIImage(named: imgStr)
            cell!.selectionStyle = .None
            cell!.accessoryType = .DisclosureIndicator
            cell!.textLabel?.font = UIFont.systemFontOfSize(15)
            
        } else {
            cell!.textLabel?.text = "我的标题"
            cell!.accessoryType = .DisclosureIndicator
            cell!.selectionStyle = .None
        }
        

        return cell!
    }




    

}
