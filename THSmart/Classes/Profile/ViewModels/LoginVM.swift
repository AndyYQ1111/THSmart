//
//  LoginVM.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/29.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit
import Toast_Swift

class LoginVM: NSObject {
    
}

extension LoginVM {
    func requestData(userId:String,password:String,finishCallback:@escaping ()->()) {
        
        let infoDictionary = Bundle.main.infoDictionary!
//        let appDisplayName = infoDictionary["CFBundleDisplayName"] //程序名称
        let majorVersion = infoDictionary["CFBundleShortVersionString"]//主程序版本号
//        let minorVersion = infoDictionary["CFBundleVersion"]//版本号（内部标示）
        let appVersion = majorVersion as! String
        
        let urlString = "user.php?act=login"
        let paraDic:  [String : Any] = ["user_id":userId,"password":password,"PhoneOSType":"ios","APPVersion":appVersion as Any,"getuiCID":""]
        
        NetWorkTools.requestData(method: .POST, urlString: urlString, paraDic: paraDic) { (object) in
            let result = object["result"] as? String ?? ""
            if result == "ok" {
                UserDefaults.standard.set(userId, forKey: "user_id")
                UserDefaults.standard.set(password, forKey: "password")
                UserDefaults.standard.set(object["userBasicInfo"] as Any, forKey: "userBasicInfo")
                UserDefaults.standard.set(true, forKey: "notFirstLogin")
                UserDefaults.standard.synchronize()
             
                let arr : [AnyObject] = (object["userDevListInfo"]) as! [AnyObject]
                
                for dic in arr {
                    let dev:Equipment = Equipment.init(dict: dic as! [String : Any])
                    Global.shared.devList.append(dev)
                }
                
                finishCallback()
            }else if result == "passwordError" {
                Global.shared.currentViewController()?.view.makeToast("用户名或密码错误")
            }else if result == "userIdNotExist" {
                Global.shared.currentViewController()?.view.makeToast("用户名不存在")
            }else if result == "versionOutOfDate" {
                 Global.shared.currentViewController()?.view.makeToast("用户名不存在")
            }
        }
    }
    
    func updateApp()  {
        let alertC = UIAlertController(title: "当前版本已经过时，是否更新最版本?", message: nil, preferredStyle: .alert)
        
        let alertA = UIAlertAction(title: "确定", style: .cancel) { (action) in
            let url = URL.init(string: "https://itunes.apple.com/cn/app/%E5%A4%A9%E6%B5%B7%E6%99%BA%E8%83%BD/id1359016670?mt=8")

            UIApplication.shared.openURL(url!)
            exit(0)
        }
        alertC.addAction(alertA)
        Global.shared.currentViewController()?.present(alertC, animated: true, completion: nil)
    }
}
