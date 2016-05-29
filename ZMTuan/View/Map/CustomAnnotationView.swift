//
//  CustomAnnotationView.swift
//  ZMTuan
//
//  Created by zm on 5/22/16.
//  Copyright © 2016 zm. All rights reserved.
//

import UIKit

let kCalloutWidth: CGFloat = 200.0
let kCalloutHeight: CGFloat = 70.0

class CustomAnnotationView: MAAnnotationView {
    var calloutView: CustomCalloutView?
    var mAnnotation: MAroundAnnotation?
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        if self.selected == selected {
            return
        }
        
        if selected {
            if self.calloutView == nil {
                self.calloutView = CustomCalloutView(frame: CGRectMake(0, 0, kCalloutWidth, kCalloutHeight))
                self.calloutView!.center = CGPointMake(CGRectGetWidth(self.bounds) / 2 + self.calloutOffset.x, -CGRectGetHeight(self.calloutView!.bounds) / 2 + self.calloutOffset.y)
            }
            mAnnotation = MAroundAnnotation()
            let imgUrl = mAnnotation!.maAroundM?.imgurl.stringByReplacingOccurrencesOfString("w.h", withString: "104.63")
            self.calloutView!.imageView.sd_setImageWithURL(NSURL(string: imgUrl!), placeholderImage: UIImage(named: "bg_customReview_image_default"))
            self.calloutView!.title = self.mAnnotation!.title
            self.calloutView!.subtitle = self.mAnnotation!.subtitle
            
            self.addSubview(calloutView!)
        } else {
            self.calloutView!.removeFromSuperview()
        }
        super.setSelected(selected, animated: animated)
    }
    
//    重写此函数，用以实现点击calloutView判断为点击该annotationView
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        var inside: Bool = super.pointInside(point, withEvent: event)
        if !inside && self.selected {
            inside = self.calloutView!.pointInside(self.convertPoint(point, toView: self.calloutView), withEvent: event)
        }
        return inside
    }
}
