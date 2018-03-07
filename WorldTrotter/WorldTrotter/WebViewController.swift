//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Doan Le Thieu on 3/7/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.bignerdranch.com/")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}
