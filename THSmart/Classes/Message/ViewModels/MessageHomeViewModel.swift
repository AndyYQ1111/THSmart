//
//  MessageHomeViewModel.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/20.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class MessageHomeViewModel {
    //MARK:- 懒加载属性
    lazy var msgs : [MsgModel] = [MsgModel]()
}

extension MessageHomeViewModel {
    func requestData(finishCallBack:()->()) {
        let paraDic:[String:Any] = ["city":"",
            "class":"",
            "countPerPage":100,
            "devId":"FMV8GMLSU7QWKI43TPKC",
            "friendGroupId":27,
            "pageIndex":1,
            "province":"",
            "region":"",
            "school":"",
            "user_id":"17778472310"
        ]

        NetWorkTools.requestData(method: .POST, urlString: "systemMsg.php?act=getSystemMsg" ,paraDic: paraDic) { (reslut) in
            guard let reslutDict = reslut as? [String : NSObject] else { return }
            guard let dataArr = reslutDict["data"] as? [[String : NSObject]] else { return }
    
            for dict in dataArr {
                let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                let decode = JSONDecoder()
                do {
                    let msgModel = try decode.decode(MsgModel.self, from: jsonData)
                    self.msgs.append(msgModel)
                    print("解析成功:\(msgModel.jpgPath ?? "")")
                } catch  {
                    print("解析失败:\(error)")
                }
            }
        }
    }
}
