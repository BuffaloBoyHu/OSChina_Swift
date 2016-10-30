//
//  DetailStateCell.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/23.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit

class DetailStateCell: UITableViewCell {

    let timeView  = MarkView.init(markType: MarkType.ProjectDetail_time, markStr: nil)
    let forkView  = MarkView.init(markType: MarkType.ProjectDetail_fork, markStr: nil)
    let publicView = MarkView.init(markType: MarkType.Projectdetal_public, markStr: nil)
    let languageView = MarkView.init(markType: MarkType.ProjectDetail_language, markStr: nil)
    let separatorLine = UIView.init()
    
    
    let cellIdentifier = "DetailStateCell"
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
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView() {
        self.contentView.addSubview(self.timeView)
        self.contentView.addSubview(self.forkView)
        self.contentView.addSubview(self.publicView)
        self.contentView.addSubview(self.languageView)
        self.contentView.addSubview(self.separatorLine)
        
        self.separatorLine.backgroundColor = UIColor.darkGray
        self.separatorLine.alpha = 0.8
        
        self.autoresizingMask = .flexibleWidth
        self.selectionStyle = .none
        self.addConstraintsForSubViews()
    }
    
    func addConstraintsForSubViews() {
        unowned let weakSelf = self
        self.timeView.snp.makeConstraints { (make) in
            make.left.equalTo(weakSelf.snp.left).offset(10)
            make.top.equalTo(weakSelf.snp.top).offset(15)
        }
        self.forkView.snp.makeConstraints { (make) in
            make.right.equalTo(weakSelf.snp.right).offset(-10)
            make.top.equalTo(weakSelf.snp.top).offset(15)
            make.left.equalTo(weakSelf.timeView.snp.right)
            make.width.equalTo(weakSelf.timeView)
            
        }
        self.publicView.snp.makeConstraints { (make) in
            make.left.equalTo(weakSelf.snp.left).offset(10)
            make.bottom.equalTo(weakSelf.snp.bottom).offset(-10)
            make.top.equalTo(weakSelf.timeView.snp.bottom)
            make.height.equalTo(weakSelf.timeView)
        }
        self.languageView.snp.makeConstraints { (make) in
            make.right.equalTo(weakSelf.snp.right).offset(-10)
            make.bottom.equalTo(weakSelf.snp.bottom).offset(-10)
            make.top.equalTo(weakSelf.forkView.snp.bottom)
            make.width.equalTo(weakSelf.publicView)
            make.left.equalTo(weakSelf.publicView.snp.right)
            make.height.equalTo(weakSelf.forkView)
            
        }
        
        self.separatorLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(weakSelf)
            make.bottom.equalTo(weakSelf.snp.bottom)
            make.height.equalTo(0.5)
        }
    }
    
    func stuffCellWithModel(model :CustomModel) {
        self.timeView.markLabel.text = UITool.formateDate(dateStr: model.created_at)
        self.forkView.markLabel.text = "\(model.forks_count!)"
        self.publicView.markLabel.text = model.publicBool! ? "Public" : "Private"
        self.languageView.markLabel.text = model.language
    }

}
