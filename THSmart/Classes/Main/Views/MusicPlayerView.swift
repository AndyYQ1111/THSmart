//
//  MusicPlayerView.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/26.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class MusicPlayerView: UIView {
    
    @IBOutlet weak var label_trackTitle: UILabel!
    @IBOutlet weak var btn_play: UIButton!
    @IBOutlet weak var hySlider: HYSlider!
    
    var tracks: [XMTrack] = [XMTrack]()
    var trackIndex: Int = 0
    
    //创建单例
    static let shared = MusicPlayerView()

    private var contentView:UIView!
    //初始化时将xib中的view添加进来
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = loadViewFromNib()
        contentView.frame = CGRect(origin: CGPoint.zero, size: bounds.size)
        addSubview(contentView)
        setupUI()
    }
    
    //初始化时将xib中的view添加进来
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = loadViewFromNib()
        contentView.frame = CGRect(origin: CGPoint.zero, size: bounds.size)
        addSubview(contentView)
        setupUI()
        //初始化属性配置
    }

    private func loadViewFromNib() -> UIView {
        let className = type(of: self)
        let bundle = Bundle(for: className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        let nib = UINib(nibName: name!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}

extension MusicPlayerView {
    func setupUI() {
        btn_play.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        hySlider.isUserInteractionEnabled = true
        hySlider.currentValueColor = UIColor(r: 37, g: 112, b: 255)
        hySlider.currentSliderValue = 0
        hySlider.showTouchView = false;
        hySlider.showScrollTextView = false;
        hySlider.delegate = self;
        
        XMSDKPlayer.shared().setAutoNexTrack(true)
        XMSDKPlayer.shared().trackPlayDelegate = self
        XMSDKPlayer.shared().setVolume(0.5)
        XMSDKPlayer.shared().setPlayMode(XMSDKPlayMode.track)
        XMSDKPlayer.shared().setTrackPlayMode(XMSDKTrackPlayMode.XMTrackPlayerModeList)
    }
    
    @objc func btnClick() {
        if(musicStata() == XMSDKPlayerState.playing){
            btn_play.isSelected = false
            pauseMusic()
        }else{
            btn_play.isSelected = true
            playMusic(trackIndex: trackIndex, tracks: tracks)
        }
        
        
//            XMSDKPlayerStatePlaying = 0,         //正在播放
//            XMSDKPlayerStatePaused,              //暂停
//        XMSDKPlayerStateStop
    }
    
    func playMusic(trackIndex: Int,tracks: [XMTrack]) {
        btn_play.isSelected = true
        self.tracks = tracks
        self.trackIndex = trackIndex
        XMSDKPlayer.shared().play(with: tracks[trackIndex], playlist: tracks)
    }
    
    func pauseMusic()  {
        XMSDKPlayer.shared().pauseTrackPlay()
    }
    
    func stopMusic() {
        XMSDKPlayer.shared().stopTrackPlay()
    }
    
    func musicStata() -> XMSDKPlayerState {
        return XMSDKPlayer.shared().playerState
    }
}

extension MusicPlayerView: XMTrackPlayerDelegate {
    func xmTrackPlayerWillPlaying() {
        print("将要播放")
        let currentTrack = XMSDKPlayer.shared().currentTrack()
        for (index,value) in tracks.enumerated() {
            if currentTrack == value {
                trackIndex = index
            }
        }
        label_trackTitle.text = currentTrack?.trackTitle ?? ""
        hySlider.maxValue = CGFloat(currentTrack?.duration ?? 0)
    }
    
    func xmTrackPlayerDidPlaying() {
        print("正在播放。。。。。")
    }
    
    func xmTrackPlayNotifyProcess(_ percent: CGFloat, currentSecond: UInt) {
        hySlider.currentSliderValue = CGFloat(currentSecond)
    }
}

extension MusicPlayerView: HYSliderDelegate {
    func hySlider(_ hySlider: HYSlider!, didScrollValue value: CGFloat) {
        XMSDKPlayer.shared().seek(toTime: value)
    }
}
