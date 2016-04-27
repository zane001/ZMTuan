//
//  ShopRecommendCell.swift
//  ZMTuan
//
//  Created by zm on 4/11/16.
//  Copyright © 2016 zm. All rights reserved.
//

import UIKit

class ShopRecommendCell: UITableViewCell {

    var shopImageView: UIImageView!
    var shopNameLabel: UILabel!
    var shopInfoLabel: UILabel!
    var shopPriceLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        图
        self.shopImageView = UIImageView(frame: CGRectMake(10, 10, 80, 80))
        self.shopImageView.layer.masksToBounds = true
        self.shopImageView.layer.cornerRadius = 4
        self.addSubview(self.shopImageView)
        
//        标题
        self.shopNameLabel = UILabel(frame: CGRectMake(100, 10, SCREEN_WIDTH-100, 30))
        self.shopNameLabel.font = UIFont.systemFontOfSize(15)
        self.addSubview(self.shopNameLabel)
        
//        详情
        self.shopInfoLabel = UILabel(frame: CGRectMake(100, 30, SCREEN_WIDTH-100-10, 50))
        self.shopInfoLabel.numberOfLines = 2
        self.shopInfoLabel.font = UIFont.systemFontOfSize(13)
        self.shopInfoLabel.textColor = UIColor.lightGrayColor()
        self.shopInfoLabel.lineBreakMode = .ByTruncatingTail
        self.addSubview(self.shopInfoLabel)
        
//        价格
        self.shopPriceLabel = UILabel(frame: CGRectMake(100, 70, 100, 20))
        self.shopPriceLabel.font = UIFont.systemFontOfSize(13)
        self.shopPriceLabel.textColor = navigationBarColor
        self.addSubview(self.shopPriceLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setShopRecommendModel(shopRecM: ShopRecommendModel) {
        let imgUrl = shopRecM.imgurl.stringByReplacingOccurrencesOfString("w.h", withString: "160.0")
        self.shopImageView.sd_setImageWithURL(NSURL(string: imgUrl), placeholderImage: UIImage(named: "bg_customReview_image_default"))
        self.shopNameLabel.text = shopRecM.brandname
        self.shopInfoLabel.text = "[\(shopRecM.range)]\(shopRecM.title)"
        self.shopPriceLabel.text = "\(shopRecM.price.doubleValue)元"
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
