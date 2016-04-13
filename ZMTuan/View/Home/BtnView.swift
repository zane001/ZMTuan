//
//  BtnView.swift
//  ZMTuan
//
//  Created by zm on 4/13/16.
//  Copyright © 2016 zm. All rights reserved.
//
//  按钮的View

import UIKit

class BtnView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    func initWithFrame(frame: CGRect, title: String, imageStr: String) {
        
//        这句代码一定要写，否则会导致frame为0
        self.frame = frame
        
        let imageView: UIImageView = UIImageView(frame: CGRectMake(frame.size.width/2-22, 15, 44, 44))
        imageView.image = UIImage(named: imageStr)
        self.addSubview(imageView)
        
        let titleLabel: UILabel = UILabel(frame: CGRectMake(0, 15+44, frame.size.width, 20))
        titleLabel.text = title
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.font = UIFont.systemFontOfSize(13)
        self.addSubview(titleLabel)
        
    }
    
}
