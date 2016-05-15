//
//  MerchantCell.swift
//  ZMTuan
//
//  Created by zm on 4/30/16.
//  Copyright © 2016 zm. All rights reserved.
//

import UIKit

class MerchantCell: UITableViewCell {
    
    var merchantImage: UIImageView!
    var merchantNameLabel: UILabel!
    var cateNameLabel: UILabel!
    var evaluateLabel: UILabel!

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        图
        merchantImage = UIImageView(frame: CGRectMake(10, 10, 90, 72))
        merchantImage.layer.masksToBounds = true
        merchantImage.layer.cornerRadius = 4
        self.contentView.addSubview(merchantImage)
        
//        店名
        merchantNameLabel = UILabel(frame: CGRectMake(110, 5, SCREEN_WIDTH-110-10, 30))
        merchantNameLabel.font = UIFont.systemFontOfSize(15)
        merchantNameLabel.lineBreakMode = .ByTruncatingTail
        self.contentView.addSubview(merchantNameLabel)
        
//        星星
        for i in 0 ..< 5 {
            let starImg: UIImageView = UIImageView(frame: CGRectMake(110+CGFloat(i)*14, 43, 12, 12))
            starImg.tag = 30 + i
            starImg.image = UIImage(named: "icon_feedCell_star_empty")
            self.contentView.addSubview(starImg)
        }
        
//        评价个数
        evaluateLabel = UILabel(frame: CGRectMake(110+5*14, 40, 80, 20))
        evaluateLabel.font = UIFont.systemFontOfSize(13)
        evaluateLabel.textColor = UIColor.lightGrayColor()
        self.contentView.addSubview(evaluateLabel)
        
//        类别名
        cateNameLabel = UILabel(frame: CGRectMake(110, 60, SCREEN_WIDTH-110-10, 30))
        cateNameLabel.font = UIFont.systemFontOfSize(13)
        cateNameLabel.textColor = UIColor.lightGrayColor()
        self.contentView.addSubview(cateNameLabel)
        
//        下划线
        let lineView: UIView = UIView(frame: CGRectMake(0, 91.5, SCREEN_WIDTH, 0.5))
        lineView.backgroundColor = RGB(192, g: 192, b: 192)
        self.contentView.addSubview(lineView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    显示
    func setMerModel(merModel: MerchantModel) {

        let imgUrl: String = merModel.frontImg.stringByReplacingOccurrencesOfString("w.h", withString: "160.0")
        merchantImage.sd_setImageWithURL(NSURL(string: imgUrl), placeholderImage: UIImage(named: "bg_customReview_image_default"))
        
        merchantNameLabel.text = merModel.name
        cateNameLabel.text = "\(merModel.cateName) \(merModel.areaName)"
        evaluateLabel.text = "\(merModel.markNumbers)评价"
        
        let scoreD: Double = merModel.avgScore.doubleValue
        let scoreI = Int(ceil(scoreD))
        
        for i in 0 ..< 5 {
            let imgView = self.contentView.viewWithTag(30 + i) as! UIImageView
            imgView.image = UIImage(named: "icon_feedCell_star_empty")
        }
        
        for i in 0 ..< scoreI {
            let imgView = self.contentView.viewWithTag(30 + i) as! UIImageView
            imgView.image = UIImage(named: "icon_feedCell_star_full")
        }
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
