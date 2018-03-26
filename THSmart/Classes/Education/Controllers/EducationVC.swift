//
//  EducationVC.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/21.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class EducationVC: BaseViewController {
    
    @IBOutlet weak var pageView: PageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageView.titles = ["儿歌","故事","国学","英文"]
        pageView.maxShow = CGFloat(pageView.titles.count)

        let tagNames = ["儿歌大全","爱听故事","国学启蒙","英文磨耳朵"]
        var childrenVC:[BaseViewController] = [BaseViewController]()
        for tagName in tagNames {
            let childVC = XMAlbumsVC()
            childVC.tag_name = tagName
            childrenVC.append(childVC)
            self.addChildViewController(childVC)
        }
        
        pageView.childrenVC = childrenVC
        
        pageView.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
