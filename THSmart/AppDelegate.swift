//
//  AppDelegate.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/20.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

let kXMAppKey = "401c897d783b0e3b7998c727f43cb76c"

let kXMSecret = "99cdbf92a1a5093e2014eae894ccf7e3"



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        xmRegister()
        
        return true
    }
}

////喜马拉雅
//extension AppDelegate:XMLYAuthorizeDelegate {
//
//    func xmRegister() {
//        XMLYAuthorize.shareInstance().initWithAppkey(kXMAppKey, appSecret: kXMSecret, appRedirectUri: "", appPackageId: "", appName: "", delegate: self)
//    }
//
//    func onAuthorizeSuccess(_ responseType: XmlyResponseType, responseData authorizeModel: XMLYAuthorizeModel!) {
//        if (responseType == .AuthorizeSuccess) {
//            print("喜马拉雅SDK授权成功")
//        }
//    }
//
//    func onAuthorizeFail(_ errorType: XmlyResponseType, errorInfo info: [AnyHashable : Any]!) {
//        print("喜马拉雅SDK授权失败")
//    }
//
//    func onRequestQRCodeSuccess(_ responseType: XmlyResponseType, responseData imageData: Data!) {}
//
//    func onRequestQRCodeFail(_ errorType: XmlyResponseType, errorInfo info: [AnyHashable : Any]!) {}
//}

