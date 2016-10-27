//
//  LogOverride.swift
//  GYJingDong
//
//  Created by zhuguangyang on 16/6/20.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit

/**
 打印Log日志
 */
// func print<T>(message: T,file: String = #file,method: String = #function, line: Int = #line)
//{
//    //        #if DEBUG
//    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
//    //        #endif
//}


class LogOverride: NSObject {
    
    /**
     打印Log日志
     */
    static  func printLog<T>(_ message: T,file: String = #file,method: String = #function, line: Int = #line)
    {
        //        #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
        //        #endif
    }
    
}
