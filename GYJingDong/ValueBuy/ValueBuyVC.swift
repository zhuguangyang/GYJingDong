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
        GYSQLite.sharedInstance.createSQLite()
        GYSQLite.sharedInstance.insertDB("GiantForJade@1622233.com", named: "DWYDA")
        //        GYSQLite.sharedInstance.deleteSpecificDB("ZGY")
        //        GYSQLite.sharedInstance.findAll()
        //        GYSQLite.sharedInstance.updateSpecialDB("DWYDA")
        GYSQLite.sharedInstance.findSpecialDB("DWYDA")
        GYSQLite.sharedInstance.addColumnFunc()
    }
    
    func searchAction() {               
        print(#function)
    }
    
}
