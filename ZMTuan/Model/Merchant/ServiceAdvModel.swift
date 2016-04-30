//
//  ServiceAdvModel.swift
//  ZMTuan
//
//  Created by zm on 4/30/16.
//  Copyright © 2016 zm. All rights reserved.
//

import Foundation

class ServiceAdvModel: NSObject {

    var id: NSNumber!
    var name: String!
    var commmonTitle: String!
    var imgUrl: String!
    var imgUrlSize: String!

    var bigImgTypeUrl: String!
    var bigImgUrlSize: String!
    var app: String!
    var type: NSNumber!
    var typeDesc: String!

    var standIdList: NSMutableArray!
    var startTime: NSNumber!
    var endTime: NSNumber!
    var level: NSNumber!

    var closable: NSNumber!
    var channelType: NSNumber!
    var channelListMap: NSMutableDictionary!
    var title: String!
    var url: String!

}