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

    let scrollView = UIScrollView()
    var tableViewsArray :Array<CustomTableView>
    let titleSegment :BetterSegmentedControl
    var type :ProjectType? = nil
    var subTitles :Array<String>? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
        if self.title == "我的" {
            let leftBtn = UIBarButtonItem.init(image: #imageLiteral(resourceName: "sidebar_mine"), style: .plain, target: self, action: #selector(profileBtnAction))
            self.navigationItem.leftBarButtonItem = leftBtn
            let rightBtn = UIBarButtonItem.init(image: #imageLiteral(resourceName: "SetUp"), style: .plain, target: self, action: #selector(setUpAction))
            self.navigationItem.rightBarButtonItem = rightBtn
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            try self.titleSegment.set(index: 0, animated: true)
        } catch {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: 构造函数
    init(title :String,subTitles :Array<String>) {
        self.tableViewsArray = Array<CustomTableView>()
        self.subTitles = subTitles
        self.titleSegment = BetterSegmentedControl.init(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 64), size: CGSize.init(width: UIScreen.main.bounds.width, height: 50)), titles: subTitles, index: 0, backgroundColor: .white, titleColor: UIColor.black, indicatorViewBackgroundColor: UIColor(red:0.55, green:0.26, blue:0.86, alpha:1.00), selectedTitleColor: .blue)
        
        super.init(nibName: nil, bundle: nil);
        self.tabBarItem.title = title
        self.title = title
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        let screenFrame = self.view.frame
        self.scrollView.delegate = self;
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.alwaysBounceHorizontal = true
//        self.scrollView.isDirectionalLockEnabled = true
        self.scrollView.contentSize = CGSize.init(width: screenFrame.width * CGFloat((self.subTitles?.count)!), height: screenFrame.height - 114)
        self.scrollView.contentOffset = CGPoint.zero
        self.scrollView.backgroundColor = UIColor.lightGray
        self.view.addSubview(self.scrollView)
        
        self.tableViewsArray.removeAll()
        self.scrollView.removeAllSubviews()
        for item in self.subTitles! {
            let isDynamicType = item == "动态" ? true : false
            let tableView = CustomTableView.init(cellReuseIndentifier: item, isDynamicType: isDynamicType)
            tableView.backgroundColor = UIColor.lightGray
            tableView.dataSource = self
            tableView.delegate = self
            tableView.alwaysBounceVertical = true
            tableView.alwaysBounceHorizontal = false
            self.scrollView.addSubview(tableView)
            self.tableViewsArray.append(tableView)
            tableView.isNeedRefresh(refresh: true)
        }
        
        self.view.addSubview(self.titleSegment)
        self.titleSegment.addTarget(self, action: #selector(changeSelectedIndex(sender:)), for: UIControlEvents.valueChanged)
        self.addConstraintForSubviews()
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
        if scrollView == self.scrollView {
            let page = Int (scrollView.contentOffset.x / scrollView.frame.size.width)
            do {
                try self.titleSegment.set(index: UInt(page), animated: true)
            } catch {
                
            }
            scrollView.contentOffset.x = CGFloat(page) * scrollView.frame.size.width
        }
        
    }
    
    // MARK: tableView Datasource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tmpTableView = tableView as! CustomTableView
        return (tmpTableView.dataArray?.count)!
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tmpTableview = tableView as! CustomTableView
        let cellIdentifier = tmpTableview.tableName!
        if tmpTableview.isDynamicType {
            let cell = tmpTableview.dequeueReusableCell(withIdentifier: cellIdentifier) as? DynamicTableViewCell
            let model = tmpTableview.dataArray?[indexPath.row] as! DynamicModel
            cell?.stuffCellWithModel(model: model)
            return cell!
            
        }else {
            let cell = tmpTableview.dequeueReusableCell(withIdentifier: cellIdentifier) as? CustomTableViewCell
            if indexPath.row >= (tmpTableview.dataArray?.count)! {
                return cell!
            }
            let model = tmpTableview.dataArray?[indexPath.row] as! CustomModel
            cell?.stuffCellWithModel(model: model)
            cell?.updateConstraintsForSubviews()
            cell?.setNeedsLayout()
            return cell!
        }
    }
    
    // MARK: tableview delegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tmpTableView = tableView as! CustomTableView
        let detailController = DetailViewController()
        detailController.model = tmpTableView.dataArray?[indexPath.row] as? CustomModel
        self.navigationController?.pushViewController(detailController, animated: true)

    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tmpTableView = tableView as! CustomTableView
        if  tmpTableView.isDynamicType {
//            let model = tmpTableView.dataArray?[indexPath.row] as! DynamicModel
            return 100
        }
        
        let model = tmpTableView.dataArray?[indexPath.row] as! CustomModel
        return model.rowHeight + 75
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
    
    // MARK: navigationitem Action
    func profileBtnAction() {
        let userController = UserProfileViewController()
        self.navigationController?.pushViewController(userController, animated: true)
    }
    
    func setUpAction() {
        let setupController = SetUpViewController()
        self.navigationController?.pushViewController(setupController, animated: true)
    }
    
}
