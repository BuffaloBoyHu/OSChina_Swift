//
//  LoginViewController.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/11/3.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit
import SAMKeychain
import MBProgressHUD
import Alamofire

let EMAIL_KEY = "Email"
let PASSWORD_KEY = "PassWord"

class LoginViewController: UIViewController,UITextFieldDelegate {
    
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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: .plain, target: self, action: #selector(backAction))
        self.initView()
        
        // 监听键盘
        let showKeyBoardSelector :Selector = #selector(showKeyBoard)
        let hideKeyBoardSelector :Selector = #selector(hideKeyBoard)
        NotificationCenter.default.addObserver(self, selector: showKeyBoardSelector, name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: hideKeyBoardSelector, name: .UIKeyboardWillHide, object: nil)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapGestureAction))
        self.view.addGestureRecognizer(tapGesture)
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
        
        let userDefaults :UserDefaults = UserDefaults.standard
        
        self.emailTextField.keyboardType = .emailAddress
        self.emailTextField.placeholder = "邮箱"
        self.emailTextField.textColor = UIColor.blue
        self.emailTextField.borderStyle = .none
        self.emailTextField.text = userDefaults.object(forKey: EMAIL_KEY) as! String?
        self.emailTextField.delegate = self
        self.emailTextField.clearButtonMode = .whileEditing
        self.emailTextField.addTarget(self, action: #selector(returnOnKeyboard(sender:)), for: .editingDidEndOnExit)
        
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField.placeholder = "密码"
        self.passwordTextField.textColor = UIColor.blue
        self.passwordTextField.borderStyle = .none
        let passWordStr = SAMKeychain.password(forService: PASSWORD_KEY, account: EMAIL_KEY) 
        self.passwordTextField.text = passWordStr
        self.passwordTextField.delegate = self
        self.passwordTextField.clearButtonMode = .whileEditing
        self.passwordTextField.addTarget(self, action: #selector(returnOnKeyboard(sender:)), for: .editingDidEndOnExit)
        
        // todo  如果已经存储用户名和密码需要设置 text
        
        self.loginBtn.isEnabled = (!(self.passwordTextField.text?.characters.isEmpty)! && !(self.passwordTextField.text?.isEmpty)!) ? true : false
        self.loginBtn.setTitle("登录", for: .normal)
        self.loginBtn.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        self.loginBtn.backgroundColor = UIColor.red
        self.loginBtn.setTitleColor(UIColor.white, for: .normal)
        self.loginBtn.layer.cornerRadius = 5
        self.loginBtn.layer.masksToBounds = true
        
        self.tipLabel.numberOfLines = 0
        self.tipLabel.lineBreakMode = .byWordWrapping
        self.tipLabel.text = "tips:\n\t请使用Git@OSC的push邮箱和密码登录\n\t注册请前往 https://git.oschina.net"
        
        self.addConstraintForSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let userDefaults = UserDefaults.standard
        let email :String? = userDefaults.value(forKey: "User_email") as? String
        if email != nil {
            let passWordStr = SAMKeychain.password(forService: "Git@OSC", account: email!)
            self.emailTextField.text = email
            self.passwordTextField.text = passWordStr == nil ? "" : passWordStr
        }
        
        if (self.emailTextField.text?.isEmpty)! || (self.passwordTextField.text?.isEmpty)! {
            self.loginBtn.isEnabled = false
            self.loginBtn.alpha = 0.4
        }else {
            self.loginBtn.isEnabled = true
            self.loginBtn.alpha = 1
        }

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
    
    //MARK: 登录
    func loginAction() {
        unowned let weakSelf = self
        let progressHUD = MBProgressHUD.showAdded(to: UIApplication.shared.windows.last!, animated: true)
        progressHUD.mode = .customView
        progressHUD.isUserInteractionEnabled = false
        
        let urlString = "\(GITAPI_HTTPS_PREFIX)session"
        let parameters = ["email":self.emailTextField.text!,"password":self.passwordTextField.text!]
        
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.isSuccess {
                if let dict = response.result.value as? Dictionary<String,Any> {
                    progressHUD.label.text = "登录成功"
                    progressHUD.hide(animated: true, afterDelay: 3)
                    let userProfile = UserProfile.init(dict: dict)
                    userProfile.saveUserProfile()
                    SAMKeychain.setPassword(weakSelf.passwordTextField.text!, forService: "Git@OSC", account: weakSelf.emailTextField.text!)
                    weakSelf.hideKeyBoard()
                    weakSelf.backAction()
                    
                }else {
                    progressHUD.label.text = "登录失败"
                    progressHUD.detailsLabel.text = "请检查用户名或密码是否正确"
                    progressHUD.hide(animated: true, afterDelay: 3)
                }
                
            }else {
                progressHUD.label.text = "登录失败"
                progressHUD.detailsLabel.text = "请检查网络是否正常"
                progressHUD.hide(animated: true, afterDelay: 3)
            }
        }
    }
    
    //MARK:UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let anotherStr = textField == self.emailTextField ? self.passwordTextField.text :self.emailTextField.text
        let currentStr = textField.text as NSString?
        currentStr?.replacingCharacters(in: range, with: string)
        if (currentStr?.length)! > 0 && !(anotherStr?.isEmpty)! {
            self.loginBtn.isEnabled = true
            self.loginBtn.alpha = 1
        }else {
            self.loginBtn.isEnabled = false
            self.loginBtn.alpha = 0.4
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.loginBtn.isEnabled = false
        self.loginBtn.alpha = 0.4
        return true
    }
    
    // MARK:  键盘
    func showKeyBoard() {

        var frame = self.view.frame
        if frame.origin.y >= 0 {
            UIView.beginAnimations("ShowKeyBoard", context: nil)
            UIView.setAnimationDuration(0.3)
            frame.origin.y -= 100
            self.view.frame = frame
            UIView.commitAnimations()
        }

    }
    
    func hideKeyBoard() {
        UIView.beginAnimations("HideKeyBoard", context: nil)
        UIView.setAnimationDuration(0.3)
        var frame = self.view.frame
        frame.origin.y = 0
        self.view.frame = frame
        UIView.commitAnimations()
    }
    
    func tapGestureAction() {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.hideKeyBoard()
    }
    
    func returnOnKeyboard(sender :UITextField) {
        if self.emailTextField == sender {
            self.passwordTextField.becomeFirstResponder()
        }else if self.passwordTextField == sender{
            self.hideKeyBoard()
            self.loginAction()
        }
    }
    
    //MARK: 返回
    func backAction() {
        self.navigationController?.dismiss(animated: true, completion: { 
            
        })
    }

}
