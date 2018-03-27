//
//  XMAlbumsVC.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/26.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class XMAlbumsVC: BaseViewController {

    public var tag_name = "儿歌大全"
    
    let cellID = "AlbumCellID"
    private lazy var viewModel: XMAlbumsVM = XMAlbumsVM()
    
    @IBOutlet weak var tv_albums: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension XMAlbumsVC {
    func setupUI() {
        self.title = "专辑"
        XMReqMgr.sharedInstance().registerXMReqInfo(withKey: kXMAppKey, appSecret: kXMSecret)
        XMReqMgr.sharedInstance().delegate = self
        
        tv_albums .register(UINib.init(nibName: "AlbumCell", bundle: nil), forCellReuseIdentifier: cellID)
        viewModel.requestData(tag_name: tag_name) {
            self.tv_albums.reloadData()
        }
    }
}

extension XMAlbumsVC: XMReqDelegate {
    func didXMInitReqOK(_ result: Bool) {
        
    }
    
    func didXMInitReqFail(_ respModel: XMErrorModel!) {
        
    }
}

extension XMAlbumsVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! AlbumCell
        cell.model = viewModel.albums[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextVc = XMAlbumDetaliVC()
        nextVc.album = viewModel.albums[indexPath.row]
        nextVc.listSort = .AlbumDetail
        navigationController?.pushViewController(nextVc, animated: true)
    }
}
