//
//  GroupMsgViewModel.swift
//  THSmart
//
//  Created by YueAndy on 2018/4/2.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

let kUserID = UserDefaults.standard.object(forKey: "user_id") as! String
let kDefaultDev = Global.shared.defaultDev!


class GroupMsgViewModel: NSObject {
    var msgs:[MsgFrameModel] = [MsgFrameModel]()
}
extension GroupMsgViewModel {
//    NSString *urlStr = @"interact.php?act=getMessages";
//    NSString *user_id = [kUserDefault objectForKey:@"user_id"];
//    Equipment *dev = [GlobalInit sharedInstance].defaultDev;
//
//    NSDictionary *paraDic = @{@"user_id":user_id,@"devId":dev.devId,@"groupType":self.groupType,@"friendGroupId":dev.friendGroupId,@"countPerPage":@"10",@"pageIndex":[NSString stringWithFormat:@"%d",page]};
    
    
    func requestData(finishCallBack:@escaping ()->()) {
        
        let urlStr = "interact.php?act=getMessages"
        let paraDic = ["user_id":kUserID,"devId":kDefaultDev.devId,"groupType":1,"friendGroupId":kDefaultDev.friendGroupId,"countPerPage":10,"pageIndex":1] as [String : Any]
        NetWorkTools.requestData(method: .POST, urlString: urlStr, paraDic: paraDic) { (object) in
            guard let tempArr = object["data"] as? [[String:Any]] else { return }
            for dic in tempArr {
                let mFM = MsgFrameModel()
                let model = GroupMsgModel()
                model.setValuesForKeys(dic)
                mFM.gMsgModel = model
                self.msgs.append(mFM)
            }
                
            finishCallBack()
        }
    }
}
