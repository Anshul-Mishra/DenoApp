//
//  HomeViewController.swift
//  DemoApp
//
//  Created by Anshul on 8/3/19.
//  Copyright © 2019 Anshul. All rights reserved.
//

import UIKit
import WebKit

class HomeViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var token : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let tokenStr = token {
            let urlStr = "https://mckinleyrice.com?token=" + tokenStr
            
            self.webView.load(NSURLRequest(url: NSURL(string: urlStr)! as URL) as URLRequest)
            
            self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)

        }
        
        
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "loading" {
            
            if webView.isLoading {
                
                activityIndicator.startAnimating()
                activityIndicator.isHidden = false
            } else {
                
                activityIndicator.stopAnimating()
            }
            
        }
        
        
    }
    
}
