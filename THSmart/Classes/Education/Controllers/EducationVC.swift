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
    
    lazy var searchBtn: UIButton = {
    var btn = UIButton(title: "请输入歌曲名称", imageName: "icon_zaojiao_sousuo", titleSize: 14)
        btn.frame = CGRect(x: 0, y: 0, width: KScreenW - 60, height: 32) //
        btn.backgroundColor = UIColor.white
        btn.setTitleColor(UIColor.init(r: 149, g: 149, b: 149), for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    
    @objc func btnClick()  {
        let nextVc = XMAlbumDetaliVC()
        nextVc.listSort = .Search
        navigationController?.pushViewController(nextVc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension EducationVC {
    func setupUI() {
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
        
        addNavItem()
    }
    
    func addNavItem() {
        let btn = UIButton(title: "历史", imageName: "icon_lishi", titleSize: 9)
        btn.imgUp()
        btn.addTarget(self, action: #selector(rightItemClick), for: .touchUpInside)
        let item = UIBarButtonItem(customView: btn)
        self.navigationItem.rightBarButtonItem = item
        self.navigationItem.titleView = self.searchBtn
    }
    
    @objc func rightItemClick() {
        let nextVc = XMAlbumDetaliVC()
        nextVc.listSort = .History
        navigationController?.pushViewController(nextVc, animated: true)
    }
}
