//
//  GroupMsgCell.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/30.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class GroupMsgCell: BaseTableViewCell {
    
    var btnMsg: UIButton?
    var imgIcon: UIImageView?
    
    var msgFM:MsgFrameModel? {
        didSet{
            self.imgIcon?.frame = (msgFM?.iconFrame)!
            self.imgIcon?.kf.setImage(with: URL(string: (msgFM?.gMsgModel?.headImg)!))
    
            self.btnMsg?.frame = (msgFM?.messageBtnFrame)!
            if (msgFM?.isVoice)! {
                self.btnMsg?.setTitle("语音", for: .normal)
            }else{
                self.btnMsg?.setTitle(msgFM?.gMsgModel?.messageContent, for: .normal)
            }
            
            if (msgFM?.leftSide)! {
                self.btnMsg?.setBackgroundImage(#imageLiteral(resourceName: "chat_recive_nor"), for: .normal)
            }else{
                self.btnMsg?.setBackgroundImage(#imageLiteral(resourceName: "chat_send_press_pic"), for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //消息按钮
        let msgBtn = UIButton()
        msgBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        contentView.addSubview(msgBtn)
        msgBtn.titleLabel?.numberOfLines = 0
        msgBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        msgBtn.setTitleColor(UIColor.black, for: .normal)
        self.btnMsg = msgBtn
        
        //头像
        let img_icon = UIImageView()
        contentView.addSubview(img_icon)
        self.imgIcon = img_icon
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
