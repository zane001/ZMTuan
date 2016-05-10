//
//  KindFilterCell.swift
//  ZMTuan
//
//  Created by zm on 4/30/16.
//  Copyright © 2016 zm. All rights reserved.
//

import UIKit

class KindFilterCell: UITableViewCell {

    var imgView: UIImageView!
    var nameLabel: UILabel!
    var numberBtn: UIButton!
    
    func initWithStyle(style: UITableViewCellStyle, reuseIdentifier: String?, withFrame frame: CGRect) -> AnyObject {
        
        self.frame = frame
        nameLabel = UILabel(frame: CGRectMake(10, 5, 100, 30))
        nameLabel.font = UIFont.systemFontOfSize(15)
        self.contentView.addSubview(nameLabel)
        
        numberBtn = UIButton(type: .Custom)
        numberBtn.frame = CGRectMake(self.frame.size.width-85, 12, 80, 15)
        numberBtn.layer.masksToBounds = true
        numberBtn.layer.cornerRadius = 7
        numberBtn.titleLabel?.font = UIFont.systemFontOfSize(11)
        numberBtn.setBackgroundImage(UIImage(named: "film"), forState: .Normal)
        numberBtn.setBackgroundImage(UIImage(named: "film"), forState: .Highlighted)
        numberBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        numberBtn.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        self.contentView.addSubview(numberBtn)
        
        let lineView: UIView = UIView(frame: CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5))
        lineView.backgroundColor = RGB(192, g: 192, b: 192)
        self.contentView.addSubview(lineView)
        return self
    }
    
    func setGroupM(groupM: MerCateGroupModel) {
        nameLabel.text = groupM.name
        if groupM.list == nil {
            numberBtn.setTitle("\(groupM.count)", forState: .Normal)
        } else {
            numberBtn.setTitle("\(groupM.count)>", forState: .Normal)
        }
        
        let str: NSString = "\(groupM.count)>"
        let textSize = str.boundingRectWithSize(CGSizeMake(80, 15), options: NSStringDrawingOptions.UsesFontLeading, attributes: nil, context: nil)
        numberBtn.frame = CGRectMake(self.frame.size.width-10-textSize.width-10, 12, textSize.width+10, 15)
        
        
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
