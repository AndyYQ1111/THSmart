//
//  XMAlbumsViewModel.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/23.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class XMAlbumsVM: NSObject {
    lazy var albums:[XMAlbum] = [XMAlbum]()
}

extension XMAlbumsVM {
    func requestData(page:Int = 1,tag_name:String,finishCallBack:@escaping ()->()){
        let paraDic: [String :Any] = ["category_id":6,
                                      "count":20,
                                      "page":page,
                                      "calc_dimension":3,
                                      "tag_name":tag_name
        ]
        XMReqMgr.sharedInstance().requestXMData(.albumsList, params: paraDic) { (result, error) in
            if !(error != nil) {
                self.showData(result: result as AnyObject,page: page)
                finishCallBack()
            }else{

            }
        }

    }
    
    func showData(result:AnyObject,page:Int) {
        var tempArr:[XMAlbum] = [XMAlbum]()
        if result is Dictionary<String, Any> {
            var dic = result as! Dictionary<String, Any>
            let tempAlbums = dic["albums"] as! Array<AnyObject>
            for dict in tempAlbums {
                let model =  XMAlbum.init(dictionary: dict as! [AnyHashable : Any])
                tempArr.append(model!)
            }
        }
        
//        if(tempArr.count<20){
//            [tv_ablums.mj_footer endRefreshingWithNoMoreData];
//        }else{
//            [tv_ablums.mj_footer endRefreshing];
//        }
        
        if page == 1 {
            albums.removeAll()
        }
        albums += tempArr
    }
}
