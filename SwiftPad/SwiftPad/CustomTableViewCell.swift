//
//  CustomTableViewCell.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/18.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    let viewMargin = 10
    var portraitImage :UIImageView = UIImageView.init(image: #imageLiteral(resourceName: "portrait_loading"))
    var recommendIcon :UIImageView = UIImageView.init(image: #imageLiteral(resourceName: "recommend"))
    var titleLabel = UILabel()
    var contentLabel = UILabel()
    var languageMarkView :MarkView = MarkView.init(markType: MarkType.LanguageType, markStr: nil);
    var forkMarkView :MarkView = MarkView.init(markType: MarkType.ForkType, markStr: nil)
    var starMarkView :MarkView = MarkView.init(markType: MarkType.StarType, markStr: nil)
    var watchMarkView :MarkView = MarkView.init(markType: MarkType.WatchType, markStr: nil)
    
    // MARK: 构造函数
    init() {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        self.contentView.addSubview(portraitImage)
        self.contentView.addSubview(recommendIcon)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(languageMarkView)
        self.contentView.addSubview(forkMarkView)
        self.contentView.addSubview(starMarkView)
        self.contentView.addSubview(watchMarkView)
        
        self.contentLabel.numberOfLines = 0
        self.contentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.contentLabel.textColor = UITool.UIColorFromRGB(rgbValue: 0x515151)
        
        self.titleLabel.textColor = UITool.UIColorFromRGB(rgbValue: 0x294fa1)
        self.titleLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        self.addConstraintForSubViews()
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
    
    // MARK: 添加约束
    func addConstraintForSubViews() {
       unowned let weakSelf = self
        
        self.portraitImage.snp.makeConstraints { (make) in
            make.left.equalTo(weakSelf.snp.left).offset(viewMargin)
            make.top.equalTo(weakSelf.snp.top).offset(viewMargin)
            make.width.height.equalTo(50)
        }
        self.recommendIcon.snp.makeConstraints { (make) in
            make.left.equalTo(weakSelf.portraitImage.snp.right).offset(viewMargin)
            make.top.equalTo(weakSelf.portraitImage.snp.top)
            make.width.height.equalTo(20)
        }
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(weakSelf.recommendIcon.snp.top)
            make.left.equalTo(weakSelf.recommendIcon.snp.right).offset(viewMargin / 2)
            make.right.equalTo(weakSelf.snp.right).offset(-viewMargin)
            make.height.equalTo(20)
        }
        self.contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(weakSelf.titleLabel.snp.bottom).offset(viewMargin)
            make.left.equalTo(weakSelf.recommendIcon.snp.left)
            make.right.equalTo(weakSelf.snp.right).offset(-viewMargin)
        }
        self.languageMarkView.snp.makeConstraints({ (make) in
            make.bottom.equalTo(weakSelf.snp.bottom).offset(-viewMargin)
            make.left.equalTo(self.recommendIcon.snp.left)
            make.height.equalTo(15)
        })
        self.forkMarkView.snp.makeConstraints({ (make) in
            if !self.languageMarkView.isHidden {
                make.left.equalTo(weakSelf.languageMarkView.snp.right).offset(viewMargin)
            }else {
                make.left.equalTo(weakSelf.recommendIcon.snp.left)
            }
            make.bottom.equalTo(weakSelf.snp.bottom).offset(-viewMargin)
            make.height.equalTo(15)
        })
        self.starMarkView.snp.makeConstraints({ (make) in
            make.left.equalTo(weakSelf.forkMarkView.snp.right).offset(viewMargin)
            make.bottom.equalTo(weakSelf.snp.bottom).offset(-viewMargin)
            make.height.equalTo(15)
        })
        self.watchMarkView.snp.makeConstraints { (make) in
            make.left.equalTo(weakSelf.starMarkView.snp.right).offset(viewMargin)
            make.bottom.equalTo(weakSelf.snp.bottom).offset(-viewMargin)
            make.height.equalTo(15)
        }
    }

}
