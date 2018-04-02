//
//  WebViewVC.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/30.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class WebViewVC: BaseViewController {
    
    var myTitle: String = ""
    var urlStr: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension WebViewVC {
    func setupUI()  {
        self.title = myTitle
        //创建
        let wkWebView = WKWebView()
        
        //设置位置和大小
        wkWebView.frame = self.view.frame;
    
        //添加
        self.view.addSubview(wkWebView)
        
        //请求
        /*
         open func load(_ request: URLRequest) -> WKNavigation?
         */
        
        wkWebView.load(NSURLRequest(url: NSURL(string:urlStr)! as URL) as URLRequest)
    }
}
