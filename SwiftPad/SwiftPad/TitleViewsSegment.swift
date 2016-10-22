//
//  TitleViewsSegment.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/19.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit

class TitleViewsSegment: UISegmentedControl {

    var lineView :UIView
    
    override init(items: [Any]?) {
        self.lineView = UIView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: UIScreen.main.bounds.width / CGFloat((items?.count)!), height: 2)))
        super.init(items: items)
        self.addSubview(self.lineView)
        
        self.backgroundColor = UIColor.white
        self.setTitleTextAttributes([NSFontAttributeName:UIFont.italicSystemFont(ofSize: 16),NSForegroundColorAttributeName:UIColor.black], for: UIControlState.normal)
        self.setTitleTextAttributes([NSFontAttributeName:UIFont.italicSystemFont(ofSize: 16),NSForegroundColorAttributeName:UIColor.blue], for: UIControlState.selected)
        self.tintColor = UIColor.white
        self.selectedSegmentIndex = 0
        
        self.lineView.backgroundColor = UIColor.blue
        self.addConstraintForLineView(count: (items?.count)!)
        self.lineView.setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addConstraintForLineView(count :NSInteger) {
        unowned let weakSelf = self
        self.lineView.snp.makeConstraints { (make) in
            make.bottom.equalTo(weakSelf.snp.bottom)
            make.width.equalTo(weakSelf.frame.width / CGFloat(count))
            make.height.equalTo(2)
        }
    }
    func changeSelectedIndex(index :NSInteger) {
        var frame = self.lineView.frame
        frame.origin.x = CGFloat(index) * frame.width
        self.lineView.frame = frame
    }
}
