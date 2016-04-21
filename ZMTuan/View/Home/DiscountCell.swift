//
//  DiscountCell.swift
//  ZMTuan
//
//  Created by zm on 4/18/16.
//  Copyright © 2016 zm. All rights reserved.
//  折扣View

import UIKit

protocol DiscountDelegate {
    func didSelectUrl(urlStr: String, withType type: NSNumber, withId ID: NSNumber, withTitle title: String)
    
}


class DiscountCell: UITableViewCell {
    
    var array: NSMutableArray?
//    var discountArray: NSMutableArray?
    var delegate: DiscountDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        array = NSMutableArray()
        for i in 0 ..< 4 {
            
            //            背景
            let backView: UIView = UIView(frame: CGRectMake(CGFloat(i)*SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 80))
            if i<2 {
                backView.frame = CGRectMake(CGFloat(i)*SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 80)
            } else {
                backView.frame = CGRectMake(CGFloat(i-2)*SCREEN_WIDTH/2, 80, SCREEN_WIDTH/2, 80)
            }
            backView.tag = 100 + i
            backView.layer.borderWidth = 0.25
            backView.layer.borderColor = separaterColor.CGColor
            self.addSubview(backView)
            
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DiscountCell.onTapBackView(_:)))
            backView.addGestureRecognizer(tap)
            
            //            标题
            let titleLabel: UILabel = UILabel(frame: CGRectMake(10, 20, SCREEN_WIDTH/2-10-60, 30))
            titleLabel.tag = 200 + i
            titleLabel.font = UIFont.systemFontOfSize(17)
            backView.addSubview(titleLabel)
            
            //            子标题
            let subtitleLabel: UILabel = UILabel(frame: CGRectMake(10, 40, SCREEN_WIDTH/2-10-60, 30))
            subtitleLabel.tag = 220 + i
            subtitleLabel.font = UIFont.systemFontOfSize(12)
            backView.addSubview(subtitleLabel)
            
            //            图片
            let imageView: UIImageView = UIImageView(frame: CGRectMake(SCREEN_WIDTH/2-10-60, 10, 60, 60))
            imageView.tag = 240 + i
            let image: UIImage = UIImage(named: "bg_customReview_image_default")!
            imageView.image = image
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 30
            backView.addSubview(imageView)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setDiscountArray(discountArray: NSMutableArray) {
        let array = NSMutableArray()
        for i in 0 ..< discountArray.count {
            let discount: DiscountModel = discountArray[i] as! DiscountModel
            let num: NSNumber = NSNumber(long: 1)
            if discount.type.isEqualToValue(num) {
                array.addObject(discount)
            }
        }
        self.array = discountArray
        
        for j in 0 ..< 4 {
            let titleLabel = self.viewWithTag(200 + j) as! UILabel
            let subtitleLabel = self.viewWithTag(220 + j) as! UILabel
            let imageView = self.viewWithTag(240 + j) as! UIImageView
            let discount = self.array![j] as! DiscountModel
            titleLabel.text = discount.mainTitle
            titleLabel.textColor = self.stringToColor(discount.typeFaceColor)
            subtitleLabel.text = discount.deputyTitle
            let imageUrl = discount.imageUrl.stringByReplacingOccurrencesOfString("w.h", withString: "120.0")
            imageView.sd_setImageWithURL(NSURL(string: imageUrl), placeholderImage: UIImage(named: "bg_customReview_image_default"))
            
        }
    }
    
    func stringToColor(str: String) -> UIColor {
        let red: AnyObject = ""
        let green: AnyObject = ""
        let blue: AnyObject = ""
        
        var range = Range<String.Index>(str.startIndex.advancedBy(1) ..< str.endIndex.advancedBy(-1))
        NSScanner(string: str.substringWithRange(range)).scanHexInt(red as! UnsafeMutablePointer<UInt32>)
        
        range = Range<String.Index>(str.startIndex.advancedBy(3) ..< str.endIndex.advancedBy(-1))
        NSScanner(string: str.substringWithRange(range)).scanHexInt(green as! UnsafeMutablePointer<UInt32>)
        
        range = Range<String.Index>(str.startIndex.advancedBy(5) ..< str.endIndex.advancedBy(-1))
        NSScanner(string: str.substringWithRange(range)).scanHexInt(blue as! UnsafeMutablePointer<UInt32>)

        let color = UIColor(red: (red as! CGFloat)/255.0, green: (green as! CGFloat)/255.0, blue: (blue as! CGFloat)/255.0, alpha: 1)
        return color
    }
    
    func onTapBackView(sender: UITapGestureRecognizer) {
        let index = (sender.view?.tag)! - 100
        let discount = self.array![index] as? DiscountModel
        var str = ""
        let num = NSNumber(long: 1)
        

        if ((discount?.type.isEqualToValue(num)) != nil) {
            str = (discount?.tplUrl)!
            let range = str.rangeOfString("http")
            str = str.substringFromIndex(range!.startIndex)
            print(str)
        }
        
        self.delegate?.didSelectUrl(str, withType: (discount?.type)!, withId: (discount?.id)!, withTitle: (discount?.mainTitle)!)
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
