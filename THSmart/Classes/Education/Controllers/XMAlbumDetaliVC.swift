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
    
    var searchController:UISearchController?
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.searchController?.searchBar.isHidden = false
        self.searchController?.isActive = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.searchController?.searchBar.isHidden = true
        self.searchController?.isActive = false
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
            addSearchBar()
        }
        
        addNavItem()
    }
    
    //添加自定义导航栏
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
    
    func addSearchBar()  {

        let searchController = UISearchController(searchResultsController: nil)
    
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        
        // 搜索框
        let bar = searchController.searchBar
        // 样式
        bar.barStyle = .default
        // 设置光标及取消按钮的颜色
        bar.tintColor = UIColor(red: 0.12, green: 0.74, blue: 0.13, alpha: 1.0)
        // 设置代理
        bar.delegate = self
        // 去除背景及上下两条横线
        bar.setBackgroundImage(UIImage.init(color: UIColor.groupTableViewBackground), for: .any, barMetrics: .default)
        
        bar.setValue("取消", forKey: "_cancelButtonText")
        
        bar.placeholder = "输入歌曲名称"
        
        // 因为在当前控制器展示结果, 所以不需要这个透明视图
        searchController.dimsBackgroundDuringPresentation = false
        // 默认为YES,控制搜索时，是否隐藏导航栏
        searchController.hidesNavigationBarDuringPresentation = false
        
        // 需要进行强引用 searchController
        self.searchController = searchController
        
        
        // 将搜索框视图�设置为tableView的tableHeaderView
        tv_track.tableHeaderView = searchController.searchBar
    }
}

extension XMAlbumDetaliVC: UISearchBarDelegate, UISearchResultsUpdating,UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchStr: String = searchController.searchBar.text ?? ""
        if searchStr.count > 0 {
            ///请求数据
            viewModel.requestSearchData(page: 1, searchStr: searchStr, finishCallBack: {
                self.tv_track.reloadData()
            })
        }
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        self.searchController?.isActive = false
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
            ///左导航栏按钮设置
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
            
            ///点击事件
            
            
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
