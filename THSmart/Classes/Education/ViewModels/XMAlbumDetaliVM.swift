//
//  XMAlbumDetaliVM.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/26.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class XMAlbumDetaliVM: NSObject {
    var tracks: [XMTrack] = [XMTrack]()
}

extension XMAlbumDetaliVM {
    func requestData(album_id: Int, page: Int,finishCallBack:@escaping ()->()) {
        let paraDic: [String: Any] = ["album_id":album_id,"count":20,"page":page]
        
        XMReqMgr.sharedInstance().requestXMData(XMReqType.albumsBrowse, params: paraDic) { (result, error) in
            if !(error != nil) {
                self.showData(result: result as AnyObject,page: page)
                finishCallBack()
            }else{
                
            }
        }
    }
    
    func showData(result:AnyObject,page:Int) {
        var tempArr:[XMTrack] = [XMTrack]()
        if result is Dictionary<String, Any> {
            var dic = result as! Dictionary<String, Any>
            let tempAlbums = dic["tracks"] as! Array<AnyObject>
            for dict in tempAlbums {
                let model =  XMTrack.init(dictionary: dict as! [AnyHashable : Any])
                tempArr.append(model!)
            }
        }
        
        if page == 1 {
            tracks.removeAll()
        }
        tracks += tempArr
    }
}
