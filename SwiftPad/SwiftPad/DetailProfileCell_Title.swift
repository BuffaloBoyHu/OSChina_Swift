//
//  DetailProfileCell_Title.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/27.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailProfileCell_Title: UITableViewCell {
    
    let portaintImageView = UIImageView.init(image: #imageLiteral(resourceName: "portrait_loading"))
    let titleLabel = UILabel.init()
    let subTitleLabel = UILabel.init()
    let separatorLine = UIView.init()
    
    
    let cellIdentifier = "DetailProfileCell_Title"
    //MARK: 构造函数
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: cellIdentifier)
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
        super.setSelected(false, animated: true)
        // Configure the view for the selected state
    }
    
    func initView() {
        self.contentView.addSubview(self.portaintImageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.subTitleLabel)
        self.contentView.addSubview(self.separatorLine)
        
        self.portaintImageView.layer.cornerRadius = 8
        self.portaintImageView.layer.masksToBounds = true
        
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        self.titleLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        self.separatorLine.backgroundColor = UIColor.darkGray
        self.separatorLine.alpha = 0.8
        
        self.backgroundColor = UITool.UIColorFromRGB(rgbValue: 0xf0f0f0)
        self.addConstraintForSubViews()
        self.selectionStyle = .none
    }
    
    func addConstraintForSubViews() {
        unowned let weakSelf = self
        self.portaintImageView.snp.makeConstraints { (make) in
            make.left.top.equalTo(weakSelf).offset(10)
            make.height.width.equalTo(40)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(weakSelf.portaintImageView.snp.right).offset(10)
            make.top.equalTo(weakSelf.portaintImageView.snp.top)
            make.right.equalTo(weakSelf.snp.right).offset(-10)
            make.height.equalTo(weakSelf.portaintImageView.snp.height)
        }
        
        self.subTitleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(weakSelf.snp.bottom).offset(-10)
            make.left.equalTo(weakSelf.portaintImageView.snp.left)
            make.right.equalTo(weakSelf.snp.right).offset(-10)
            make.height.equalTo(15)
        }
        
        self.separatorLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(weakSelf)
            make.bottom.equalTo(weakSelf.snp.bottom)
            make.height.equalTo(0.5)
        }
    }
    
    func stuffCellWithModel(model :CustomModel) {
        self.titleLabel.text = model.name
        
        let urlString = model.owner?.new_portrait!
        Alamofire.request(urlString!).responseImage { (response) in
            if response.result.isSuccess {
                self.portaintImageView.image = response.result.value
            }
        }
        
        let attributeStr : NSMutableAttributedString = NSMutableAttributedString.init(string: "更新于 ", attributes: [NSForegroundColorAttributeName:UIColor.gray,NSFontAttributeName:UIFont.systemFont(ofSize: 15)])
        var timeStr = (model.last_push_at != nil) ? model.last_push_at : model.created_at
        timeStr = UITool.formateDate(dateStr: timeStr)
        let timeAttributeStr :NSAttributedString = NSAttributedString.init(string: timeStr!, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:UIColor.init(red: CGFloat( 153 / 255.0), green: CGFloat(153 / 255.0 ), blue: CGFloat( 153 / 255.0), alpha: 1.0)])
        attributeStr.append(timeAttributeStr)
        self.subTitleLabel.attributedText = attributeStr
        
    }

}
