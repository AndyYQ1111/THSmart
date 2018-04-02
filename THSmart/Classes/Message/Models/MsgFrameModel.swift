//
//  MsgFrameModel.swift
//  THSmart
//
//  Created by YueAndy on 2018/4/2.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class MsgFrameModel: NSObject {
    
    var timeFrame:CGRect?
    var timeLenFrame:CGRect?
    var messageBtnFrame:CGRect?
    var iconFrame:CGRect?
    var redLabFrame:CGRect?
    var rowHeight:CGFloat?
    var leftSide:Bool = true
    var isVoice:Bool = false
    
    var gMsgModel : GroupMsgModel? {
        didSet{
            let space:CGFloat = 10
            //时间
            let timeX:CGFloat = 0
            let timeY:CGFloat = 0
            let timeW:CGFloat = KScreenW
            let timeH:CGFloat = 30
            
            if !(gMsgModel?.isHideTime)! {
                self.timeFrame = CGRect(x: timeX, y: timeY, width: timeW, height: timeH)
            }
            
            //头像
            var iconX:CGFloat = 0
            let iconW:CGFloat = 50;
            let iconH:CGFloat = 50;
            let iconY:CGFloat = (timeFrame?.maxY) ?? 0  + space
            
            if gMsgModel?.position == 0 {
                self.leftSide = true
            }else{
                self.leftSide = false
            }
            
            if leftSide {
                iconX = space
            }else{
                iconX = KScreenW - iconW - space
            }
            
            self.iconFrame = CGRect(x: iconX, y: iconY, width: iconW, height: iconH)
            var textSize = CGSize.zero
            if gMsgModel?.messageType == "1" {
                textSize = (gMsgModel?.messageContent.size(font: UIFont.systemFont(ofSize: 14), maxSize: CGSize(width: KScreenW - 160, height: CGFloat(MAXFLOAT))))!
            }else {
                textSize = ("语音".size(font: UIFont.systemFont(ofSize: 14), maxSize: CGSize(width: KScreenW - 160, height: CGFloat(MAXFLOAT))))
            }
            
//            CGFloat redLabX;
//            CGFloat redLabW;
            
            let btnSize: CGSize = CGSize(width: textSize.width + 20 * 2, height: textSize.height + 20 * 2)
            let btnY = iconY
            var btnX:CGFloat = 0
            
            if leftSide {
                btnX = (self.iconFrame?.maxX)! + space
            }else{
                btnX = KScreenW - 2 * space - iconW - btnSize.width
            }
            
            if(gMsgModel?.messageType == "1"){
                self.isVoice = false
                
                messageBtnFrame = CGRect(x: btnX, y: btnY, width: btnSize.width, height: btnSize.height)
                timeLenFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
                redLabFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
            }else{
                self.isVoice = true
            
                messageBtnFrame = CGRect(x: btnX, y: btnY, width: btnSize.width, height: 44)
                timeLenFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
                redLabFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
            }
            
            let iconMaxY:CGFloat = (iconFrame?.maxY)!
            let btnMaxY:CGFloat = (messageBtnFrame?.maxY)!
            self.rowHeight = (iconMaxY > btnMaxY ? iconMaxY : btnMaxY) + space
        }
    }
}
