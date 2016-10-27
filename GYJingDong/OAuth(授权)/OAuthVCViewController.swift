//
//  OAuthVCViewController.swift
//  GYJingDong
//
//  Created by zhuguangyang on 16/6/15.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit
import Alamofire

class OAuthVCViewController: UIViewController ,UIWebViewDelegate{

    
    
    
    override func loadView() {
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlStr =  "https://oauth.jd.com/oauth/authorize?response_type=code&client_id=75A707E9376A80A0C3BD592A2DB3FDDB&redirect_uri=urn:ietf:wg:oauth:2.0:oob"
        let url = URL(string: urlStr)
        let request = URLRequest(url: url!)
        
        webView.loadRequest(request)
        print("GY")
        
    }
    
    //MARK: - 懒加载
    fileprivate lazy var webView: UIWebView = {
        let wv = UIWebView()
        wv.delegate = self
        
        return wv
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
