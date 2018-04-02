//
//  Equipment.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/28.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class Equipment: NSObject {
    @objc var devId:String = ""
    @objc var devName:String = ""
    @objc var lastConnectTime:String = ""
    @objc var lastConnectUserName:String = ""
    @objc var relayServerIpAddr:String = ""
    @objc var relayServerPort:String = ""
    @objc var wxShairTitle:String = ""
    @objc var wxShairDesc:String = ""
    @objc var videoScoreReference:String = ""
    @objc var isOwner:String = ""
    @objc var devType:String = ""
    @objc var jpgPath:String = ""
    @objc var intelligentInteractionIpAddr:String = ""
    @objc var intelligentInteractionPort:String = ""
    @objc var isDefaultIpc:String = ""
    @objc var voiceMessageTipType:String = ""
    @objc var isAllowedRealTimeView:String = ""
    @objc var validTime:String = ""
    @objc var voiceMessageTipTypeForFamily:String = ""
    @objc var voiceMessageTipTypeForFriend:String = ""
    @objc var noticeForFamilyMsg:String = ""
    @objc var noticeForFriendMsg:String = ""
    @objc var province:String = ""
    @objc var city:String = ""
    @objc var region:String = ""
    @objc var school:String = ""
    @objc var className:String = ""
    @objc var friendGroupId:String = ""
    @objc var friendGroupName:String = ""
    @objc var lastFamilyMsgTime:String = ""
    @objc var lastFriendMsgTime:String = ""
    
    @objc var unreadFamilyMsgCount:Int = 0
    @objc var unreadFriendMsgCount:Int = 0
    
    init(dict:[String:Any]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValuesForKeys(_ keyedValues: [String : Any]) {
        for key in keyedValues.keys {
            self.setValue(keyedValues[key], forKey: key)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "IPC_id" {
            self.devId = (value as? String) ?? ""
        }
        
        if key == "IPC_name" {
            self.devName = (value as? String) ?? ""
        }
        
        if key == "class" {
            self.className = (value as? String) ?? ""
        }
    }
}
