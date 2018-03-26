//
//  MsgHomeCell0.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/20.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit
import Kingfisher

class MsgHomeCell: BaseTableViewCell {

    @IBOutlet weak var imgv_head: UIImageView!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_des: UILabel!
    @IBOutlet weak var label_time: UILabel!
    
    var model: MsgModel?{
        didSet{
            let url = URL(string: (model?.jpgPath)!)
            label_title.text = model?.title
            label_des.text = model?.content
            
            imgv_head.kf.setImage(with: url, placeholder: UIImage.init(named: (model?.jpgPath)!), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
