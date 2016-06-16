//
//  ValueBuyVC.swift
//  GYJingDong
//
//  Created by zhuguangyang on 16/6/15.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit

class ValueBuyVC: GYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        creatLeftBarBtn("", imageName: "SecondHand_Search", target: self, action: #selector(ValueBuyVC.searchAction))
        creatRightBarBtn("", imageName: "dingyueSele", target: self, action: #selector(ValueBuyVC.searchAction))
    }
    
    func searchAction() {               
        print(#function)
    }
    
}
