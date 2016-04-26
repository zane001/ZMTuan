//
//  ShopImageCell.swift
//  ZMTuan
//
//  Created by zm on 4/11/16.
//  Copyright © 2016 zm. All rights reserved.
//

import UIKit

class ShopImageCell: UITableViewCell {

    var shopImageView: UIImageView!
    var shopNameLabel: UILabel!
    var shopTitleLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        图
        self.shopImageView = UIImageView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 190))
        self.shopImageView.image = UIImage(named: "bg_customReview_image_default")
        self.contentView.addSubview(self.shopImageView)
        
//        店名
        self.shopNameLabel = UILabel(frame: CGRectMake(10, self.shopImageView.frame.size.height-30-30, SCREEN_WIDTH-10, 30))
        self.shopNameLabel.textColor = UIColor.whiteColor()
        self.contentView.addSubview(self.shopNameLabel)
        
//        标题
        self.shopTitleLabel = UILabel(frame: CGRectMake(10, self.shopImageView.frame.size.height-30, SCREEN_WIDTH-10, 30))
        self.shopTitleLabel.textColor = UIColor.whiteColor()
        self.shopTitleLabel.font = UIFont.systemFontOfSize(13)
        self.contentView.addSubview(self.shopTitleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
