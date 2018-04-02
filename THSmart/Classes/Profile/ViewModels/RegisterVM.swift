//
//  RegisterVM.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/29.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class RegisterVM: NSObject {

}

extension RegisterVM {
    func requestData(phone:String,finishCallback:@escaping () -> ())  {
        let urlStr = "user.php?act=is_registered"
        let paraDic = ["user_id":phone] as [String : Any]
        
        NetWorkTools.requestData(method: .POST, urlString: urlStr, paraDic: paraDic) { (object) in
            
            let result = object["result"] as? String ?? ""
            
            if result == "ok" {
                
                let paraDic1 = ["userPhoneNum":phone,"timeStamp":Date.timeIntervalBetween1970AndReferenceDate] as [String : Any]
            
                let urlStr1 = "smsService/smsService.php?act=sendSmsIdCode"
                
                NetWorkTools.requestData(method: .POST, urlString: urlStr1, paraDic: paraDic1, finishCallBack: { (object1) in
                    let result1 = object1["result"] as? String ?? ""
                    if result1 == "ok" {
                       Global.shared.currentViewController()?.view.makeToast("验证码已经发送请注意查收")
                       finishCallback()
                    }
                })
            }else {
                Global.shared.currentViewController()?.view.makeToast("该手机号已被注册")
            }
        }
    }
    
    func checkCode(paraDic:[String:Any],finishCallback:@escaping ()->()) {
        let urlStr = "smsService/smsService.php?act=smsIdCodeCheck"
        
        NetWorkTools.requestData(method: .POST, urlString: urlStr, paraDic: paraDic) { (object) in
            let result = object["result"] as? String ?? ""
            if result == "ok" {
                finishCallback()
            }
        }
    }
    
    func register(paraDic:[String :Any],finishCallback:@escaping ()-> ()) {
        let urlStr = "user.php?act=register"
        
        NetWorkTools.requestData(method: .POST, urlString: urlStr, paraDic: paraDic) { (object) in
            let result = object["result"] as? String ?? ""
            if result == "ok" {
                Global.shared.currentViewController()?.view.makeToast("注册成功，正在登陆...")
                finishCallback()
            }else {
                Global.shared.currentViewController()?.view.makeToast("该手机号码已经被注册过")
            }
        }
    }
}
