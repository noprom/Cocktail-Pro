//
//  Baike.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/10/1.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import UIKit

class Baike: UIViewController {
    
    //网页的控件
    @IBOutlet var webPage:UIWebView!
    
    //显示的网址
    var URL:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        let request = NSURLRequest(URL: NSURL(string: URL)!)
        webPage.loadRequest(request)
    }
    
    //点击返回
    @IBAction func goBack(sender:UINavigationItem){
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
