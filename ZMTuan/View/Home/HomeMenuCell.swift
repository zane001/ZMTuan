//
//  HomeMenuCell.swift
//  ZMTuan
//
//  Created by zm on 4/13/16.
//  Copyright © 2016 zm. All rights reserved.
//  首页上方的滑动展示

import UIKit

class HomeMenuCell: UITableViewCell, UIScrollViewDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var view1: UIView?
    var view2: UIView?
    var scrollView: UIScrollView?
    var pageControll: UIPageControl?
    
    func initWithStyle(style: UITableViewCellStyle, reuseIdentifier: String?, menuArray: NSMutableArray) {

        view1 = UIView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 160))
        view2 = UIView(frame: CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, 160))
        scrollView = UIScrollView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 180))
        scrollView?.contentSize = CGSizeMake(2*SCREEN_WIDTH, 180)
        scrollView?.pagingEnabled = true
        scrollView?.delegate = self
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.addSubview(view1!)
        scrollView?.addSubview(view2!)
        self.addSubview(scrollView!)
        
        for i in 0 ..< 16 {
            if i<4 {
                let frame: CGRect = CGRectMake(CGFloat(i)*SCREEN_WIDTH/4, 0, SCREEN_WIDTH/4, 80)
                let title: String = menuArray[i].objectForKey("title") as! String

                let imageStr: String = menuArray[i].objectForKey("image") as! String
                let btnView: BtnView = BtnView()
                btnView.initWithFrame(frame, title: title, imageStr: imageStr)
                btnView.tag = 10 + i

                view1?.addSubview(btnView)
                let tap: UIGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(HomeMenuCell.onTapBtnView(_:)))
                btnView.addGestureRecognizer(tap)
            } else if i<8 {
                let frame: CGRect = CGRectMake(CGFloat(i-4)*SCREEN_WIDTH/4, 80, SCREEN_WIDTH/4, 80)
                let title: String = menuArray[i].objectForKey("title") as! String

                let imageStr: String = menuArray[i].objectForKey("image") as! String
                let btnView: BtnView = BtnView()
                btnView.initWithFrame(frame, title: title, imageStr: imageStr)
                btnView.tag = 10 + i
                view1?.addSubview(btnView)
                let tap: UIGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(HomeMenuCell.onTapBtnView(_:)))
                btnView.addGestureRecognizer(tap)
            } else if i<12 {
                let frame: CGRect = CGRectMake(CGFloat(i-8)*SCREEN_WIDTH/4, 0, SCREEN_WIDTH/4, 80)
                let title: String = menuArray[i].objectForKey("title") as! String
                let imageStr: String = menuArray[i].objectForKey("image") as! String
                let btnView: BtnView = BtnView()
                btnView.initWithFrame(frame, title: title, imageStr: imageStr)
                btnView.tag = 10 + i
                view2?.addSubview(btnView)
                let tap: UIGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(HomeMenuCell.onTapBtnView(_:)))
                btnView.addGestureRecognizer(tap)
            } else {
                let frame: CGRect = CGRectMake(CGFloat(i-12)*SCREEN_WIDTH/4, 80, SCREEN_WIDTH/4, 80)
                let title: String = menuArray[i].objectForKey("title") as! String
                let imageStr: String = menuArray[i].objectForKey("image") as! String
                let btnView: BtnView = BtnView()
                btnView.initWithFrame(frame, title: title, imageStr: imageStr)
                btnView.tag = 10 + i
                view2?.addSubview(btnView)
                let tap: UIGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(HomeMenuCell.onTapBtnView(_:)))
                btnView.addGestureRecognizer(tap)
            }
        }
        
        pageControll = UIPageControl(frame: CGRectMake(SCREEN_WIDTH/2-20, 160, 0, 20))
        pageControll?.currentPage = 0
        pageControll?.numberOfPages = 2
        self.addSubview(pageControll!)
        pageControll?.currentPageIndicatorTintColor = navigationBarColor
        pageControll?.pageIndicatorTintColor = UIColor.grayColor()
    }
    
    func onTapBtnView(sender: UIGestureRecognizer) {
        print(sender.view?.tag)
    }
    
//    MARK: UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollViewWidth: CGFloat = scrollView.frame.size.width
        let x: CGFloat = scrollView.contentOffset.x
        let page: Int = (Int(x) + Int(scrollViewWidth/2)) / Int(scrollViewWidth)
        pageControll?.currentPage = page
    }

}
