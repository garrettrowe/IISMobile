//
//  ViewController.swift
//  Bluemix Viewer
//
//  Created by Garrett Rowe on 12/14/14.
//  Copyright (c) 2014 Garrett Rowe. All rights reserved.
//

import UIKit

let IBM_SYNC_ENABLE = true

class ViewController: UIViewController {
    @IBOutlet var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.synchronize()

        if let urlstr = userDefaults.stringForKey("infocloud_url"){
            let url = NSURL(string: urlstr)
            let request = NSURLRequest(URL: url!)
            webView.loadRequest(request)
        }
        else{
            let url = NSURL(string: "http://infocloud.mybluemix.net/")
            let request = NSURLRequest(URL: url!)
            webView.loadRequest(request)
        }
        self.view.addSubview(webView)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

