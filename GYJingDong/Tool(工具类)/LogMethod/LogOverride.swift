//
//  LogOverride.swift
//  GYJingDong
//
//  Created by zhuguangyang on 16/6/20.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit

class LogOverride: NSObject {
    
    /**
     打印Log日志
     */
    static  func printLog<T>(message: T,file: String = #file,method: String = #function, line: Int = #line)
    {
        //        #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
        //        #endif
    }
}
