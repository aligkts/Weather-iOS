//
//  InfoViewController.swift
//  Weather
//
//  Created by Ali Goktas on 13.06.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation
import WebKit
import UIKit

class InfoViewController: UIViewController, WKUIDelegate {

    @IBOutlet var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = Bundle.main.url(forResource: "appinfo", withExtension: "html") else {
            return
        }
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }
    
}
