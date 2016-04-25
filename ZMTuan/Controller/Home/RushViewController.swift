//
//  RushViewController.swift
//  ZMTuan
//
//  Created by zm on 4/17/16.
//  Copyright © 2016 zm. All rights reserved.
//  名店抢购的ViewController

import UIKit

class RushViewController: UIViewController, UIWebViewDelegate {

    var webView: UIWebView!
    var activityView: UIActivityIndicatorView!
    var titleLabel: UILabel!
    
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
        
        self.titleLabel = UILabel(frame: CGRectMake(SCREEN_WIDTH/2-80, 30, 160, 30))
        self.titleLabel.textAlignment = NSTextAlignment.Center
        backView.addSubview(self.titleLabel)
    }
    
    func initViews() {
        self.webView = UIWebView(frame: CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64))
        self.webView.delegate = self
        self.webView.scalesPageToFit = true
        self.view.addSubview(self.webView)
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let url = "http://i.meituan.com/topic/mingdian?ci=1&f=iphone&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-02-16-25124&token=p19ukJltGhla4y5Jryb1jgCdKjsAAAAAsgAAADHFD3UYGxaY2FlFPQXQj2wCyCrhhn7VVB-KpG_U3-clHlvsLM8JRrnZK35y8UU3DQ&userid=10086&utm_campaign=AgroupBgroupD100Fab_chunceshishuju__a__a___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_gxtest__gd__leftflow___ab_waimaiwending__a__a___ab_gxh_82__nostrategy__leftflow___i_group_5_2_deallist_poitype__d__d___ab_b_food_57_purepoilist_extinfo__a__a___ab_pindaoshenyang__a__leftflow___ab_pindaoquxincelue0630__b__b1___a20141120nanning__m1__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___ab_waimaizhanshi__b__b1___ab_i_group_5_5_onsite__b__b___ab_i_group_5_6_searchkuang__a__leftflowGhomepage_bargainmiddle_30311731&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7&lat=\(delegate.latitude)&lng=\(delegate.longitude)"
        let request = NSURLRequest(URL: NSURL(string: url)!)
        
//        加载web页面，进入名店抢购页面后，继续点击，如果手机装有美团官方app，则跳转到美团官方app，否则不跳转
        self.webView.loadRequest(request)
       
        
    }
    
    func onBackBtn(sender: UIGestureRecognizer) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    MARK: UIWebViewDelegate
    func webViewDidStartLoad(webView: UIWebView) {
        print("开始加载WebView")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        let title = webView.stringByEvaluatingJavaScriptFromString("document.title")
        self.titleLabel.text = title
        SVProgressHUD.dismiss()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("加载WebView失败")
    }

    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        SVProgressHUD.showSuccessWithStatus("加载成功")
        return true
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
