//
//  CodeImageViewController.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/31.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit
import Alamofire

class CodeImageViewController: UIViewController {

    let imageView :UIImageView? = UIImageView.init(image: #imageLiteral(resourceName: "portrait_loading"))
    var imageUrl :String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UITool.uniformColor()
        self.view.addSubview(self.imageView!)
        unowned let weakSelf = self
        let minValue = self.view.height > self.view.width ? self.view.width : self.view.height
        self.imageView?.snp.makeConstraints({ (make) in
            make.center.equalTo(weakSelf.view.snp.center)
            make.height.width.equalTo(minValue)
        })
        self.imageView?.contentMode = .scaleAspectFit
        self.fetchObject()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchObject() {
        unowned let weakSelf = self
        Alamofire.request(self.imageUrl!).responseImage { (response) in
            if response.result.isSuccess {
                weakSelf.imageView?.image = response.result.value
            }
        }
    }

}
