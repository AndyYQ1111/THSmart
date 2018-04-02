//
//  Global.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/29.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

import Toast_Swift

class Global: NSObject {
    
    var devList:[Equipment] = [Equipment]()
    
    private var _defaultDev: Equipment?
    
    var defaultDev:Equipment? {
        set{
            _defaultDev = newValue
        }
        get{
            _defaultDev = nil
            if devList.count > 0 {
                for dev in devList {
                    if dev.isDefaultIpc == "1" {
                        _defaultDev = dev
                    }
                }
            }
            return _defaultDev
        }
    }
    
    static let shared = Global()
}

extension Global {
    func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}
