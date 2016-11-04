//
//  LoginViewController.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/11/3.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let portraitImageView :UIImageView = UIImageView.init(image: #imageLiteral(resourceName: "loginLogo"))
    let emailImageView : UIImageView = UIImageView.init(image: #imageLiteral(resourceName: "email"))
    let passwordImageView :UIImageView = UIImageView.init(image: #imageLiteral(resourceName: "password"))
    let emailTextField = UITextField.init()
    let passwordTextField = UITextField.init()
    let loginBtn = UIButton.init(type: UIButtonType.custom)
    let tipLabel = UILabel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        self.initView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        self.view.addSubview(self.portraitImageView)
        self.view.addSubview(self.emailImageView)
        self.view.addSubview(self.passwordImageView)
        self.view.addSubview(self.emailTextField)
        self.view.addSubview(self.passwordTextField)
        self.view.addSubview(self.loginBtn)
        self.view.addSubview(self.tipLabel)
        self.view.backgroundColor = UITool.uniformColor()
        
        self.portraitImageView.contentMode = .scaleAspectFit
        self.emailImageView.contentMode = .scaleAspectFit
        self.passwordImageView.contentMode = .scaleAspectFit
        
        self.emailTextField.keyboardType = .emailAddress
        self.emailTextField.placeholder = "邮箱"
        self.emailTextField.textColor = UIColor.blue
        self.emailTextField.borderStyle = .none
        
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField.placeholder = "密码"
        self.passwordTextField.textColor = UIColor.blue
        self.passwordTextField.borderStyle = .none
        // todo  如果已经存储用户名和密码需要设置 text
        
        self.loginBtn.isEnabled = (self.passwordTextField.text != nil && self.passwordTextField.text != nil) ? true : false
        self.loginBtn.setTitle("登录", for: .normal)
        self.loginBtn.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        self.loginBtn.backgroundColor = UIColor.red
        self.loginBtn.setTitleColor(UIColor.white, for: .normal)
        self.loginBtn.layer.cornerRadius = 5
        self.loginBtn.layer.masksToBounds = true
        
        self.tipLabel.numberOfLines = 0
        self.tipLabel.lineBreakMode = .byWordWrapping
        
        self.addConstraintForSubviews()
    }
    
    // MARK:  约束
    func addConstraintForSubviews() {
        unowned let weakSelf = self
        self.portraitImageView.snp.makeConstraints { (make) in
            make.top.equalTo(weakSelf.view.snp.top).offset(154)
            make.centerX.equalTo(weakSelf.view)
            make.height.width.equalTo(100)
        }
        
        self.emailImageView.snp.makeConstraints { (make) in
            make.left.equalTo(weakSelf.view.snp.left).offset(40)
            make.top.equalTo(weakSelf.portraitImageView.snp.bottom).offset(20)
            make.height.width.equalTo(40)
        }
        
        self.emailTextField.snp.makeConstraints { (make) in
            make.left.equalTo(weakSelf.emailImageView.snp.right).offset(10)
            make.top.height.equalTo(weakSelf.emailImageView)
            make.right.equalTo(weakSelf.view.snp.right).offset(-10)
        }
        
        self.passwordImageView.snp.makeConstraints { (make) in
            make.left.equalTo(weakSelf.emailImageView.snp.left)
            make.top.equalTo(weakSelf.emailImageView.snp.bottom).offset(15)
            make.height.width.equalTo(40)
        }
        
        self.passwordTextField.snp.makeConstraints { (make) in
            make.left.equalTo(weakSelf.passwordImageView.snp.right).offset(10)
            make.right.equalTo(weakSelf.view.snp.right).offset(-10)
            make.top.height.equalTo(weakSelf.passwordImageView)
        }
        
        self.loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(weakSelf.passwordTextField.snp.bottom).offset(15)
            make.left.equalTo(weakSelf.passwordImageView.snp.left)
            make.right.equalTo(weakSelf.view.snp.right).offset(-40)
            make.height.equalTo(40)
        }
        
        self.tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(weakSelf.loginBtn.snp.bottom).offset(10)
            make.left.right.equalTo(weakSelf.loginBtn)
        }
    }
    
    //MARK: loginAction
    func loginAction() {
        
    }

}
