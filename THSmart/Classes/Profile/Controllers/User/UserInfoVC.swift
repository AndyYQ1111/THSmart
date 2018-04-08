//
//  UserInfoVC.swift
//  THSmart
//
//  Created by YueAndy on 2018/4/3.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class UserInfoVC: BaseViewController {
    @IBOutlet weak var tv_userInfo: UITableView!
    
    let viewModel = UserInfoViewModel()
    
    let cellId = "UserInfoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UserInfoVC {
    func setupUI() {
        navigationController?.navigationBar.isHidden = false
        self.title = "个人信息"
        tv_userInfo.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        
        viewModel.requestData {
            tv_userInfo.reloadData()
        }
    }
}

extension UserInfoVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.infos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserInfoCell
        cell.model = viewModel.infos[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 72
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            PhotoCenter.shared.chooseImg()
            PhotoCenter.shared.finishCallBack = { (img) in
                let cell = tableView.cellForRow(at: indexPath) as! UserInfoCell
                cell.imgv_headImg.image = img
            }
        }
        else if indexPath.row == 1 {
            let alertC = UIAlertController(title: nil, message: "新昵称", preferredStyle: .alert)
            alertC .addTextField { (tf_userName) in
                tf_userName.placeholder = "请填写新昵称"
            }
        
            let action0 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let action1 = UIAlertAction(title: "确定", style: .default) { (action) in
                let userName:String = alertC.textFields?.first?.text ?? ""
                if userName.count == 0 {
                    self.view.makeToast("请填写新名字")
                }else{
                    //去修改昵称
                }
            }
            
            alertC.addAction(action0)
            alertC.addAction(action1)
            self.present(alertC, animated: true, completion: nil)
        }
    }
}
