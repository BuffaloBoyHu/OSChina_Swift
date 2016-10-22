//
//  CustomCollectionViewCell.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/19.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    var  titleLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.backgroundColor = UIColor.clear
        self.titleLabel.textColor = UIColor.darkText
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        self.titleLabel.sizeToFit()
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.titleLabel.textAlignment = NSTextAlignment.center
        unowned let weakSelf = self
        self.titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(weakSelf)
        }
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
    
    func isSelected(selected :Bool)  {
        if selected {
            let red = CGFloat(arc4random_uniform(255)) / CGFloat(255)
            let green = CGFloat(arc4random_uniform(255)) / CGFloat(255)
            let blue = CGFloat(arc4random_uniform(255)) / CGFloat(255)
            self.backgroundColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1)
        }else {
            self.backgroundColor = UIColor.lightGray
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
