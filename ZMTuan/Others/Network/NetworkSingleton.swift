//
//  NetworkSingleton.swift
//  ZMTuan
//
//  Created by zm on 4/16/16.
//  Copyright © 2016 zm. All rights reserved.
//

import Foundation

class NetworkSingleton {
    
    let TIMEOUT = 30
    typealias SuccessBlock = (responseBody: AnyObject) -> ()
    typealias FailureBlock = (error: String) -> ()

    final class sharedManager {
    
//    单例模式
        static let sharedSingleton = NetworkSingleton()
//        防止被外界初始化
        private init() {}

    }
    
    
    func baseHttpRequest() -> AFHTTPSessionManager {
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = NSTimeInterval(TIMEOUT)
        manager.responseSerializer.acceptableContentTypes = Set(["text/plain", "text/html", "application/json"])
        
        return manager
    }
    
//    MARK: 获取广告图片
    func getAdvLoadingImage(userInfo: NSDictionary, url: String, successBlock: SuccessBlock, failureBlock: FailureBlock) {
        let manager = self.baseHttpRequest()
//        此处地址是将接口地址中的 %2A 替换为 *
        let urlString = url.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        manager.GET(urlString!, parameters: userInfo, success: { (operation, object) in
            successBlock(responseBody: object!)
        }) { (operation, error) in
            let errorString = error.userInfo["NSLocalizedDescription"] as? String
            failureBlock(error: errorString!)
        }
    }
    
//    MARK: 团购模块接口
//    MAKR: 名店抢购
    func getRushBuyResult(userInfo: NSDictionary, url: String, successBlock: SuccessBlock, failureBlock: FailureBlock) {
        let manager = self.baseHttpRequest()
        let urlString = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        manager.GET(urlString!, parameters: userInfo, success: { (operation, object) in
            successBlock(responseBody: object!)
            }) { (operation, error) in
                let errorString = error.userInfo["NSLocalizedDescription"] as? String
                failureBlock(error: errorString!)
        }
    }
    
//    MARK: 折扣
    func getDiscountResult(userInfo: NSDictionary, url: String, successBlock: SuccessBlock, failureBlock: FailureBlock) {
        let manager = self.baseHttpRequest()
        let urlString = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        manager.GET(urlString!, parameters: userInfo, success: { (operation, object) in
            successBlock(responseBody: object!)
        }) { (operation, error) in
            let errorString = error.userInfo["NSLocalizedDescription"] as? String
            failureBlock(error: errorString!)
        }
    }
    
//    MARK: 猜你喜欢（推荐）
    func getRecommendResult(userInfo: NSDictionary, url: String, successBlock: SuccessBlock, failureBlock: FailureBlock) {
        let manager = self.baseHttpRequest()
        let urlString = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        manager.GET(urlString!, parameters: userInfo, success: { (operation, object) in
            successBlock(responseBody: object!)
            }) { (operation, error) in
                let errorString = error.userInfo["NSLocalizedDescription"] as? String
                failureBlock(error: errorString!)
        }
    }

//    MARK: 店铺详情
    func getShopResult(userInfo: NSDictionary, url: String, successBlock: SuccessBlock, failureBlock: FailureBlock) {
        let manager = self.baseHttpRequest()
        let urlStr = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        manager.GET(urlStr!, parameters: userInfo, success: { (operation, object) in
            successBlock(responseBody: object!)
            }) { (operation, error) in
                let errorString = error.userInfo["NSLocalizedDescription"] as? String
                failureBlock(error: errorString!)
        }
    }
    
//    MARK: 店铺看了还看了
    func getShopRecommendResult(userInfo: NSDictionary, url: String, successBlock: SuccessBlock, failureBlock: FailureBlock) {
        let manager = self.baseHttpRequest()
        manager.requestSerializer.setValue("text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("gzip, deflate, sdch", forHTTPHeaderField: "Accept-Encoding")
        manager.requestSerializer.setValue("zh-CN,zh;q=0.8,en;q=0.6", forHTTPHeaderField: "Accept-Language")
        manager.requestSerializer.setValue("max-age=0", forHTTPHeaderField: "Cache-Control")
        manager.requestSerializer.setValue("api.meituan.com", forHTTPHeaderField: "Host")
        manager.requestSerializer.setValue("keep-alive", forHTTPHeaderField: "Proxy-Connection")
        manager.requestSerializer.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.124 Safari/537.36", forHTTPHeaderField: "User-Agent")
        let urlStr = url.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        manager.GET(urlStr!, parameters: userInfo, success: { (operation, object) in
            successBlock(responseBody: object!)
            }) { (operation, error) in
                let errorString = error.userInfo["NSLocalizedDescription"] as? String
                failureBlock(error: errorString!)
        }
    }
}

