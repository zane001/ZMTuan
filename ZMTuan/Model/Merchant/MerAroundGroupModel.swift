//
//  MerAroundGroupModel.swift
//  ZMTuan
//
//  Created by zm on 4/30/16.
//  Copyright © 2016 zm. All rights reserved.
//

import Foundation

class MerAroundGroupModel: NSObject {
    
    var squareimgurl: String!
    var mname: String!
    var range: String!
    var title: String!
    var price: String!
    var value: NSNumber!
    var rating: NSNumber!
    var rate_count: NSNumber!
    var id: NSNumber!
    
    func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["rate_count" : "rate-count"]
    }
}