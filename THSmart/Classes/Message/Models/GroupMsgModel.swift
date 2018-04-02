//
//  GroupMsgModel.swift
//  THSmart
//
//  Created by YueAndy on 2018/4/2.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class GroupMsgModel: NSObject {
    @objc var timeStamp: String = ""
    @objc var messageType: String = ""
    @objc var messageFrom: String = ""
    @objc var userName: String = ""
    @objc var headImg: String = ""
    @objc var messageContent: String = ""
    @objc var timeLength: String = ""
    @objc var isRead: String = ""
    @objc var msgId: String = ""
    @objc var devId: String = ""
    @objc var position: Int = 0
    @objc var isHideTime: Bool = true
    override func setValuesForKeys(_ keyedValues: [String : Any]) {
        for key in keyedValues.keys {
            setValue(keyedValues[key], forKey: key)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
