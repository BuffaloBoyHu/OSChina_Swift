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

enum ProjectType :Int {
    case Projects = 0,Find,Mine
}

class CustomViewController: UIViewController,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate {

    var scrollView = UIScrollView()
    var tableViewsArray :Array<CustomTableView>
    let titleSegment :BetterSegmentedControl
    var type :ProjectType? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        do {
            try self.titleSegment.set(index: 0, animated: true)
        } catch {
            
        }
        self.fetchObject(needRefresh: true)
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
            tableView.dataSource = self
            tableView.delegate = self
            tableView.scrollsToTop = true
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
            make.top.equalTo(weakSelf.titleSegment.snp.bottom)
            make.left.equalTo(weakSelf.view.snp.left)
            make.right.equalTo(weakSelf.view.snp.right)
            make.bottom.equalTo(weakSelf.view.snp.bottom)
        }
        for (index,tableView) in self.tableViewsArray.enumerated() {
            if index == 0 {
                tableView.snp.makeConstraints({ (make) in
                    make.top.equalTo(weakSelf.view.snp.top).offset(114)
                    make.bottom.equalTo(weakSelf.view.snp.bottom)
                    make.width.equalTo(weakSelf.view.snp.width)
                })
            }else {
                let tmp = self.tableViewsArray[index - 1]
                tableView.snp.makeConstraints({ (make) in
                    make.top.equalTo(weakSelf.view.snp.top).offset(114)
                    make.bottom.equalTo(weakSelf.view.snp.bottom)
                    make.width.equalTo(weakSelf.view.snp.width)
                    make.left.equalTo(tmp.snp.right)
                })
            }
        }
    }
    
    // MARK: segmentconrol 选中
    func changeSelectedIndex(sender :BetterSegmentedControl) {
        self.scrollView.contentOffset.x = CGFloat(sender.index) * self.scrollView.frame.size.width
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int (scrollView.contentOffset.x / scrollView.frame.size.width)
        do {
            try self.titleSegment.set(index: UInt(page), animated: true)
        } catch {
            
        }
        scrollView.contentOffset.x = CGFloat(page) * scrollView.frame.size.width
        
    }
    
    // MARK: tableView Datasource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tmpTableView = tableView as! CustomTableView
        return (tmpTableView.dataArray?.count)!
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tmpTableview = tableView as! CustomTableView
        let cellIdentifier = tmpTableview.tableName!
        let cell = tmpTableview.dequeueReusableCell(withIdentifier: cellIdentifier) as? CustomTableViewCell
        let model = tmpTableview.dataArray?[indexPath.row] as! CustomModel
        cell?.stuffCellWithModel(model: model)
        cell?.updateConstraintsForSubviews()
        cell?.setNeedsLayout()
        return cell!
    }
    
    // MARK: tableview delegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tmpTableView = tableView as! CustomTableView
        let model = tmpTableView.dataArray?[indexPath.row] as! CustomModel
        return model.rowHeight
    }
    
    // MARK: 数据
    func fetchObject(needRefresh :Bool) {
        if needRefresh {
            for item in self.scrollView.subviews {
                if let tableView :CustomTableView = item as? CustomTableView {
                    tableView.isNeedRefresh(refresh: true)
                }
            }
        }
    }
    
}
