//
//  CustomViewController.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/17.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit
import SnapKit
import BetterSegmentedControl

class CustomViewController: UIViewController,UIScrollViewDelegate {
    
    var scrollView = UIScrollView()
    var tableViewsArray :Array<CustomTableView>
    let titleSegment :BetterSegmentedControl
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: 构造函数
    init(title :String,subTitles :Array<String>) {
        self.tableViewsArray = Array<CustomTableView>()
        
        self.titleSegment = BetterSegmentedControl.init(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 64), size: CGSize.init(width: UIScreen.main.bounds.width, height: 50)), titles: subTitles, index: 0, backgroundColor: .white, titleColor: UIColor.black, indicatorViewBackgroundColor: UIColor(red:0.55, green:0.26, blue:0.86, alpha:1.00), selectedTitleColor: .blue)
        
        super.init(nibName: nil, bundle: nil);
        self.tabBarItem.title = title
        self.title = title
        let screenFrame = UIScreen.main.bounds
        self.scrollView.delegate = self;
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.alwaysBounceHorizontal = true
        self.scrollView.contentSize = CGSize.init(width: screenFrame.width * CGFloat(subTitles.count), height: screenFrame.height)
        self.scrollView.contentOffset = CGPoint.zero
        self.scrollView.backgroundColor = UIColor.lightGray
        self.view.addSubview(self.scrollView)
        
        for item in subTitles {
            let tableView = CustomTableView.init(cellReuseIndentifier: item)
            self.tableViewsArray.append(tableView)
            tableView.backgroundColor = UIColor.lightGray
            self.scrollView.addSubview(tableView)
        }
        
        self.view.addSubview(self.titleSegment)
        self.titleSegment.addTarget(self, action: #selector(changeSelectedIndex(sender:)), for: UIControlEvents.valueChanged)
        self.addConstraintForSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 添加约束
    func addConstraintForSubviews() {
        unowned let weakSelf = self
        self.titleSegment.snp.makeConstraints { (make) in
            make.top.equalTo(weakSelf.view.snp.top).offset(64)
            make.left.equalTo(weakSelf.view.snp.left)
            make.right.equalTo(weakSelf.view.snp.right)
            make.height.equalTo(50)
        }
        self.scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(weakSelf.view.snp.top).offset(114)
            make.left.equalTo(weakSelf.view.snp.left)
            make.right.equalTo(weakSelf.view.snp.right)
            make.bottom.equalTo(weakSelf.view.snp.bottom)
        }
        for (index,tableView) in self.tableViewsArray.enumerated() {
            if index == 0 {
                tableView.snp.makeConstraints({ (make) in
                    make.top.equalTo(weakSelf.view.snp.top).offset(64)
                    make.bottom.equalTo(weakSelf.view.snp.bottom)
                    make.width.equalTo(weakSelf.view.snp.width)
                })
            }else {
                let tmp = self.tableViewsArray[index - 1]
                tableView.snp.makeConstraints({ (make) in
                    make.top.equalTo(weakSelf.view.snp.top).offset(64)
                    make.bottom.equalTo(weakSelf.view.snp.bottom)
                    make.width.equalTo(weakSelf.view.snp.width)
                    make.left.equalTo(tmp.snp.right)
                })
            }
        }
    }
    
    // MARK: segmentconrol 选中
    func changeSelectedIndex(sender :BetterSegmentedControl) {
        
    }
}
