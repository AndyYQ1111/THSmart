//
//  MessageHomeVC.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/20.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class MessageHomeVC: BaseViewController {

    @IBOutlet weak var tv_msgHome: UITableView!
    
    var msgArr : [MsgHomeModel] = []
    
    private lazy var viewModel : MessageHomeViewModel = MessageHomeViewModel()
    
    let cellID = "MsgHomeCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        viewModel.requestData {
//            tv_msgHome.reloadData()
//        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tv_msgHome.contentInset = UIEdgeInsets.zero
        tv_msgHome.scrollIndicatorInsets = UIEdgeInsets.zero
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MessageHomeVC {
    func setupUI() {
        self.title = "消息"
        tv_msgHome.register(UINib.init(nibName: "MsgHomeCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        let model0 = MsgHomeModel()
        model0.jpgPath = "icon_shouye_jiaren"
        model0.content = "0个家人"
        model0.title = "家人"
        model0.timeCreate = ""
        model0.unReadCount = ""
        
        let model1 = MsgHomeModel()
        model1.jpgPath = "icon_shouye_haoyou"
        model1.content = "0个好友"
        model1.title = "好友"
        model1.timeCreate = ""
        model1.unReadCount = ""

        msgArr.append(model0)
        msgArr.append(model1)
    }
}

extension MessageHomeVC : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return msgArr.count
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MsgHomeCell
        if(indexPath.section == 0){
            cell.model = msgArr[indexPath.row]
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(GroupMsgVC(), animated: true)
    }
}
