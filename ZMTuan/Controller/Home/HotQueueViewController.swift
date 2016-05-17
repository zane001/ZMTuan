//
//  HotQueueViewController.swift
//  ZMTuan
//
//  Created by zm on 4/18/16.
//  Copyright © 2016 zm. All rights reserved.
//  美团的热门排队接口返回 {"data":{}}

import UIKit

class HotQueueViewController: UIViewController, UIWebViewDelegate {

    var isFirstIn: Int!
    var webView: UIWebView!
    var urlStr: String!
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
        self.view.backgroundColor = UIColor.whiteColor()
        isFirstIn = 0
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
        
//        返回
        let backBtn = UIButton(type: .Custom)
        backBtn.frame = CGRectMake(10, 30, 23, 23)
        backBtn.setImage(UIImage(named: "btn_backItem"), forState: .Normal)
        backBtn.addTarget(self, action: #selector(HotQueueViewController.onBackBtn(_:)), forControlEvents: .TouchUpInside)
        backView.addSubview(backBtn)
        
//        标题
        self.titleLabel = UILabel(frame: CGRectMake(SCREEN_WIDTH/2-80, 30, 160, 30))
        self.titleLabel.textAlignment = .Center
        self.titleLabel.textColor = UIColor.redColor()
        backView.addSubview(titleLabel)
    }
    
    func initViews() {
        self.webView = UIWebView(frame: CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64))
        self.webView.delegate = self
        self.webView.scalesPageToFit = true
        self.view.addSubview(webView)
        
        let urlStr = self.urlStr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let request = NSURLRequest(URL: NSURL(string: urlStr!)!)
        self.webView.loadRequest(request)
    }
    
    func onBackBtn(sender: UIButton) {
        if isFirstIn <= 1 {
            self.navigationController?.popViewControllerAnimated(true)
        } else {
            isFirstIn = isFirstIn - 2
            self.webView.goBack()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    MARK: UIWebViewDelegate
    func webViewDidStartLoad(webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        let title = webView.stringByEvaluatingJavaScriptFromString("document.title")
        self.titleLabel.text = title
        self.title = title

    }

    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        isFirstIn = isFirstIn + 1
        return true
    }

}
