//
//  LoginVC.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/28.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class LoginVC: BaseViewController {
    
    @IBOutlet weak var tf_userId: UITextField!
    @IBOutlet weak var tf_password: UITextField!
    @IBOutlet weak var view_bg: UIView!
    @IBOutlet weak var btn_login: UIButton!
    
    var viewModel:LoginVM = LoginVM()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view_bg.setGradualBackground(cgColors: kBlueGradientColors)
        btn_login.setGradualBackground(cgColors:kBlueGradientColors)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
 
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.keyWindow?.backgroundColor = UIColor.clear
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        view.endEditing(true)
        
        if tf_userId.text?.count == 0 {
            let alertC = UIAlertController(title: "用户名不能为空", message: nil, preferredStyle: .alert)
            let alertA = UIAlertAction(title: "确定", style: .default, handler: nil)
            alertC.addAction(alertA)
            self.present(alertC, animated: true, completion: {
                self.tf_userId.becomeFirstResponder()
            });
            return;
        }
        
        if tf_password.text?.count == 0 {
            let alertC = UIAlertController(title: "密码不能为空", message: nil, preferredStyle: .alert)
            let alertA = UIAlertAction(title: "确定", style: .default, handler: nil)
            alertC.addAction(alertA)
            self.present(alertC, animated: true, completion: {
                self.tf_password.becomeFirstResponder()
            });
            return;
        }
        
        viewModel.requestData(userId: tf_userId.text ?? "", password: tf_password.text ?? "") {
            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        navigationController?.pushViewController(RegisterVC(), animated: true)
    }
}

extension LoginVC {
    func setupUI() {
        tf_userId.leftView = UIImageView(image: #imageLiteral(resourceName: "denglu07"))
        tf_password.leftView = UIImageView(image:#imageLiteral(resourceName: "denglu10"))
        tf_userId.leftViewMode = .always
        tf_password.leftViewMode = .always
        
        tf_userId.text = (UserDefaults.standard.object(forKey: "user_id") as? String ?? "" )
        tf_password.text = (UserDefaults.standard.object(forKey: "password") as? String ?? "")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
