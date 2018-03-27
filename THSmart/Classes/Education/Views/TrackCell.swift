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
    
    var choiceCallBack: ()->() = {}
    
    var multi_choice: Bool = false
    
    var model: TrackModel? {
        didSet{
            imgv.kf.setImage(with: URL.init(string: (model?.track?.coverUrlSmall)!), placeholder: #imageLiteral(resourceName: "default_1and1_small"), options: nil, progressBlock: nil, completionHandler: nil)
            label_title.text = model?.track?.trackTitle
            if multi_choice {
                btn_operate.setImage(#imageLiteral(resourceName: "icon_shebei_weixuanzhogn"), for: .normal)
                btn_operate.setImage(#imageLiteral(resourceName: "icon_sheibei_xuanzhong"), for: .selected)
            }else {
                btn_operate.setImage(#imageLiteral(resourceName: "icon_dianji_n"), for: .normal)
                btn_operate.setImage(#imageLiteral(resourceName: "icon_dianji_s"), for: .selected)
            }
            
            if model?.select == false {
                btn_operate.isSelected = false
            } else {
                btn_operate.isSelected = true
            }
        }
    }
    
    @IBAction func click(_ sender: UIButton) {
        btn_operate.isSelected = !btn_operate.isSelected
        model?.select = btn_operate.isSelected
        choiceCallBack()
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
