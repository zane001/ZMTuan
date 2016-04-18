//
//  RushCell.swift
//  ZMTuan
//
//  Created by zm on 4/17/16.
//  Copyright © 2016 zm. All rights reserved.
//

import UIKit

protocol RushDelegate {
    func didSelectRushIndex(index: NSInteger)
}

class RushCell: UITableViewCell {
    
    var delegate: RushDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        名店抢购图
        let mingDian = UIImageView(frame: CGRectMake(20, 7, 78, 25))
        mingDian.image = UIImage(named: "todaySpecialHeaderTitleImage")
        self.addSubview(mingDian)
        
//        背景点击事件
        let tap = UITapGestureRecognizer(target: self, action: #selector(RushCell.onTapBackView(_:)))
        
        for i in 0 ..< 3 {
            
//            背景View
            let backView = UIView(frame: CGRectMake(CGFloat(i)*SCREEN_WIDTH/3, 40, (SCREEN_WIDTH-3)/3, 80))
            backView.tag = 100 + i
            backView.addGestureRecognizer(tap)
            self.addSubview(backView)
            
//            3个抢购图片
            let imageView = UIImageView(frame: CGRectMake(0, 0, (SCREEN_WIDTH-3)/3, 50))
            imageView.tag = 20 + i
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            backView.addSubview(imageView)
            
//            3个抢购图片的间隔线
            let lineView = UIImageView(frame: CGRectMake(CGFloat(i)*SCREEN_WIDTH/3-1, 45, 0.5, 65))
            lineView.backgroundColor = separaterColor
            self.addSubview(lineView)
            
            let newPrice = UILabel(frame: CGRectMake(0, 50, backView.frame.size.width/2, 30))
            newPrice.tag = 50 + i
            newPrice.textColor = RGB(245, g: 185, b: 98)
            newPrice.textAlignment = NSTextAlignment.Right
            backView.addSubview(newPrice)
            
            let oldPrice = UILabel(frame: CGRectMake(backView.frame.size.width/2+5, 50, backView.frame.size.width/2-5, 30))
            oldPrice.tag = 70 + i
            oldPrice.textColor = navigationBarColor
            oldPrice.font = UIFont.systemFontOfSize(13)
            backView.addSubview(oldPrice)
        }
    }

    func onTapBackView(sender: UITapGestureRecognizer) {
        self.delegate?.didSelectRushIndex((sender.view?.tag)!)
    }
    
//  显示抢购图片、新价格、原价格
    func setRushData(rushData: NSMutableArray) {
        for i in 0 ..< 3 {
            let rush = rushData[i] as! RushDealsModel
            var imageUrl = rush.mdcLogoUrl
            var newPrice: Int32 = 0
            if rush.campaignPrice != nil {
                newPrice = rush.campaignPrice.intValue
            }
            let oldPrice = rush.price.intValue
            
            let imageView: UIImageView = (self.viewWithTag(20 + i) as? UIImageView)!
//            美团api接口图片地址中带有w.h，替换为200.120，图片显示正常
            imageUrl = imageUrl.stringByReplacingOccurrencesOfString("w.h", withString: "200.120")
            imageView.sd_setImageWithURL(NSURL(string: imageUrl), placeholderImage: UIImage(named: "todaySpecialHeaderTitleImage"))
            
            let newPriceLabel = self.viewWithTag(50 + i) as? UILabel
            newPriceLabel!.text = "\(newPrice)元"
            
            let oldPriceLabel = self.viewWithTag(70 + i) as? UILabel
            let oldPriceStr: String = "\(oldPrice)元"
            
//            显示中划线
            let attributeStr: NSMutableAttributedString = NSMutableAttributedString(string: oldPriceStr, attributes: [NSStrikethroughStyleAttributeName: 1])
            oldPriceLabel?.attributedText = attributeStr
        }
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
