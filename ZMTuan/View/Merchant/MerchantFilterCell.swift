//
//  MerchantFilterCell.swift
//  ZMTuan
//
//  Created by zm on 4/30/16.
//  Copyright © 2016 zm. All rights reserved.
//

import UIKit

protocol MerchantFilterDelegate: AnyObject {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath, withID ID: NSNumber, withName name: String)
}

class MerchantFilterCell: UIView, UITableViewDelegate, UITableViewDataSource {

    var tableViewOfGroup: UITableView!
    var tableViewOfDetail: UITableView!
    var bigGroupArray = NSMutableArray()  //左边分组的数据源
    var smallGroupArray = NSMutableArray()    //右边分组的数据源
    var bigSelectedIndex: NSInteger!
    var smallSelectedIndex: NSInteger!
    var delegate: MerchantFilterDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { 
            self.getCateListData()
        }
    }
    
    
    func initViews() {
//        分组
        self.tableViewOfGroup = UITableView(frame: CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height), style: .Plain)
        self.tableViewOfGroup.delegate = self
        self.tableViewOfGroup.dataSource = self
        self.tableViewOfGroup.backgroundColor = UIColor.grayColor()
        self.tableViewOfGroup.tag = 10
        self.tableViewOfGroup.separatorStyle = .None
        self.addSubview(tableViewOfGroup)
        
//        详情
        self.tableViewOfDetail = UITableView(frame: CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height), style: .Plain)
        self.tableViewOfDetail.delegate = self
        self.tableViewOfDetail.dataSource = self
        self.tableViewOfDetail.tag = 20
        self.tableViewOfDetail.separatorStyle = .None
        self.tableViewOfDetail.backgroundColor = RGB(242, g: 242, b: 242)
        self.addSubview(tableViewOfDetail)
        
        self.userInteractionEnabled = true
    }
    
//    获取Cate分组信息
    func getCateListData() {
        let url = "http://api.meituan.com/group/v1/poi/cates/showlist?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=hSjSxtGbfd1QtKRMWnoFV4GB8jU%3D&__skno=0DEF926E-FB94-43B8-819E-DD510241BCC3&__skts=1436504818.875030&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&cityId=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-10-12-44726&userid=10086&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i550poi_xxyl__b__leftflow___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_pindaoshenyang__a__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGmerchant&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7"
        
        NetworkSingleton.sharedManager.sharedSingleton.getCateListResult([:], url: url, successBlock: { (responseBody) in
            let dataArray = responseBody.objectForKey("data")
            for i in 0 ..< dataArray!.count {
                let cateM = MerCateGroupModel.mj_objectWithKeyValues(dataArray![i])
                self.bigGroupArray.addObject(cateM)
            }
            self.tableViewOfGroup.reloadData()
            
            }) { (error) in
                print("获取cate分组信息失败：\(error)")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 10 {
            return bigGroupArray.count
        } else {
            if bigGroupArray.count == 0 {
                return 0
            }
            let cateM = bigGroupArray[bigSelectedIndex] as! MerCateGroupModel
            if cateM.list == nil {
                return 0
            } else {
                return cateM.list.count
            }
            
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 42
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView.tag == 10 {
            let cellIdentifier = "filterCell1"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? KindFilterCell
            if cell == nil {
                cell = KindFilterCell()
                cell?.initWithStyle(.Default, reuseIdentifier: cellIdentifier, withFrame: CGRectMake(0, 0, SCREEN_WIDTH/2, 42))
            }
            let cateM = bigGroupArray[indexPath.row] as? MerCateGroupModel
            cell?.setGroupM(cateM!)
            cell?.selectedBackgroundView = UIView(frame: cell!.frame)
            cell?.selectedBackgroundView?.backgroundColor = RGB(239, g: 239, b: 239)
            return cell!
        } else {
            let cellIdentifier = "filterCell2"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
            if cell == nil {
                cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
//                下划线
                let lineView = UIView(frame: CGRectMake(0, 41.5, cell!.frame.size.width, 0.5))
                lineView.backgroundColor = RGB(192, g: 192, b: 192)
                cell?.contentView.addSubview(lineView)
            }
            let cateM = bigGroupArray[bigSelectedIndex] as? MerCateGroupModel
            cell?.textLabel?.text = cateM?.list[indexPath.row].objectForKey("name") as? String
            cell?.detailTextLabel?.text = cateM?.list[indexPath.row].objectForKey("count") as? String
            cell?.textLabel?.font = UIFont.systemFontOfSize(15)
            cell?.detailTextLabel?.font = UIFont.systemFontOfSize(13)
            cell?.backgroundColor = RGB(242, g: 242, b: 242)
            cell?.selectionStyle = .None
            return cell!
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView.tag == 10 {
            bigSelectedIndex = indexPath.row
            let cateM = bigGroupArray[bigSelectedIndex] as? MerCateGroupModel
            if cateM?.list == nil {
                self.tableViewOfDetail.reloadData()
                self.delegate.tableView(tableView, didSelectRowAtIndexPath: indexPath, withID: (cateM?.id)!, withName: (cateM?.name)!)
            } else {
                self.tableViewOfDetail.reloadData()
            }
        } else {
            smallSelectedIndex = indexPath.row
            let cateM = bigGroupArray[bigSelectedIndex] as? MerCateGroupModel
            let dic: NSDictionary = (cateM?.list[smallSelectedIndex])! as! NSDictionary
            let id = dic.objectForKey("id") as? NSNumber
            let name = dic.objectForKey("name") as? String
            self.delegate.tableView(tableView, didSelectRowAtIndexPath: indexPath, withID: id!, withName: name!)
        }
    }

}
