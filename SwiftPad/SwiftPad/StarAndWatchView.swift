//
//  StarAndWatchView.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/25.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit
import SnapKit

enum StarAndWatchState :NSInteger {
    case Star = 0,UNStar,Watch,UNWatch
}

class StarAndWatchView: UIView {

    var stateBtn :UIButton = UIButton.init(type: UIButtonType.custom)
    var stateLabel :UILabel = UILabel.init()
    var state :StarAndWatchState = StarAndWatchState.Star
    var starWatchNum :NSInteger = 0
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(stateType :StarAndWatchState,num :NSInteger) {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.addSubview(self.stateBtn)
        self.addSubview(self.stateLabel)
        self.starWatchNum = num
        switch stateType {
        case .Star:
            self.stateBtn.setTitle("Star", for: .normal)
            self.stateBtn.setImage(#imageLiteral(resourceName: "projectDetails_star"), for: UIControlState.normal)
            self.state = .Star
        case .UNStar:
            self.stateBtn.setTitle("UnStar", for: .normal)
            self.stateBtn.setImage(#imageLiteral(resourceName: "projectDetails_star"), for: UIControlState.normal)
            self.state = .UNStar
        case .Watch:
            self.stateBtn.setTitle("Watch", for: .normal)
            self.stateBtn.setImage(#imageLiteral(resourceName: "projectDetails_watch"), for: UIControlState.normal)
            self.state = .Watch
        case .UNWatch:
            self.stateBtn.setTitle("Unwatch", for: .normal)
            self.stateBtn.setImage(#imageLiteral(resourceName: "projectDetails_watch"), for: UIControlState.normal)
            self.state = .UNWatch
        }
        self.stateBtn.addTarget(self, action: #selector(stateBtnAction), for: UIControlEvents.touchUpInside)
        self.stateBtn.setBackgroundImage(#imageLiteral(resourceName: "button_bg"), for: .normal)
        self.stateBtn.setTitleColor(UITool.UIColorFromRGB(rgbValue: 0x494949), for: .normal)
        self.stateBtn.layer.borderColor = UITool.UIColorFromRGB(rgbValue: 0xd4d4d4).cgColor
        self.stateBtn.layer.borderWidth = 0.5
        
        switch stateType {
        case .Star,.UNStar:
            self.stateLabel.text = "\(num) Stars"
        default:
            self.stateLabel.text = "\(num) Watches"
        }
        self.stateLabel.textAlignment = .center
        
        self.stateLabel.backgroundColor = UIColor.white
        self.addConstraintForSubviews()
        
    }
    
    func stateBtnAction() {
        switch self.state {
        case .Star:
            self.stateBtn.setTitle("Unstar", for: .normal)
            self.state = .UNStar
            self.starWatchNum += 1
        case .UNStar:
            self.stateBtn.setTitle("Star", for: .normal)
            self.state = .Star
            self.starWatchNum -= 1
        case .Watch:
            self.stateBtn.setTitle("Unwatch", for: .normal)
            self.state = .UNWatch
            self.starWatchNum += 1
        default:
            self.stateBtn.setTitle("Watch", for: .normal)
            self.state = .Watch
            self.starWatchNum -= 1
        }
        
        switch self.state {
        case .Star,.UNStar:
            self.stateLabel.text = "\(self.starWatchNum) Stars"
        default:
            self.stateLabel.text = "\(self.starWatchNum) Watches"
        }
    }
    
    func addConstraintForSubviews() {
        unowned let weakSelf = self
        self.stateBtn.snp.makeConstraints { (make) in
            make.top.equalTo(weakSelf.snp.top)
            make.left.equalTo(weakSelf.snp.left)
            make.right.equalTo(weakSelf.snp.right)
        }
        self.stateLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(weakSelf.snp.bottom)
            make.left.equalTo(weakSelf.snp.left)
            make.right.equalTo(weakSelf.snp.right)
            make.height.equalTo(weakSelf.stateBtn)
            make.top.equalTo(weakSelf.stateBtn.snp.bottom)
        }
    }
    
}
