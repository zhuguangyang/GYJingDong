//
//  DetailViewController.swift
//  GYJingDong
//
//  Created by zhuguangyang on 16/6/21.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit

class DetailViewController: GYBaseWebViewController {

    var url: String?
    {
        didSet{
            loadWebView(url!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

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
