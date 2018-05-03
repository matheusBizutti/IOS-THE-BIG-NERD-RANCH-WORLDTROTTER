//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by MATHEUS BIZUTTI on 25/04/18.
//  Copyright © 2018 T1aluno04. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate{
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.bignerdranch.com/")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}
