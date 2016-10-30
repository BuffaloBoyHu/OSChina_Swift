//
//  CustomCollectionController.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/19.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit
import Alamofire
import AFNetworking

private let reuseIdentifier = "Cell"

class CustomCollectionController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var dataArray : Array<Any> = [Any]()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout.init())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.backgroundColor = UITool.uniformColor()
        self.collectionView?.alpha = 0.8
        self.fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        let rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .refresh, target: self, action: #selector(clearCellSelectedColor))
        self.tabBarController?.navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.dataArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        cell.isSelected(selected: false)
        let dict = self.dataArray[indexPath.row] as! Dictionary<String,Any>
        cell.titleLabel.text = dict["name"] as? String
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
        cell.isSelected(selected: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell  = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
        cell.isSelected(selected: false)
        
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 行间距
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        //  cell之间的最小距离
        return 5
    }
    
    // MARK: 抓取数据
    func fetchData() {
        let urlStr = "https://git.oschina.net/api/v3//projects/languages"
        unowned let weakSelf = self
        Alamofire.request(urlStr).responseJSON { (response) in
            if response.result.isSuccess {
                let tmpArray = response.result.value as? Array<Any>
                weakSelf.dataArray = tmpArray!
                weakSelf.collectionView?.reloadData()
            }else {
                // 数据请求错误
            }
            
        }
    }
    
    // MARK: 清除颜色
    func clearCellSelectedColor() {
        self.collectionView?.reloadData()
    }
}
