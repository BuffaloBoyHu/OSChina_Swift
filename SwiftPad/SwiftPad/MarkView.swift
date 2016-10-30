//
//  MarkView.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/18.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit
import SnapKit

enum MarkType : Int{
    case LanguageType,ForkType,StarType,WatchType,ProjectDetail_time,ProjectDetail_fork,Projectdetal_public,ProjectDetail_language
}

class MarkView: UIView {
    var markImageView = UIImageView()
    var markLabel = UILabel()
    init(markType:MarkType,markStr:String?) {
        super.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 20, height: 10)))
        switch markType {
        case .LanguageType:
            self.markImageView.image = #imageLiteral(resourceName: "language")
        case .ForkType:
            self.markImageView.image = #imageLiteral(resourceName: "fork")
        case .StarType:
            self.markImageView.image = #imageLiteral(resourceName: "star")
        case .WatchType:
            self.markImageView.image = #imageLiteral(resourceName: "watch")
        case .ProjectDetail_time:
            self.markImageView.image = #imageLiteral(resourceName: "projectDetails_time")
        case .ProjectDetail_fork:
            self.markImageView.image = #imageLiteral(resourceName: "projectDetails_fork")
        case .Projectdetal_public:
            self.markImageView.image = #imageLiteral(resourceName: "projectDetails_public")
        case .ProjectDetail_language:
            self.markImageView.image = #imageLiteral(resourceName: "projectDetails_language")
        }
        self.markLabel.text = markStr
        
        self.markLabel.textColor = UITool.UIColorFromRGB(rgbValue: 0xb6b6b6)
        self.addSubview(markImageView)
        self.addSubview(markLabel)
        self.addConstaraintForSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK:添加约束
    func addConstaraintForSubViews() {
        unowned let weakSelf = self
        self.markImageView.snp.makeConstraints { (make) in
            make.left.equalTo(weakSelf.snp.left);
            make.top.equalTo(weakSelf.snp.top)
            make.height.width.equalTo(15)
        }
        self.markLabel.snp.makeConstraints { (make) in
            make.left.equalTo(weakSelf.markImageView.snp.right).offset(5)
            make.top.equalTo(weakSelf.markImageView.snp.top)
            make.right.equalTo(weakSelf.snp.right)
            make.height.equalTo(weakSelf.markImageView)
        }
    }

}
