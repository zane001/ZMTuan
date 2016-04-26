//
//  ShopPriceCell.swift
//  ZMTuan
//
//  Created by zm on 4/11/16.
//  Copyright © 2016 zm. All rights reserved.
//

import UIKit

class ShopPriceCell: UITableViewCell {

    var priceLabel: UILabel!
    var oldPriceLabel: UILabel!
    var buyBtn: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        折扣价
        self.priceLabel = UILabel(frame: CGRectMake(10, 0, 130, 65))
        self.priceLabel.font = UIFont.systemFontOfSize(35)
        self.priceLabel.textColor = navigationBarColor
        self.contentView.addSubview(self.priceLabel)
        
//        原价
        self.oldPriceLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(self.priceLabel.frame)+10, 30, 100, 30))
        self.oldPriceLabel.textColor = UIColor.lightGrayColor()
        self.contentView.addSubview(self.oldPriceLabel)
        
//        立即抢购
        self.buyBtn = UIButton(type: .Custom)
        buyBtn.frame = CGRectMake(SCREEN_WIDTH-10-100, 10, 100, 40)
        buyBtn.backgroundColor = RGB(252, g: 158, b: 40)
        buyBtn.setTitle("立即抢购", forState: .Normal)
        buyBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        buyBtn.layer.cornerRadius = 4
        self.contentView.addSubview(buyBtn)
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
