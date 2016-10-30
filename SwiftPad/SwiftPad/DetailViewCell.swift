//
//  DetailViewCell.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/29.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit

class DetailViewCell: UITableViewCell {
    
    let separatorLine = UIView.init()
    let accessoryImageView : UIImageView = UIImageView.init(image: #imageLiteral(resourceName: "ic_arrow_right"))
    var iconImageView :UIImageView? = UIImageView.init()
    var titleLabel : UILabel? = UILabel.init()
    
   override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
       super.init(style: .default, reuseIdentifier: reuseIdentifier)
       self.initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        self.contentView.addSubview(self.separatorLine)
        self.contentView.addSubview(self.accessoryImageView)
        self.contentView.addSubview(self.iconImageView!)
        self.contentView.addSubview(self.titleLabel!)
        
        self.separatorLine.backgroundColor = UIColor.darkGray
        self.separatorLine.alpha = 0.8
        
        self.addConstraintsForSubviews()
    }
    
    func addConstraintsForSubviews() {
        unowned let weakSelf = self
        self.separatorLine.snp.makeConstraints { (make) in
            make.bottom.equalTo(weakSelf)
            make.height.equalTo(0.5)
            make.left.right.equalTo(weakSelf)
        }
        self.iconImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(weakSelf.snp.left).offset(15)
            make.centerY.equalTo(weakSelf)
            make.height.width.equalTo(25)
            
        })
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((weakSelf.iconImageView?.snp.right)!).offset(15)
            make.centerY.equalTo(weakSelf)
            make.height.equalTo(44)
            make.right.equalTo(weakSelf.accessoryImageView.snp.left)
        })
        
        self.accessoryImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(15)
            make.right.equalTo(weakSelf.snp.right).offset(-15)
            make.centerY.equalTo(weakSelf)
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
