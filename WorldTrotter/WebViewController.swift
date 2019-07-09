//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by bughh on 2019/6/30.
//  Copyright © 2019 bughh. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    var webView: WKWebView!
    
    //loadView() is overridden to create a view controller’s view programmatically.
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(webView!)")
        let url = URL(string:"https://www.baidu.com/")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
}
