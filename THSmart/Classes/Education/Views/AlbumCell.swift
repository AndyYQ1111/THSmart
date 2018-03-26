//
//  AlbumCell.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/23.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class AlbumCell: BaseTableViewCell {

    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_des: UILabel!
    @IBOutlet weak var label_num: UILabel!
    @IBOutlet weak var imgv: UIImageView!
    
    var model:XMAlbum?{
        didSet{
            label_title.text = model?.albumTitle
            label_des.text = model?.albumIntro
            label_num.text = String(model?.includeTrackCount ?? 0)
            imgv.kf.setImage(with: URL.init(string: (model?.coverUrlSmall)!), placeholder: #imageLiteral(resourceName: "default_1and1_small"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
