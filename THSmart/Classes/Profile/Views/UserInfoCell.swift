//
//  UserInfoCell.swift
//  THSmart
//
//  Created by YueAndy on 2018/4/3.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class UserInfoCell: BaseTableViewCell {
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_content: UILabel!
    @IBOutlet weak var imgv_headImg: UIImageView!
    
    var model :UserInfoModel?{
        didSet {
            guard let m = model else {
                return
            }
            label_title.text = m.title
            label_content.text = m.content
            
            guard (m.imgUrlStr != nil) else { return }
            imgv_headImg.kf.setImage(with: URL(string: m.imgUrlStr!), placeholder: #imageLiteral(resourceName: "default_1and1_small"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
