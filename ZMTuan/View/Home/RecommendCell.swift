//
//  RecommendCell.swift
//  ZMTuan
//
//  Created by zm on 4/23/16.
//  Copyright © 2016 zm. All rights reserved.
//

import UIKit

class RecommendCell: UITableViewCell {
    
    var shopImage: UIImageView!
    var shopNameLabel: UILabel!
    var shopInfoLabel: UILabel!
    var priceLabel: UILabel!
    var type: String!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
//        图
        self.shopImage = UIImageView(frame: CGRectMake(10, 10, 80, 80))
        self.shopImage.layer.masksToBounds = true
        self.shopImage.layer.cornerRadius = 4.0
        self.contentView.addSubview(self.shopImage)
        
//        免预约的图片
        let appointmentImg = UIImageView(frame: CGRectMake(10, 10, 40, 40))
        appointmentImg.image = UIImage(named: "ic_deal_noBooking")
        self.contentView.addSubview(appointmentImg)
        
//        店名
        self.shopNameLabel = UILabel(frame: CGRectMake(100, 5, SCREEN_WIDTH-100-80, 30))
        self.contentView.addSubview(self.shopNameLabel)
        
//        介绍
        self.shopInfoLabel = UILabel(frame: CGRectMake(100, 30, SCREEN_WIDTH-100-10, 45))
        self.shopInfoLabel.textColor = UIColor.lightGrayColor()
        self.shopInfoLabel.font = UIFont.systemFontOfSize(13)
        self.shopInfoLabel.numberOfLines = 2
        self.shopInfoLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        self.contentView.addSubview(self.shopInfoLabel)
        
//        价格
        self.priceLabel = UILabel(frame: CGRectMake(100, 80, 50, 20))
        self.priceLabel.textColor = navigationBarColor
        self.contentView.addSubview(self.priceLabel)
    }
    
    func setRecommendData(recommendData: RecommendModel) {
        self.type = "recommend"
        let imageUrl = recommendData.imgurl.stringByReplacingOccurrencesOfString("w.h", withString: "160.0")
        self.shopImage.sd_setImageWithURL(NSURL(string: imageUrl), placeholderImage: UIImage(named: "bg_customReview_image_default"))
        
        self.shopNameLabel.text = recommendData.mname
        self.shopInfoLabel.text = "[\(recommendData.range)]\(recommendData.title)"
        self.priceLabel.text = "\(recommendData.price.intValue)元"

    }
    
    func setDealData(dealData: DisDealModel) {
        self.type = "discount"
        let imageUrl = dealData.imgurl.stringByReplacingOccurrencesOfString("w.h", withString: "160.0")
        self.shopImage.sd_setImageWithURL(NSURL(string: imageUrl), placeholderImage: UIImage(named: "bg_customReview_image_default"))
        self.shopNameLabel.text = dealData.mname
        self.shopInfoLabel.text = "[\(dealData.range)\(dealData.title)]"
        self.priceLabel.text = "\(dealData.price.intValue)元"
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
