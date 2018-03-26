//
//  MsgModel.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/20.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class MsgModel : Codable{
    var content: String?
    var jpgPath: String?
    var msgType: String?
    var parameters: String?
    var title: String?
    var timeCreate: String?
    var msgId: String?
    var unReadCount: String?
}
