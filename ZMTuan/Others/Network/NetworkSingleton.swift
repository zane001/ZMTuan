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

}