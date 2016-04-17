//
//  RushViewController.swift
//  ZMTuan
//
//  Created by zm on 4/17/16.
//  Copyright © 2016 zm. All rights reserved.
//  名店抢购的ViewController

import UIKit

class RushViewController: UIViewController, UIWebViewDelegate {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNav()
        self.initViews()
    }
    
    func setNav() {
        let backView = UIView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 64))
        backView.backgroundColor = RGB(250, g: 250, b: 250)
        self.view.addSubview(backView)
        
//        下划线
        let lineView = UIView(frame: CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5))
        lineView.backgroundColor = RGB(192, g: 192, b: 192)
        backView.addSubview(lineView)
        
//        返回按钮
        let backBtn = UIButton(type: .Custom)
        backBtn.frame = CGRectMake(10, 30, 23, 23)
        backBtn.setImage(UIImage(named: "btn_backItem"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: #selector(RushViewController.onBackBtn(_:)), forControlEvents: .TouchUpInside)
        backView.addSubview(backBtn)
        
        let title = UILabel(frame: CGRectMake(SCREEN_WIDTH/2-80, 30, 160, 30))
        title.textAlignment = NSTextAlignment.Center
        backView.addSubview(title)
    }
    
    func initViews() {
        
    }
    
    func onBackBtn(sender: UIGestureRecognizer) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
