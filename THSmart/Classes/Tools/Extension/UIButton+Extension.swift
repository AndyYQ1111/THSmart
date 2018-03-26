//
//  UIButton+Extension.swift
//  百味迹忆
//
//  Created by YueAndy on 2017/6/16.
//  Copyright © 2017年 YueAndy. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(title : String ,imageName : String, titleSize : CGFloat, highlightedColor :UIColor) {
        self.init(type: .custom)
        setTitle(title, for: .normal)
        
        let img = UIImage.init(named: imageName)
        setImage(img, for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        setTitleColor(highlightedColor, for: .highlighted)
        titleLabel?.font = UIFont.systemFont(ofSize: titleSize)
        sizeToFit()
    }
}
