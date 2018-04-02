//
//  XMAlbumDetaliVM.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/26.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class TrackModel: NSObject {
    var track: XMTrack?
    var select: Bool = false
}

class XMAlbumDetaliVM: NSObject {
    var tracks: [XMTrack] = [XMTrack]()
    var trackModels: [TrackModel] = [TrackModel]()
    ///选择项的数组，选中为1，未选中为0
    var selects: [Int] = [Int]()
    var multi_choice:Bool = false
}

extension XMAlbumDetaliVM {
    func requestAlbumData(album_id: Int, page: Int,finishCallBack:@escaping ()->()) {
        let paraDic: [String: Any] = ["album_id":album_id,"count":20,"page":page]
        
        XMReqMgr.sharedInstance().requestXMData(XMReqType.albumsBrowse, params: paraDic) { (result, error) in
            if !(error != nil) {
                self.showData(result: result as AnyObject,page: page)
                finishCallBack()
            }else{
                
            }
        }
    }
    
    //点播
    func requestDB() {
//        var  URLStr: String = "http://\(dev.intelligentInteractionIpAddr):\(dev.intelligentInteractionPort)/goform/RecvCmdSvr"
//        NSDictionary *paraDic = @{@"id":@"123456",@"name":@"1201",@"type":@"Intelligent-CS",@"cameraid":dev.devId,@"flage":@"1",@"urlList":urlStr};
        
        
        NetWorkTools.requestData(method: .POST, urlString: "") { (result) in
            
        }
    }
    
    //停播
    func requestTB() {
        
    }
    
    
    
    func getHistory(finishCallBack:()->()) {
        guard let tempArr = UserDefaults.standard.array(forKey: KXMHistorys) else {
            return
        }
        for dic in tempArr {
            let track: XMTrack = XMTrack(dictionary: dic as! [AnyHashable : Any])
            let trackModel:TrackModel = TrackModel()
            trackModel.track = track
            tracks.append(track)
            trackModels.append(trackModel)
        }
        finishCallBack()
    }
    
    func requestSearchData(page: Int,searchStr: String,finishCallBack:@escaping ()->()) {
        
        let paraDic: [String: Any] = ["calc_dimension":3,"count":20,"page":page,"category_id":6,"q":searchStr]
        
        XMReqMgr.sharedInstance().requestXMData(XMReqType.searchTracks, params: paraDic) { (result, error) in
            if !(error != nil) {
                self.showData(result: result as AnyObject,page: page)
                finishCallBack()
            }else{
                
            }
        }
    }
    
    func showData(result:AnyObject,page:Int) {
        var tempArr:[TrackModel] = [TrackModel]()
        if result is Dictionary<String, Any> {
            var dic = result as! Dictionary<String, Any>
            let tempAlbums = dic["tracks"] as! Array<AnyObject>
            for dict in tempAlbums {
                let model =  XMTrack.init(dictionary: dict as! [AnyHashable : Any])
                let trackModel:TrackModel = TrackModel()
                trackModel.track = model
                tempArr.append(trackModel)
            }
        }
        
        if page == 1 {
            trackModels.removeAll()
        }
        trackModels += tempArr
        
        for trackModel in trackModels {
            tracks.append(trackModel.track!)
        }
    }
}


