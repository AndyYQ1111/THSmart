//
//  XMAlbumDetaliVC.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/23.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class XMAlbumDetaliVC: BaseViewController {
    @IBOutlet weak var tv_track: UITableView!
    @IBOutlet var view_head: UIView!
    @IBOutlet weak var imgv_album: UIImageView!
    @IBOutlet weak var label_albumTitle: UILabel!
    @IBOutlet weak var label_albumTheme: UILabel!
    @IBOutlet weak var label_playNum: UILabel!
    @IBOutlet weak var label_albumSort: UILabel!
    
    var album :XMAlbum?
    
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
        self.title = "专辑详情"
        view_head.frame = CGRect(x: 0, y: 0, width: KScreenW, height: 106)
        tv_track.register(UINib.init(nibName: "TrackCell", bundle: nil), forCellReuseIdentifier: cellId)
        tv_track.addSubview(view_head)
        tv_track.separatorInset = UIEdgeInsets(top: 106, left: 0, bottom: 0, right: 0)
        
        imgv_album.kf.setImage(with: URL.init(string: (album?.coverUrlSmall)!), placeholder: #imageLiteral(resourceName: "default_1and1_small"), options: nil, progressBlock: nil, completionHandler: nil)
        label_albumTitle.text = album?.albumTitle
        label_playNum.text = String(album?.playCount ?? 0)
        label_albumSort.text = album?.albumTags
        
        viewModel.requestData(album_id: (album?.albumId)!, page: 1) {
            self.tv_track.reloadData()
        }
    }
}

extension XMAlbumDetaliVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TrackCell
        cell.model = viewModel.tracks[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MusicPlayerView.shared.playMusic(trackIndex: indexPath.row, tracks: viewModel.tracks)
        MusicPlayerView.shared.frame = CGRect(x: 0, y: KScreenH - 52, width: KScreenW, height: 52)
        view.addSubview(MusicPlayerView.shared)
    }
}
