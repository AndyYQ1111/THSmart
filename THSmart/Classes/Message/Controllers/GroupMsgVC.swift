//
//  GroupMsgVC.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/20.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class GroupMsgVC: BaseViewController {
    let viewModel: GroupMsgViewModel = GroupMsgViewModel()
    
    @IBOutlet weak var tv_groupMsg: UITableView!
    let cellId = "GroupMsgCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension GroupMsgVC {
    func setupUI()  {
        tv_groupMsg.register(UINib.init(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        viewModel.requestData {
            self.tv_groupMsg.reloadData()
        }
    }
}

extension GroupMsgVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.msgs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! GroupMsgCell
        cell.msgFM = viewModel.msgs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.msgs[indexPath.row].rowHeight!
    }
}
