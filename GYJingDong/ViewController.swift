//
//  ViewController.swift
//  GYJingDong
//
//  Created by zhuguangyang on 16/6/14.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request("https://api.500px.com/v1/photos").responseJSON { (data) in
            print(data.data)
        }
        
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

