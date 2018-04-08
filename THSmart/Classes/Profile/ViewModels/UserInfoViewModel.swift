//
//  UserInfoViewModel.swift
//  THSmart
//
//  Created by YueAndy on 2018/4/3.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class UserInfoViewModel: NSObject {
    var infos:[UserInfoModel] = []
}

extension UserInfoViewModel {
    func requestData(finishCallBack:()->())  {
        let userBasicInfo:[String : Any] = UserDefaults.standard.dictionary(forKey: "userBasicInfo")!
        let imgUrlStr = userBasicInfo["headimgurl"]
        let userName = userBasicInfo["user_name"]
        let sexStr = (userBasicInfo["sex"] as! String) == "0" ? "男":"女"
        let userId = UserDefaults.standard.object(forKey: "user_id")
        let model = UserInfoModel()
        model.title = "头像"
        model.content = ""
        model.imgUrlStr = (imgUrlStr as! String)
        
        let model1 = UserInfoModel()
        model1.title = "昵称"
        model1.content = userName as! String
        
        let model2 = UserInfoModel()
        model2.title = "账号"
        model2.content = userId as! String
        
        let model3 = UserInfoModel()
        model3.title = "性别"
        model3.content = sexStr
        
        infos.append(model)
        infos.append(model1)
        infos.append(model2)
        infos.append(model3)
    }
}
