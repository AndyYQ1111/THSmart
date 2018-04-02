//
//  RegisterVC2.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/29.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class RegisterVC2: BaseViewController {

    @IBOutlet weak var tf_pw: UITextField!
    @IBOutlet weak var tf_userName: UITextField!
    @IBOutlet weak var btn_register: UIButton!
    @IBOutlet weak var btn_agree: UIButton!
    
    var phone:String = ""
    
    let viewModel:RegisterVM = RegisterVM()
    let loginVM: LoginVM = LoginVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        btn_register.setGradualBackground(cgColors: kBlueGradientColors)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        if tf_pw.text?.count == 0  {
            view.makeToast("密码不能为空")
            tf_pw.becomeFirstResponder()
            return
        }
        
        if tf_userName.text?.count == 0 {
            view.makeToast("昵称不能为空")
            tf_userName.becomeFirstResponder()
            return
        }
        
        if !btn_agree.isSelected {
            view.makeToast("必须统一用户协议")
            return
        }
        
        let paraDic = ["user_phone":phone,"user_pwd":tf_pw.text!,"email":"","user_name":tf_userName.text!] as [String : Any]
        viewModel.register(paraDic: paraDic) {
            self.loginVM.requestData(userId: self.phone, password: self.tf_pw.text!, finishCallback: {
                UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            })
        }
    }
    @IBAction func agreeAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func protocolAction(_ sender: UIButton) {
        let nextVC = WebViewVC()
        nextVC.myTitle = "注册协议"
        nextVC.urlStr = "http://thzn_td_app.100memory.com/userHelp.php?act=userRegisterProtocal"
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
