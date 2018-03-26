//
//  TrackCell.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/23.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class TrackCell: BaseTableViewCell {
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var btn_operate: UIButton!
    @IBOutlet weak var imgv: UIImageView!
    
    var model: XMTrack? {
        didSet{
            imgv.kf.setImage(with: URL.init(string: (model?.coverUrlSmall)!), placeholder: #imageLiteral(resourceName: "default_1and1_small"), options: nil, progressBlock: nil, completionHandler: nil)
            label_title.text = model?.trackTitle
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
