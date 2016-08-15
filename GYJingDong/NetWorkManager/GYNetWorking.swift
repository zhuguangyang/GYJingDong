//
//  GYNetWorking.swift
//  Alamofire3.0封装
//
//  Created by zhuguangyang on 16/6/14.
//  Copyright © 2016年 Giant. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class GYNetWorking: NSObject {
    
    required  init?(NetWorkParmas: NSDictionary) {
        self.NetWorkParmas = NetWorkParmas
        super.init()
    }
    
    /**获取单利*/
    static var defaultManager = GYNetWorking(NetWorkParmas: NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("NetWorkPlist", ofType: "plist")!)!)
    
    /**
     GET请求
     
     - parameter pathKey: 路径
     - parameter paramas: 参数
     - parameter sucess:  成功回调
     - parameter failure: 失败回调
     */
    func GET(pathKey: String,paramas: NSDictionary?,sucess:((AnyObject) -> Void)?,failure:((NSError) -> Void)?) {
        let url = webRoot + path[pathKey]!
        print("url" + "\(url)")
        Alamofire.request(.GET, url, parameters: paramas as? [String : AnyObject], encoding: .URL, headers: nil).responseJSON { (let obj) in
            switch obj.result {
            case .Success(let value):
                //                print(value)
                sucess?(value)
            case .Failure(let error):
                failure?(error)
            }
        }
    }
    
    /**
     POST请求
     
     - parameter pathKey: 路径
     - parameter paramas: 参数
     - parameter sucess:  成功回调
     - parameter failure: 失败回调
     */
    func POST(pathKey: String,paramas: NSDictionary?,sucess:((AnyObject) -> Void)?,failure:((NSError) -> Void)?) {
        let url = webRoot + path[pathKey]!
        Alamofire.request(.POST, url, parameters: paramas as? [String : AnyObject], encoding: .URL, headers: nil).responseJSON { (let obj) in
            switch obj.result {
            case .Success(let value):
                sucess?(value)
            case .Failure(let error):
                failure?(error)
            }
        }
    }
    
    private let NetWorkParmas: NSDictionary
    
    /// 接口前缀
    var webRoot: String {
        return NetWorkParmas["WebRoot"] as! String
    }
    
    /// 接口后缀路径
    var path:[String : String] {
        return NetWorkParmas["Path"] as! [String : String]
    }
}
