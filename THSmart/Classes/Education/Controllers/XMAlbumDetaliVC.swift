//
//  XMAlbumDetaliVC.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/23.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit
import SnapKit

enum XMTrackListSort {
    case AlbumDetail,History,Search
}

class XMAlbumDetaliVC: BaseViewController {
    @IBOutlet weak var tv_track: UITableView!
    @IBOutlet var view_head: UIView!
    @IBOutlet weak var imgv_album: UIImageView!
    @IBOutlet weak var label_albumTitle: UILabel!
    @IBOutlet weak var label_albumTheme: UILabel!
    @IBOutlet weak var label_playNum: UILabel!
    @IBOutlet weak var label_albumSort: UILabel!
    
    var album :XMAlbum?
    var listSort:XMTrackListSort = .AlbumDetail
    
    lazy var itemBtn: UIButton = {
        var btn = UIButton(title: "多选", imageName: nil, titleSize: 15)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    let cellId = "TrackCellID"
    private var viewModel: XMAlbumDetaliVM = XMAlbumDetaliVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension XMAlbumDetaliVC {
    func setupUI() {
        
        tv_track.register(UINib.init(nibName: "TrackCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        ///专辑详情
        if listSort == .AlbumDetail {
            self.title = "专辑详情"
            view_head.frame = CGRect(x: 0, y: 0, width: KScreenW, height: 106)
            tv_track.addSubview(view_head)
            tv_track.separatorInset = UIEdgeInsets(top: 106, left: 0, bottom: 0, right: 0)
            
            imgv_album.kf.setImage(with: URL.init(string: (album?.coverUrlSmall)!), placeholder: #imageLiteral(resourceName: "default_1and1_small"), options: nil, progressBlock: nil, completionHandler: nil)
            label_albumTitle.text = album?.albumTitle
            label_playNum.text = String(album?.playCount ?? 0)
            label_albumSort.text = album?.albumTags
            
            ///请求数据
            viewModel.requestAlbumData(album_id: (album?.albumId)!, page: 1) {
                self.tv_track.reloadData()
            }
        }else if listSort == .History {
            self.title = "播放历史"
            ///请求数据
            viewModel.getHistory {
                self.tv_track.reloadData()
            }
        }else {
            self.title = "搜索"
            ///请求数据
            viewModel.requestSearchData(page: 1, searchStr: "小", finishCallBack: {
                self.tv_track.reloadData()
            })
        }
        
        addNavItem()
    }
    
    func addNavItem() {
        let item = UIBarButtonItem(customView: itemBtn)
        self.navigationItem.rightBarButtonItem = item
    }
    
    @objc func btnClick() {
        if itemBtn.titleLabel?.text == "多选" {
            itemBtn.setTitle("取消", for: .normal)
            viewModel.multi_choice = true
        }else if itemBtn.titleLabel?.text == "取消" || itemBtn.titleLabel?.text == "点播"{
            itemBtn.setTitle("多选", for: .normal)
            viewModel.multi_choice = false
        }
        
        tv_track.reloadData()
    }
}

extension XMAlbumDetaliVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.trackModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TrackCell
        cell.multi_choice = viewModel.multi_choice
        cell.model = viewModel.trackModels[indexPath.row]
        cell.choiceCallBack = {
            if self.itemBtn.titleLabel?.text == "取消" || self.itemBtn.titleLabel?.text == "点播"{
                var hasSelected = false
                for trackModel in self.viewModel.trackModels {
                    if trackModel.select {
                        hasSelected = true
                        break
                    }
                }
                if hasSelected {
                    self.itemBtn.setTitle("点播", for: .normal)
                }else {
                    self.itemBtn.setTitle("取消", for: .normal)
                }
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mv = MusicPlayerView.shared
        mv.playMusic(trackIndex: indexPath.row, tracks: viewModel.tracks)
        mv.frame = CGRect(x: 0, y: KScreenH - 52, width: KScreenW, height: 52)
        view.addSubview(MusicPlayerView.shared)
        tv_track.snp.updateConstraints { (make) in
            make.bottom.equalTo(mv.snp.top)
        }
    }
}
