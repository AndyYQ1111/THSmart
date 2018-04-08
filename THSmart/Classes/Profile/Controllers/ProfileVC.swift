//
//  Profile.swift
//  THSmart
//
//  Created by YueAndy on 2018/4/3.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class ProfileVC: BaseViewController {
    
    @IBOutlet weak var btn_info: UIButton!
    @IBOutlet weak var btn_dev: UIButton!
    @IBOutlet weak var btn_setting: UIButton!
    @IBOutlet weak var btn_help: UIButton!
    @IBOutlet weak var imgv_headImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    @IBAction func userInfoAction(_ sender: UIButton) {
        navigationController?.pushViewController(UserInfoVC(), animated: true)
    }
    @IBAction func devsAction(_ sender: UIButton) {
        
    }
    @IBAction func helpAction(_ sender: UIButton) {
        
    }
    @IBAction func setAction(_ sender: UIButton) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ProfileVC {
    func setupUI() {
        self.title = "我的"
        imgv_headImg.layer.masksToBounds = true
        imgv_headImg.layer.cornerRadius = 40
        btn_info.imgUp()
        btn_dev.imgUp()
        btn_setting.imgUp()
        btn_help.imgUp()
    }
}
