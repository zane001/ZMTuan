//
//  HomeServiceCell.swift
//  ZMTuan
//
//  Created by zm on 4/30/16.
//  Copyright © 2016 zm. All rights reserved.
//  上门服务，暂未使用

import UIKit

protocol HomeServiceDelegate {
    func didSelectAtIndex(index: NSInteger)
}

class HomeServiceCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initViews()
    }
    
    func initViews() {
        for i in 0 ..< 10 {
            let x = CGFloat(i % 2)
            let y = CGFloat(i / 2)
            
//            背景
            let backView = UIView(frame: CGRectMake(x*(SCREEN_WIDTH-15)/2+5*(x+1), y*125+5, (SCREEN_WIDTH-15)/2, 120))
            backView.backgroundColor = UIColor.redColor()
            backView.tag = 10 + i
            backView.hidden = true
            self.addSubview(backView)
            let tap = UITapGestureRecognizer(target: self, action: #selector(HomeServiceCell.onTapBackView(_:)))
            backView.addGestureRecognizer(tap)
            
//            图
            let imageView = UIImageView(frame: CGRectMake(0, 0, backView.frame.size.width, backView.frame.size.height-40))
            imageView.tag = 50 + i
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            backView.addSubview(imageView)
            
//            标题
            let titleLabel = UILabel(frame: CGRectMake(0, CGRectGetMaxX(imageView.frame), backView.frame.size.width, 30))
            titleLabel.textColor = UIColor.whiteColor()
            titleLabel.font = UIFont.systemFontOfSize(15)
            titleLabel.textAlignment = .Center
            titleLabel.tag = 100 + i
            backView.addSubview(titleLabel)
        }
    }
    
    func setHomeServiceArray(homeServiceArray: NSMutableArray) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onTapBackView(sender: UITapGestureRecognizer) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
