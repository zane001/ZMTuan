//
//  MoreViewController.swift
//  ZMTuan
//
//  Created by zm on 4/11/16.
//  Copyright © 2016 zm. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dataSource: NSMutableArray!
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initData()
        self.initViews()
       
    }
    
    func initData() {
        let plistPath = NSBundle.mainBundle().pathForResource("MoreData", ofType: "plist")
        dataSource = NSMutableArray(contentsOfFile: plistPath!)
    }

    func initViews() {
        self.tableView = UITableView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        return 4
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if section == 0 {
            return 1
        } else if section == 1 {
            return 5
        } else if section == 2 {
            return 5
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "moreCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        
        cell?.textLabel?.text = dataSource[indexPath.section][indexPath.row] as? String
        cell?.accessoryType = .DisclosureIndicator
        cell?.selectionStyle = .None
        cell?.textLabel?.font = UIFont.systemFontOfSize(15)
        return cell!
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 {
            if indexPath.row == 1 {
//                支付帮助
                let urlStr = "http://i.meituan.com/help/pay?f=ios&ci=1&lat=39.98345504672791&lng=116.3180332149903&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-07-09-47438&token=p19ukJltGhla4y5Jryb1jgCdKjsAAAAAsgAAADHFD3UYGxaY2FlFPQXQj2wCyCrhhn7VVB-KpG_U3-clHlvsLM8JRrnZK35y8UU3DQ&userid=10086&utm_campaign=AgroupBgroupD100Fab_chunceshishuju__a__a___ab_pindaoshenyang__a__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_waimaiwending__a__a___ab_gxtest__gd__leftflow___ab_gxh_82__nostrategy__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___i_group_5_2_deallist_poitype__d__d___ab_i_group_5_3_poidetaildeallist__a__b___ab_pindaoquxincelue0630__b__b1___ab_waimaizhanshi__b__b1___a20141120nanning__m1__leftflow___b1junglehomepagecatesort__b__leftflow___ab_i_group_5_5_onsite__b__b___ab_i_group_5_6_searchkuang__a__leftflowGmore&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7"
                let webVC = HotQueueViewController()
                webVC.urlStr = urlStr
                self.navigationController?.pushViewController(webVC, animated: true)
            } else if indexPath.row == 4 {
                let urlStr = "http://i.meituan.com/help/jobs?ci=1&f=iphone&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-07-09-47438&token=p19ukJltGhla4y5Jryb1jgCdKjsAAAAAsgAAADHFD3UYGxaY2FlFPQXQj2wCyCrhhn7VVB-KpG_U3-clHlvsLM8JRrnZK35y8UU3DQ&userid=10086&utm_campaign=AgroupBgroupD100Fab_chunceshishuju__a__a___ab_pindaoshenyang__a__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_waimaiwending__a__a___ab_gxtest__gd__leftflow___ab_gxh_82__nostrategy__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___i_group_5_2_deallist_poitype__d__d___ab_i_group_5_3_poidetaildeallist__a__b___ab_pindaoquxincelue0630__b__b1___ab_waimaizhanshi__b__b1___a20141120nanning__m1__leftflow___b1junglehomepagecatesort__b__leftflow___ab_i_group_5_5_onsite__b__b___ab_i_group_5_6_searchkuang__a__leftflowGmore&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7&lat=39.98345504672791&lng=116.3180332149903"
                let webVC = HotQueueViewController()
                webVC.urlStr = urlStr
                self.navigationController?.pushViewController(webVC, animated: true)
            }
        }
    }

}
