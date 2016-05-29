//
//  CustomCalloutView.swift
//  ZMTuan
//
//  Created by zm on 5/22/16.
//  Copyright © 2016 zm. All rights reserved.
//

import UIKit

let kArrorHeight: CGFloat = 10
let kPortraitMargin: CGFloat = 5

let kImageWidth: CGFloat = 70
let kImageHeight: CGFloat = 50

let kTitleWidth: CGFloat = 120
let kTitleHeight: CGFloat = 20

class CustomCalloutView: UIView {
    
    var image: UIImage!
    var title: String!
    var subtitle: String!
    var imageView: UIImageView!
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.initSubViews()
    }
    
    func initSubViews() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapCalloutView))
        self.addGestureRecognizer(tap)
        
//        图
        self.imageView = UIImageView(frame: CGRectMake(kPortraitMargin, kPortraitMargin, kImageWidth, kImageHeight))
        imageView.backgroundColor = UIColor.blackColor()
        self.addSubview(imageView)
        
//        标题
        self.titleLabel = UILabel(frame: CGRectMake(kPortraitMargin*2+kImageWidth, kPortraitMargin, kTitleWidth, kTitleHeight))
        titleLabel.font = UIFont.systemFontOfSize(14)
        titleLabel.textColor = UIColor.whiteColor()
        self.addSubview(titleLabel)
        
//        子标题
        self.subtitleLabel = UILabel(frame: CGRectMake(kPortraitMargin*2+kImageWidth, kPortraitMargin*2+kTitleHeight, kTitleWidth, kTitleHeight))
        subtitleLabel.font = UIFont.systemFontOfSize(12)
        subtitleLabel.textColor = UIColor.lightGrayColor()
        self.addSubview(subtitleLabel)
    }
    
    override func drawRect(rect: CGRect) {
        self.drawInContext(UIGraphicsGetCurrentContext()!)
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSizeMake(0.0, 0.0)
    }
    
    func drawInContext(context: CGContextRef) {
        CGContextSetLineWidth(context, 2.0)
        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
        self.getDrawPath(context)
        CGContextFillPath(context)
    }
    
    func getDrawPath(context: CGContextRef) {
        let rect: CGRect = self.bounds
        let radius: CGFloat = 6.0
        let minX: CGFloat = CGRectGetMinX(rect)
        let midX: CGFloat = CGRectGetMidX(rect)
        let maxX: CGFloat = CGRectGetMaxX(rect)
        let minY: CGFloat = CGRectGetMinY(rect)
        let maxY: CGFloat = CGRectGetMaxY(rect) - kArrorHeight
        
//        画向下的三角形
        CGContextMoveToPoint(context, midX+kArrorHeight, maxY)
        CGContextAddLineToPoint(context, midX, maxY+kArrorHeight)
        CGContextAddLineToPoint(context, midX-kArrorHeight, maxY)
        
//        画4个圆弧，画完后 current point不在minx,miny，而是在圆弧结束的地方
        CGContextAddArcToPoint(context, minX, maxY, minX, minY, radius);
        CGContextAddArcToPoint(context, minX, minY, maxX, minY, radius);
        CGContextAddArcToPoint(context, maxX, minY, maxX, maxY, radius);
        CGContextAddArcToPoint(context, maxX, maxY, midX, maxY, radius);
        CGContextClosePath(context);
    }
    
    func onTapCalloutView() {
        print("title: \(title)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
