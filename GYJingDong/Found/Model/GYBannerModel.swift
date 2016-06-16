//
//  GYBannerModel.swift
//  GYJingDong
//
//  Created by zhuguangyang on 16/6/16.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit

class GYBannerModel:NSObject {
    
    /// 图片地址
    var imageNamed:String = ""
    /// 标题
    var labelText:String = ""
    /// 链接地址
    var link: String = ""
    /// 链接标题
    var link_title:String = ""
    //    var title:String = ""
    /*
     //字典转模型
     init(dict: [String: AnyObject]) {
     super.init()
     setValuesForKeysWithDictionary(dict)
     }
     override func setValue(value: AnyObject?, forUndefinedKey key: String) {
     
     }
     
     /// 打印当前模型
     var properties = ["imageNamed","labelText","link","link_title"]
     
     override var description: String {
     let dict = dictionaryWithValuesForKeys(properties)
     return "\(dict)"
     
     }
     */
}