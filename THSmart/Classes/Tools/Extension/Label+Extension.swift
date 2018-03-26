//
//  Label+Extension.swift
//  百味迹忆
//
//  Created by YueAndy on 2017/6/16.
//  Copyright © 2017年 YueAndy. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(title : String, sizeFont : CGFloat , color :UIColor) {
        self.init()
        text = title
        font = UIFont.systemFont(ofSize: sizeFont)
        textColor = color
        sizeToFit()
    }
    
    
//    func getLabHieght(labStr : String , labTextSize : CGFloat ,width : CGFloat) -> CGFloat {
//
//        let labelText: NSString = labStr as NSString
//
//
//        let size = CGSize(width: width, height: 999)
//        let strSize = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: labTextSize)], context: nil).size
//
//        return strSize.height
//    }
//
//    func getLabWidth(labStr : String , labTextSize : CGFloat ,height : CGFloat) -> CGFloat {
//
//        let labelText: NSString = labStr as NSString
//        let size = CGSize(width: 999, height: height)
//        let strSize = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: labTextSize)], context: nil).size
//
//        return strSize.width
//    }
}
