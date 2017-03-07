//
//  MeVC.swift
//  GYJingDong
//
//  Created by zhuguangyang on 16/6/15.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit
import Alamofire

class MeVC: GYBaseViewController {
    
    let viewModel = FoundViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Alamofire.download("http://dldir1.qq.com/qqfile/QQforMac/QQ_V4.2.4.dmg", to: nil)
        .downloadProgress { (progress) in
            print(progress)
            print(progress.completedUnitCount)
        }

    }
}
