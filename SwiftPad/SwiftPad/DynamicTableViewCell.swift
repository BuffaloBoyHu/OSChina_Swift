//
//  DynamicTableViewCell.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/11/2.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import AlamofireImage

class DynamicTableViewCell: UITableViewCell {

    
    var iconImageView = UIImageView.init(image: #imageLiteral(resourceName: "portrait_loading"))
    var contentTextView :UITextView? = UITextView.init()
    var timeLabel :UILabel = UILabel.init()
    let separatorLine  = UIView.init()
    var titleLabel :UILabel = UILabel.init()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: 初始化视图
    func initView() {
        self.contentView.addSubview(self.iconImageView)
        self.contentView.addSubview(self.contentTextView!)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.separatorLine)
        self.contentView.addSubview(self.titleLabel)
        
        self.iconImageView.layer.cornerRadius = 5
        self.iconImageView.layer.masksToBounds = true
        
        self.titleLabel.numberOfLines = 0
        
        self.contentTextView?.isScrollEnabled = false
        self.contentTextView?.isSelectable = false
        self.contentTextView?.isSelectable = false
        
        self.separatorLine.backgroundColor = UIColor.darkGray
        self.separatorLine.alpha = 0.8
        
        self.timeLabel.textColor = UITool.UIColorFromRGB(rgbValue: 0xb6b6b6)
        self.timeLabel.font =  UIFont.systemFont(ofSize: 15)
        
        self.addConstraintsForSubViews()
    }
    
    func addConstraintsForSubViews() {
        unowned let weakSelf = self
        self.iconImageView.snp.makeConstraints { (make) in
            make.left.top.equalTo(weakSelf).offset(10)
            make.width.height.equalTo(50)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(weakSelf.iconImageView.snp.right).offset(10)
            make.top.equalTo(weakSelf.iconImageView.snp.top)
            make.right.equalTo(weakSelf.snp.right).offset(-10)
        }
        
        self.contentTextView?.snp.makeConstraints({ (make) in
            make.left.equalTo(weakSelf.iconImageView.snp.right).offset(10)
            make.right.equalTo(weakSelf.snp.right).offset(-10)
            make.top.equalTo(weakSelf.titleLabel.snp.bottom).offset(10)
            make.bottom.equalTo(weakSelf.timeLabel.snp.top).offset(-10)
        })
        
        self.timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(weakSelf.titleLabel.snp.left)
            make.bottom.equalTo(weakSelf.snp.bottom).offset(-10)
            make.right.equalTo(weakSelf.snp.right).offset(-10)
        }
        
        self.separatorLine.snp.makeConstraints { (make) in
            make.bottom.equalTo(weakSelf.snp.bottom)
            make.left.right.equalTo(weakSelf)
            make.height.equalTo(0.5)
        }
    }
    
    func stuffCellWithModel(model:DynamicModel) {
        unowned let weakSelf = self
        let imageURL = model.customModel?.owner?.new_portrait
        Alamofire.request(imageURL!).responseImage { (response) in
            weakSelf.iconImageView.image = response.result.value
        }
        
        self.titleLabel.attributedText = model.dynamicAttributeDescriptionStr()
        self.timeLabel.text = UITool.formateDate(dateStr: model.createdAt)
        self.contentTextView?.text = nil// todo
        
    }

}
