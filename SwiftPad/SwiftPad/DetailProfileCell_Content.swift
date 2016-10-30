//
//  DetailProfileCell_Content.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/27.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit

class DetailProfileCell_Content: UITableViewCell {
    
    let descriptionLabel = UILabel.init()
    let starView = StarAndWatchView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 60, height: 30)))
    let watchView = StarAndWatchView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 60, height: 30)))
    let  separatorLine = UIView.init()
    
    
    let cellIdentifier = "DetailProfileCell_Content"
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: cellIdentifier)
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
        
        // Configure the view for the selected state
    }
    
    func initView() {
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.starView)
        self.contentView.addSubview(self.watchView)
        self.contentView.addSubview(self.separatorLine)
        
        self.descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        
        self.separatorLine.backgroundColor = UIColor.darkGray
        self.separatorLine.alpha = 0.8
        
        self.backgroundColor = UITool.UIColorFromRGB(rgbValue: 0xf0f0f0)
        self.autoresizingMask = .flexibleWidth
        self.selectionStyle = .none
        self.addConstarintForSubViews()
    }
    
    func addConstarintForSubViews() {
        unowned let weakSelf = self
        
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(weakSelf.snp.left).offset(10)
            make.top.equalTo(weakSelf.snp.top).offset(10)
            make.right.equalTo(weakSelf.snp.right).offset(-10)
        }
        
        self.starView.snp.makeConstraints { (make) in
            make.left.equalTo(weakSelf.snp.left).offset(10)
            make.bottom.equalTo(weakSelf.snp.bottom).offset(-20)
            make.height.equalTo(60)
            make.width.equalTo(120)
        }
        self.watchView.snp.makeConstraints { (make) in
            make.right.equalTo(weakSelf.snp.right).offset(-10)
            make.bottom.equalTo(weakSelf.snp.bottom).offset(-20)
            make.height.equalTo(60)
            make.width.equalTo(weakSelf.starView)
        }
        
        self.separatorLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(weakSelf)
            make.bottom.equalTo(weakSelf.snp.bottom)
            make.height.equalTo(0.5)
        }
    }
    
    func stuffCellWithModel(model :CustomModel) {
        self.descriptionLabel.text = "暂无项目介绍"
        if model.descriptionStr != nil {
            self.descriptionLabel.text = model.descriptionStr
        }
        if !model.stared! {
            self.starView.initView(stateType: .Star, num: model.stars_count!)
        }else {
            self.starView.initView(stateType: .UNStar, num: model.stars_count!)
        }
        
        if !model.watched! {
            self.watchView.initView(stateType: .Watch, num: model.watches_count!)
        }else {
            self.watchView.initView(stateType: .UNWatch, num: model.watches_count!)
        }
        
    }

}
